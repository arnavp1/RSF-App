//
//  SettingsView.swift
//  RSF
//
//  Created by Arnav Podichetty on 2/7/25.
//

import SwiftUI

// Theme Options
enum ThemeOption: String, CaseIterable, Identifiable {
    case system = "System Default"
    case light = "Light Mode"
    case dark = "Dark Mode"

    var id: String { self.rawValue }
}

// Common Accent Colors
enum AccentColorOption: String, CaseIterable, Identifiable {
    case blue = "Blue"
    case red = "Red"
    case green = "Green"
    case orange = "Orange"
    case purple = "Purple"
    case pink = "Pink"
    case yellow = "Yellow"

    var id: String { self.rawValue }

    // Convert to actual SwiftUI Color
    var color: Color {
        switch self {
        case .blue: return .blue
        case .red: return .red
        case .green: return .green
        case .orange: return .orange
        case .purple: return .purple
        case .pink: return .pink
        case .yellow: return .yellow
        }
    }
}

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("selectedTheme") private var selectedTheme: ThemeOption = .system
    @AppStorage("accentColor") private var accentColor: AccentColorOption = .blue

    var body: some View {
        NavigationView {
            Form {
                // Preferences Section
                Section(header: Text("Preferences")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)

                    Picker("Appearance", selection: $selectedTheme) {
                        ForEach(ThemeOption.allCases) { theme in
                            Text(theme.rawValue).tag(theme)
                        }
                    }

                    Picker("Accent Color", selection: $accentColor) {
                        ForEach(AccentColorOption.allCases) { color in
                            HStack {
                                Text(color.rawValue)
                                Spacer()
                                Circle()
                                    .fill(color.color)
                                    .frame(width: 15, height: 15)
                            }
                            .tag(color)
                        }
                    }
                }

                // About Section
                Section(header: Text("About")) {
                    NavigationLink(destination: Text("Version 1.0")) {
                        Text("App Version")
                    }
                }
            }
            .navigationTitle("Settings")
            .accentColor(accentColor.color) // Apply selected accent color globally
        }
    }
}
