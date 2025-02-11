import UIKit

class HapticManager {
    static let shared = HapticManager()

    private init() {}

    func triggerHapticFeedback(enabled: Bool) {
        guard enabled else { return }
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.prepare()
        generator.impactOccurred()
    }
}
