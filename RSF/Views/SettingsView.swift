import SwiftUI

// MARK: - Theme Options (Light/Dark Mode)
enum ThemeOption: String, CaseIterable, Identifiable {
    case system = "System Default"
    case light = "Light Mode"
    case dark = "Dark Mode"

    var id: String { self.rawValue }
}

// MARK: - Accent Color Options
enum AccentColorOption: String, CaseIterable, Identifiable {
    case blue = "Blue"
    case red = "Red"
    case green = "Green"
    case orange = "Orange"
    case purple = "Purple"
    case yellow = "Yellow"
    case pink = "Pink"
    case teal = "Teal"
    case cyan = "Cyan"
    case brown = "Brown"
    case indigo = "Indigo"
    case mint = "Mint"
    case gray = "Gray"

    var id: String { self.rawValue }

    var color: Color {
        switch self {
        case .blue: return .blue
        case .red: return .red
        case .green: return .green
        case .orange: return .orange
        case .purple: return .purple
        case .yellow: return .yellow
        case .pink: return .pink
        case .teal: return .teal
        case .cyan: return .cyan
        case .brown: return .brown
        case .indigo: return .indigo
        case .mint: return .mint
        case .gray: return .gray
        }
    }
}


struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("selectedTheme") private var selectedTheme: ThemeOption = .system
    @AppStorage("selectedAccentColor") private var selectedAccentColor: AccentColorOption = .blue

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    Toggle("Enable Notifications", isOn: $notificationsEnabled)

                    Picker("Appearance", selection: $selectedTheme) {
                        ForEach(ThemeOption.allCases) { theme in
                            Text(theme.rawValue)
                                .tag(theme)
                        }
                    }

                    Picker("Accent Color", selection: $selectedAccentColor) {
                        ForEach(AccentColorOption.allCases) { color in
                            Text(color.rawValue)
                                .tag(color)
                        }
                    }

                }

                Section(header: Text("About")) {
                    NavigationLink(destination: Text("Version 1.0")) {
                        Text("App Version")
                            .foregroundColor(selectedAccentColor.color)
                    }
                }
            }
            .navigationTitle("Settings")
        }
    }
}
