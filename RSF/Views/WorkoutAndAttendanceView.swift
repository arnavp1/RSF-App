import SwiftUI

struct WorkoutAndAttendanceView: View {
    @State private var attendanceDate = Date()
    @State private var workoutDuration = ""
    @State private var selectedWorkout: Workout? = nil
    @State private var workouts: [Workout] = UserDefaultsManager.loadWorkouts()
    @State private var attendanceList: [Attendance] = UserDefaultsManager.loadAttendance()

    // Toggle states for collapsing/expanding sections
    @State private var showWorkouts = false
    @State private var showAttendanceHistory = false
    @State private var editingAttendance: Attendance? = nil

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {

                    // MARK: Attendance Tracker
                    sectionContainer {
                        Text("📋 Attendance Tracker")
                            .font(.headline)
                            .padding(.bottom, 5)

                        DatePicker("Date", selection: $attendanceDate, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                        TextField("Duration (minutes)", text: $workoutDuration)
                            .keyboardType(.numberPad)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                        HStack {
                            Spacer()

                            Picker("Select Workout (Optional)", selection: $selectedWorkout) {
                                Text("No Workout").tag(Optional<Workout>(nil))
                                ForEach(workouts) { workout in
                                    Text(workout.name).tag(Optional(workout))
                                }
                            }
                            .pickerStyle(.menu)
                            .padding(10)
                            .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
                            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                            Button("Check In") {
                                guard let duration = Int(workoutDuration) else { return }
                                let newAttendance = Attendance(date: attendanceDate, workout: selectedWorkout, duration: duration)
                                attendanceList.append(newAttendance)
                                UserDefaultsManager.saveAttendance(attendanceList)
                                workoutDuration = ""
                                selectedWorkout = nil
                            }
                            .buttonStyle(.borderedProminent)
                            .padding(.horizontal, 10)
                            .fixedSize()

                            Spacer()
                        }
                    }

                    // MARK: Attendance History with Edit Feature
                    sectionContainer {
                        DisclosureGroup(isExpanded: $showAttendanceHistory) {
                            ForEach(attendanceList) { attendance in
                                HStack {
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text("Date: \(attendance.date.formatted(date: .abbreviated, time: .omitted))")
                                            .font(.headline)
                                        if let workout = attendance.workout {
                                            Text("Workout: \(workout.name)")
                                        }
                                        Text("Duration: \(attendance.duration) mins")
                                    }
                                    .frame(maxWidth: .infinity, alignment: .leading)

                                    // Edit Button
                                    Button(action: {
                                        editingAttendance = attendance
                                    }) {
                                        Image(systemName: "pencil.circle.fill")
                                            .foregroundColor(.blue)
                                            .font(.title2)
                                    }
                                    .buttonStyle(.plain)

                                    // Delete Button
                                    Button(action: {
                                        if let index = attendanceList.firstIndex(where: { $0.id == attendance.id }) {
                                            attendanceList.remove(at: index)
                                            UserDefaultsManager.saveAttendance(attendanceList)
                                        }
                                    }) {
                                        Image(systemName: "trash")
                                            .foregroundColor(.red)
                                            .padding(8)
                                    }
                                    .buttonStyle(.plain)
                                }
                                .padding(.vertical, 5)
                            }
                        } label: {
                            Text("📊 Attendance History")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }

                    // MARK: Workout Management
                    sectionContainer {
                        DisclosureGroup(isExpanded: $showWorkouts) {
                            WorkoutManagerView(workouts: $workouts)
                        } label: {
                            Text("🏋️ Manage Workouts")
                                .font(.headline)
                                .foregroundColor(.blue)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding()
            }
            .background(Color(uiColor: .systemBackground))
            .navigationTitle("Workout & Attendance")
            .sheet(item: $editingAttendance) { attendance in
                EditAttendanceView(attendance: attendance, attendanceList: $attendanceList)
            }
        }
    }

    // MARK: - Section Container Modifier
    @ViewBuilder
    private func sectionContainer<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            content()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
    }
}

// MARK: - Edit Attendance View
struct EditAttendanceView: View {
    var attendance: Attendance
    @Binding var attendanceList: [Attendance]

    @State private var updatedDate: Date
    @State private var updatedDuration: String
    @State private var updatedWorkout: Workout?

    @Environment(\.presentationMode) var presentationMode

    init(attendance: Attendance, attendanceList: Binding<[Attendance]>) {
        self.attendance = attendance
        self._attendanceList = attendanceList
        self._updatedDate = State(initialValue: attendance.date)
        self._updatedDuration = State(initialValue: "\(attendance.duration)")
        self._updatedWorkout = State(initialValue: attendance.workout)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Edit Attendance")) {
                    DatePicker("Date", selection: $updatedDate, displayedComponents: .date)

                    TextField("Duration (minutes)", text: $updatedDuration)
                        .keyboardType(.numberPad)

                    Picker("Workout", selection: $updatedWorkout) {
                        Text("No Workout").tag(Optional<Workout>(nil))
                        ForEach(UserDefaultsManager.loadWorkouts()) { workout in
                            Text(workout.name).tag(Optional(workout))
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("Edit Attendance")
            .navigationBarItems(
                leading: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("Save") {
                    saveChanges()
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(updatedDuration.trimmingCharacters(in: .whitespaces).isEmpty)
            )
        }
    }

    private func saveChanges() {
        if let index = attendanceList.firstIndex(where: { $0.id == attendance.id }) {
            let newAttendance = Attendance(
                id: attendance.id,
                date: updatedDate,
                workout: updatedWorkout,
                duration: Int(updatedDuration) ?? attendance.duration
            )
            attendanceList[index] = newAttendance
            UserDefaultsManager.saveAttendance(attendanceList)
        }
    }
}

// MARK: - Workout Manager View
struct WorkoutManagerView: View {
    @Binding var workouts: [Workout]
    @State private var workoutName = ""
    @State private var workoutDescription = ""
    @State private var exercises: [Exercise] = []
    @State private var exerciseName = ""
    @State private var sets = ""
    @State private var reps = ""
    @State private var selectedWorkout: Workout? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            // MARK: Select Workout for Editing
            Picker("Edit Workout", selection: $selectedWorkout) {
                Text("New Workout").tag(Optional<Workout>(nil))
                ForEach(workouts) { workout in
                    Text(workout.name).tag(Optional(workout))
                }
            }
            .pickerStyle(.menu)
            .padding(10)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
            .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))
            .onChange(of: selectedWorkout) { newValue, _ in
                if let workout = newValue {
                    workoutName = workout.name
                    workoutDescription = workout.description
                    exercises = workout.exercises
                } else {
                    workoutName = ""
                    workoutDescription = ""
                    exercises = []
                }
            }

            TextField("Workout Name", text: $workoutName)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))

            TextField("Workout Description", text: $workoutDescription)
                .padding(10)
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
                .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))

            // MARK: Add Exercise
            HStack(spacing: 10) {
                TextField("Exercise", text: $exerciseName)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                TextField("Sets", text: $sets)
                    .keyboardType(.numberPad)
                    .padding(10)
                    .frame(width: 60)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                TextField("Reps", text: $reps)
                    .keyboardType(.numberPad)
                    .padding(10)
                    .frame(width: 60)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                Button(action: {
                    if let setsInt = Int(sets), let repsInt = Int(reps), !exerciseName.isEmpty {
                        let newExercise = Exercise(name: exerciseName, sets: setsInt, reps: repsInt)
                        exercises.append(newExercise)
                        exerciseName = ""
                        sets = ""
                        reps = ""
                    }
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title2)
                }
            }

            // MARK: List of Exercises (With Delete Option)
            VStack(alignment: .leading, spacing: 5) {
                ForEach(exercises) { exercise in
                    HStack {
                        Text("- \(exercise.name): \(exercise.sets) sets x \(exercise.reps) reps")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Button(action: {
                            exercises.removeAll { $0.id == exercise.id }
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                                .padding(5)
                        }
                        .buttonStyle(.plain)
                    }
                }
            }
            

            // MARK: Save Workout
            HStack(spacing: 15) {
                Button("Save Workout") {
                    if let selectedWorkout = selectedWorkout, let index = workouts.firstIndex(where: { $0.id == selectedWorkout.id }) {
                        workouts[index] = Workout(name: workoutName, description: workoutDescription, exercises: exercises)
                    } else {
                        let newWorkout = Workout(name: workoutName, description: workoutDescription, exercises: exercises)
                        workouts.append(newWorkout)
                    }
                    UserDefaultsManager.saveWorkouts(workouts)
                    workoutName = ""
                    workoutDescription = ""
                    exercises = []
                    selectedWorkout = nil
                }
                .buttonStyle(.borderedProminent)
                .disabled(workoutName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)

                Button("Clear") {
                    workoutName = ""
                    workoutDescription = ""
                    exercises = []
                    selectedWorkout = nil
                }
                .buttonStyle(.bordered)
            }
            .frame(maxWidth: .infinity, alignment: .center)

            // MARK: List of Saved Workouts
            ForEach(workouts) { workout in
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(workout.name)
                            .font(.headline)
                        Text(workout.description)
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        ForEach(workout.exercises) { exercise in
                            Text("- \(exercise.name): \(exercise.sets) sets x \(exercise.reps) reps")
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)

                    // Edit Button
                    Button(action: {
                        selectedWorkout = workout
                    }) {
                        Image(systemName: "pencil.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                    }

                    // Delete Button
                    Button(action: {
                        if let index = workouts.firstIndex(where: { $0.id == workout.id }) {
                            workouts.remove(at: index)
                            UserDefaultsManager.saveWorkouts(workouts)
                        }
                    }) {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                            .padding(8)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.vertical, 5)
            }
        }
        .padding(.horizontal, 15)
    }
}
