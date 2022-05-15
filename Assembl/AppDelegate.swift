import Cocoa
import KeyboardShortcuts

class AppDelegate: NSObject, NSApplicationDelegate {
    
    lazy var statusItem = with(NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)) {
        $0.button?.title = "🌯"
        $0.button?.toolTip = loc("ASSEMBL", "App name")
        $0.menu = Menu(title: loc("ASSEMBL", "App name"))
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        _ = statusItem.button
        setupEvents()
    }
    
    private func setupEvents() {
        KeyboardShortcuts.onKeyUp(for: .shortcut) {
            let window = NSApplication.shared.windows[0]
            print(window)
        }
    }
}

