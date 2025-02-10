import SwiftUI

enum ThemeOption: String, CaseIterable, Identifiable {
    case system = "System Default"
    case light = "Light Mode"
    case dark = "Dark Mode"

    var id: String { self.rawValue }
}

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("selectedTheme") private var selectedTheme: ThemeOption = .system

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)

                    Picker("Appearance", selection: $selectedTheme) {
                        ForEach(ThemeOption.allCases) { theme in
                            Text(theme.rawValue).tag(theme)
                        }
                    }
                }

                Section(header: Text("About")) {
                    NavigationLink(destination: Text("Version 1.0")) {
                        Text("App Version")
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
