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
    
    /**
     State of app accessibility permissions in system preferences
     */
    var accessibilityPermission: Bool {
        get {
            let options : NSDictionary = [kAXTrustedCheckOptionPrompt.takeRetainedValue() as NSString: true]
            let result = AXIsProcessTrustedWithOptions(options)
            return result
        }
    }
    
    private func setupEvents() {
        KeyboardShortcuts.onKeyUp(for: .shortcut) {
            print("Permission: \(self.accessibilityPermission)")
            let options = CGWindowListOption([.optionOnScreenOnly, .excludeDesktopElements])
            let windows = CGWindowListCopyWindowInfo(options, kCGNullWindowID) as! [Dictionary<String, Any>]
            
            for window in windows {
                if let processId = window[kCGWindowOwnerPID as String] as? Int32 {
                    var elementAttributes: AnyObject?
                    let appRef = AXUIElementCreateApplication(processId)
                    let error = AXUIElementCopyAttributeValue(appRef, NSAccessibility.Attribute.windows as CFString, &elementAttributes)
                    if error == .success {
                        print(elementAttributes.debugDescription)
                    }
                }
            }
        }
    }
}
