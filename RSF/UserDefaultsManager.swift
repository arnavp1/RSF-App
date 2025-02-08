//
//  UserDefaultsManager.swift
//  RSF
//
//  Created by Arnav Podichetty on 2/5/25.
//

import Foundation

struct UserDefaultsManager {
    static let workoutsKey = "workoutsKey"
    static let attendanceKey = "attendanceKey"

    static func saveWorkouts(_ workouts: [Workout]) {
        if let data = try? JSONEncoder().encode(workouts) {
            UserDefaults.standard.set(data, forKey: workoutsKey)
        }
    }

    static func loadWorkouts() -> [Workout] {
        guard let data = UserDefaults.standard.data(forKey: workoutsKey),
              let workouts = try? JSONDecoder().decode([Workout].self, from: data) else {
            return []
        }
        return workouts
    }

    static func saveAttendance(_ attendanceList: [Attendance]) {
        if let data = try? JSONEncoder().encode(attendanceList) {
            UserDefaults.standard.set(data, forKey: attendanceKey)
        }
    }

    static func loadAttendance() -> [Attendance] {
        guard let data = UserDefaults.standard.data(forKey: attendanceKey),
              let attendanceList = try? JSONDecoder().decode([Attendance].self, from: data) else {
            return []
        }
        return attendanceList
    }
}
