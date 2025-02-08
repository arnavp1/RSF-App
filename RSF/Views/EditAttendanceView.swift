//
//  EditAttendanceView.swift
//  RSF
//
//  Created by Arnav Podichetty on 2/5/25.
//

import SwiftUI

struct EditAttendanceView: View {
    @Binding var attendance: Attendance?
    @Binding var attendanceList: [Attendance]

    @State private var newDate = Date()
    @State private var newDuration = ""

    var body: some View {
        if let attendance = attendance {
            VStack(spacing: 20) {
                DatePicker("Edit Date", selection: $newDate, displayedComponents: .date)

                TextField("Edit Duration (minutes)", text: $newDuration)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button("Save Changes") {
                    if let index = attendanceList.firstIndex(where: { $0.id == attendance.id }) {
                        attendanceList[index].date = newDate
                        attendanceList[index].duration = Int(newDuration) ?? attendance.duration
                        UserDefaultsManager.saveAttendance(attendanceList)
                    }
                    self.attendance = nil
                }
                .buttonStyle(.borderedProminent)

                Button("Cancel") {
                    self.attendance = nil
                }
                .buttonStyle(.bordered)
            }
            .padding()
            .onAppear {
                newDate = attendance.date
                newDuration = "\(attendance.duration)"
            }
        }
    }
}
