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
                            .layoutPriority(1)
                            
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
                    
                    // MARK: Attendance History
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
                                    
                                    // 🗑️ Trash Icon Button (Aligned to the Right)
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
            .background(Color(uiColor: .systemBackground)) // Apply adaptive background
            .navigationTitle("Workout & Attendance")
        }
    }
    
    // MARK: - Section Container Modifier
    @ViewBuilder
    private func sectionContainer<Content: View>(@ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 15) {
            content()
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground))) // System background color
    }
}

// Workout Manager View
struct WorkoutManagerView: View {
    @Binding var workouts: [Workout]
    @State private var workoutName = ""
    @State private var workoutDescription = ""
    @State private var exercises: [Exercise] = []
    @State private var exerciseName = ""
    @State private var sets = ""
    @State private var reps = ""

    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
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

            HStack(spacing: 10) {
                TextField("Exercise", text: $exerciseName)
                    .padding(10)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                TextField("Sets", text: $sets)
                    .keyboardType(.numberPad)
                    .padding(10)
                    .frame(width: 80)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))

                TextField("Reps", text: $reps)
                    .keyboardType(.numberPad)
                    .padding(10)
                    .frame(width: 80)
                    .background(RoundedRectangle(cornerRadius: 8).fill(Color(uiColor: .secondarySystemBackground)))
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.gray.opacity(0.5), lineWidth: 1))
            }

            HStack(spacing: 15) {
                Button("Add Exercise") {
                    if let setsInt = Int(sets), let repsInt = Int(reps), !exerciseName.isEmpty {
                        let newExercise = Exercise(name: exerciseName, sets: setsInt, reps: repsInt)
                        exercises.append(newExercise)
                        exerciseName = ""
                        sets = ""
                        reps = ""
                    }
                }
                .buttonStyle(.borderedProminent)

                Button("Save Workout") {
                    let newWorkout = Workout(name: workoutName, description: workoutDescription, exercises: exercises)
                    workouts.append(newWorkout)
                    UserDefaultsManager.saveWorkouts(workouts)
                    workoutName = ""
                    workoutDescription = ""
                    exercises = []
                }
                .buttonStyle(.borderedProminent)
                .disabled(workoutName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) // Disable if empty
            }
            .frame(maxWidth: .infinity, alignment: .center)
        }
        
        // List of Saved Workouts with Delete Button
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

                // 🗑️ Trash Icon Button (Aligned to the Right)
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
        .padding(.horizontal, 15)
    }
}
