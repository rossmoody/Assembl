import Foundation
import KeyboardShortcuts

extension AppDelegate {
    func setupEvents() {
        KeyboardShortcuts.onKeyUp(for: .shortcut) {
            print(Constants.AppName)
        }
    }
}
