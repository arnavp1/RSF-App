//
//  Workout.swift
//  RSF
//
//  Created by Arnav Podichetty on 2/5/25.
//

import Foundation

struct Exercise: Identifiable, Codable, Hashable {
    let id = UUID()
    var name: String
    var sets: Int
    var reps: Int
}

struct Workout: Identifiable, Codable, Hashable {
    var id = UUID() // Change `let` to `var` to fix decoding issues
    var name: String
    var description: String
    var exercises: [Exercise]
}

struct Attendance: Identifiable, Codable, Hashable {
    var id = UUID() // Change `let` to `var` to fix decoding issues
    var date: Date
    var workout: Workout?
    var duration: Int
}
