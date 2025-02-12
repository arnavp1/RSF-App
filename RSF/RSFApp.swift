/* Thing that still need to be added:
 - Haptics
 - Push Notifications
 - Widgets
 */

import SwiftUI

@main
struct RSFApp: App {
    @AppStorage("selectedTheme") private var selectedTheme: ThemeOption = .system
    @AppStorage("selectedAccentColor") private var selectedAccentColor: AccentColorOption = .blue

    var body: some Scene {
        WindowGroup {
            TabView {
                CrowdMeterView()
                    .tabItem {
                        Label("Crowd", systemImage: "person.3.fill")
                            .foregroundColor(selectedAccentColor.color)
                    }
                TrackerView()
                    .tabItem {
                        Label("Tracker", systemImage: "dumbbell.fill")
                            .foregroundColor(selectedAccentColor.color)
                    }
                RSFInfoView()
                    .tabItem {
                        Label("RSF Info", systemImage: "info.circle.fill")
                            .foregroundColor(selectedAccentColor.color)
                    }
                SettingsView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape.fill")
                            .foregroundColor(selectedAccentColor.color)
                    }
            }
            .preferredColorScheme(themeToColorScheme(selectedTheme))
            .tint(selectedAccentColor.color)
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
