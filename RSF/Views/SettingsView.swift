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
    case red = "Red"
    case orange = "Orange"
    case yellow = "Yellow"
    case green = "Green"
    case teal = "Teal"
    case cyan = "Cyan"
    case blue = "Blue"
    case indigo = "Indigo"
    case purple = "Purple"
    case pink = "Pink"
    case mint = "Mint"
    case brown = "Brown"

    var id: String { self.rawValue }

    var color: Color {
        switch self {
        case .red: return .red
        case .orange: return .orange
        case .yellow: return .yellow
        case .green: return .green
        case .teal: return .teal
        case .cyan: return .cyan
        case .blue: return .blue
        case .indigo: return .indigo
        case .purple: return .purple
        case .pink: return .pink
        case .mint: return .mint
        case .brown: return .brown
        }
    }
}

struct SettingsView: View {
    @AppStorage("notificationsEnabled") private var notificationsEnabled = true
    @AppStorage("hapticFeedbackEnabled") private var hapticFeedbackEnabled = true
    @AppStorage("selectedTheme") private var selectedTheme: ThemeOption = .system
    @AppStorage("selectedAccentColor") private var selectedAccentColor: AccentColorOption = .blue

    let accentColors = AccentColorOption.allCases

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Preferences")) {
                    
                    // MARK: - Notifications Toggle
                    Toggle("Notifications", isOn: $notificationsEnabled)
/*
                        .onChange(of: notificationsEnabled) { newValue, _ in
                            HapticManager.shared.triggerHapticFeedback(enabled: hapticFeedbackEnabled)
                        }
                    
                    // MARK: - Haptic Feedback Toggle
                    Toggle("Haptic Feedback", isOn: $hapticFeedbackEnabled)
                        .onChange(of: hapticFeedbackEnabled) { newValue, _ in
                            HapticManager.shared.triggerHapticFeedback(enabled: hapticFeedbackEnabled)
                        }
*/
                    // MARK: - Appearance Selection
                    HStack {
                        Text("Appearance")

                        Spacer()

                        HStack(spacing: 15) {
                            ForEach(ThemeOption.allCases, id: \.self) { theme in
                                Circle()
                                    .fill(selectedTheme == theme ? Color.primary : Color.gray.opacity(0.3))
                                    .frame(width: 35, height: 35)
                                    .overlay(
                                        Text(theme == .system ? "⚙️" : theme == .light ? "☀️" : "🌙")
                                            .font(.caption)
                                            .foregroundColor(selectedTheme == theme ? .white : .primary)
                                    )
/*                                    .onTapGesture {
                                        withAnimation {
                                            selectedTheme = theme
                                            HapticManager.shared.triggerHapticFeedback(enabled: hapticFeedbackEnabled)
                                        }
                                    }
*/
                            }
                        }
                    }
                    .padding(.vertical, 5)
                    
                    // MARK: - Accent Color Selection
                    VStack(alignment: .leading) {
                        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 4), spacing: 12) {
                            ForEach(accentColors, id: \.self) { accentColor in
                                Circle()
                                    .fill(accentColor.color)
                                    .frame(width: 30, height: 30)
                                    .overlay(
                                        Circle()
                                            .stroke(selectedAccentColor == accentColor ? Color.primary : Color.clear, lineWidth: 2)
                                    )
                                    .onTapGesture {
                                        withAnimation {
                                            selectedAccentColor = accentColor
                                            HapticManager.shared.triggerHapticFeedback(enabled: hapticFeedbackEnabled)
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.vertical, 5)
                }

                Section(header: Text("About")) {
                    NavigationLink(destination: Text("Version 1.0")) {
                        Text("App Version")
                            .foregroundColor(selectedAccentColor.color)
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarBackground(Color(uiColor: .systemGroupedBackground), for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}
