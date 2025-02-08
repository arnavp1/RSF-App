//
//  RSFApp.swift
//  RSF
//
//  Created by Arnav Podichetty on 2/5/25.
//

import SwiftUI

@main
struct RSFApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                CrowdMeterView()
                    .tabItem {
                        Label("Crowd", systemImage: "person.3.fill")
                    }
                WorkoutAndAttendanceView()
                    .tabItem {
                        Label("Workouts & Tracker", systemImage: "dumbbell.fill")
                    }
                RSFInfoView()
                    .tabItem {
                        Label("RSF Info", systemImage: "info.circle.fill")
                    }
            }
        }
    }
}
