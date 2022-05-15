import Foundation
import KeyboardShortcuts

extension AppDelegate {
    func setupEvents() {
        KeyboardShortcuts.onKeyUp(for: .shortcut) {
            print(loc("ASSEMBL", "App name"))
        }
    }
}
