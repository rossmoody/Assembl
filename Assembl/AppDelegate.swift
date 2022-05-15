import Cocoa
import KeyboardShortcuts

class AppDelegate: NSObject, NSApplicationDelegate {
    
    lazy var statusItem = with(NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)) {
        $0.button?.title = "🌯"
        $0.button?.toolTip = Constants.AppName
        $0.menu = Menu(title: Constants.AppName)
    }
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        _ = statusItem.button
        setupEvents()
    }
}

