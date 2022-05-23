import Foundation
import Cocoa

class WindowController {
    /**
     The primary init function for calculating and resizing all windows.
     */
    static func assemble() {
        for window in allAxWindowsOnScreen {
            window.logProperties()
            window.set(size: CGSize.init())
        }
    }
    
    /**
     The unique set of all available window process ids from a given screen.
     */
    private static var allProcessIds: Set<pid_t> {
        get {
            var processIds: Set<pid_t> = []
            for window in allWindowOnScreen {
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
    static var allWindowOnScreen: [Dictionary<String, Any>] {
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
    static var allAxWindowsOnScreen: [A11yElement] {
        get {
            var elements = [A11yElement]()
            for processId in WindowController.allProcessIds {
                var windows: AnyObject?
                AXUIElementCopyAttributeValue(AXUIElementCreateApplication(processId),
                                              kAXWindowsAttribute as CFString,
                                              &windows)
                
                if let windowsArray = windows as? [AXUIElement] {
                    if !windowsArray.isEmpty {
                        for window in windowsArray {
                            let element = A11yElement(window)
                            
                            if element.isFullScreen {
                                print("The window is full screen. Exiting.")
                                return [A11yElement]()
                            }
                            
                            if element.isWindow
                                && !element.isSheet
                                && !element.isHidden
                                && !element.isMinimized
                                && element.position != nil {
                                elements.append(element)
                            }
                        }
                    }
                }
                
            }
            
            return elements
        }
    }
}
