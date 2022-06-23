import Cocoa
import KeyboardShortcuts

class AppDelegate: NSObject, NSApplicationDelegate {
    lazy var statusItem = with(NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)) {
        $0.button?.image = NSImage(named: "menu_icon")
        $0.button?.toolTip = loc("ASSEMBL", "App name")
        $0.menu = StatusMenu(title: loc("ASSEMBL", "App name"))
    }

    func applicationDidFinishLaunching(_: Notification) {
        _ = statusItem.button
        setupEvents()
    }

    var accessibilityPermission: Bool {
        let options: NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
        let result = AXIsProcessTrustedWithOptions(options)
        return result
    }

    private func setupEvents() {
        KeyboardShortcuts.onKeyUp(for: .shortcut) {
            WindowMover.assemble()
        }
    }
}
