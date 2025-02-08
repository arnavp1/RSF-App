//
//  RSFApp.swift
//  RSF
//
//  Created by Arnav Podichetty on 2/5/25.
//

import SwiftUI

@main
struct RSFApp: App {
    @AppStorage("selectedTheme") private var selectedTheme: ThemeOption = .system

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
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                    }
            }
            .preferredColorScheme(themeToColorScheme(selectedTheme)) // Apply theme
        }
    }

    private func themeToColorScheme(_ theme: ThemeOption) -> ColorScheme? {
        switch theme {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
