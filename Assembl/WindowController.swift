import Foundation
import Cocoa

class WindowController {
    /**
     The primary init function for calculating and resizing all windows.
     */
    static func assemble() {
        let axWindows = WindowController.allAxWindows
        let position = CGPoint.init(x: 50, y: 50)
        let size = CGSize.init(width: 600, height: 600)

        for window in axWindows {
            window.logProperties()
            window.set(size: size, position: position)
        }
    }
    
    /**
     The unique set of all available window process ids from a given screen.
     */
    private static var allProcessIds: Set<pid_t> {
        get {
            var processIds: Set<pid_t> = []
            for window in allWindows {
                let processId = window[kCGWindowOwnerPID as String] as! pid_t
                processIds.insert(processId)
            }
            return processIds
        }
    }
    
    /**
     An array information about all windows in a given screen. This includes hidden windows that
     may come from background apps or menu items (even though it says OnScreenOnly).
     */
    static var allWindows: [Dictionary<String, Any>] {
        get {
            let options = CGWindowListOption([.optionOnScreenOnly, .excludeDesktopElements])
            return CGWindowListCopyWindowInfo(options, kCGNullWindowID) as! [Dictionary<String, Any>]
        }
    }
    
    /**
     Applications represented by a processId can include multiple windows in an array. This loops through
     all unique process ids and returns an array of A11yElements of an application represented
     on the current screen view.
     */
    static var allAxWindows: [A11yElement] {
        get {
            var elements = [A11yElement]()
            
            for processId in WindowController.allProcessIds {
                var windows: AnyObject?
                let application = AXUIElementCreateApplication(processId)
                let result = AXUIElementCopyAttributeValue(application,
                                                           kAXWindowsAttribute as CFString,
                                                           &windows)
                if result == .success {
                    let windowsArr = windows as! [AXUIElement]
                    if !windowsArr.isEmpty {
                        elements.append(contentsOf: windowsArr.map{ A11yElement($0) })
                    }
                }
            }
            
            return elements
        }
    }
}
