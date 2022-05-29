import Foundation
import Cocoa

class Screen {
    /**
     The normalized screen rect for available screen real estate not including the dock or status menu bar
     */
    static var rect: CGRect {
        get {
            let origin = CGPoint.init(x: screenWithMouse.visibleFrame.origin.x,
                                      y: screenWithMouse.frame.height - (screenWithMouse.visibleFrame.height + screenWithMouse.visibleFrame.origin.y))
            
            return CGRect.init(origin: origin, size: screenWithMouse.visibleFrame.size)
        }
    }
    
    static var resizableWindows: [A11yElement] {
        get {
            allAxWindowsOnScreen.filter { window in
                window.isResizable
            }
        }
    }
    
    static var nonSizableWindows: [A11yElement] {
        get {
            allAxWindowsOnScreen.filter { window in
                !window.isResizable
            }
        }
    }
    
    /**
     Applications represented by a processId can include multiple windows in an array. This loops through
     all unique process ids and returns an array of A11yElements of an application represented
     on the current screen view.
     */
    static var allAxWindowsOnScreen: [A11yElement] {
        get {
            var validA11yElements = [A11yElement]()
            
            for processId in Screen.allWindowIds {
                var applicationWindows: AnyObject?
                
                AXUIElementCopyAttributeValue(AXUIElementCreateApplication(processId),
                                              kAXWindowsAttribute as CFString,
                                              &applicationWindows)
                
                guard let applicationWindows = applicationWindows as? [AXUIElement] else {
                    continue
                }
                
                if applicationWindows.isEmpty {
                    continue
                }
                
                for window in applicationWindows {
                    let element = A11yElement(window: window, processId: processId)
                    
                    element.logProperties()
                    
                    if element.isFullScreen {
                        return [A11yElement]()
                    }
                    
                    if element.isWindow
                        && !element.isSheet
                        && !element.isHidden
                        && !element.isMinimized
                        && element.position != nil {
                        validA11yElements.append(element)
                    }
                }
            }
            
            return validA11yElements
        }
    }
    
    private static var screenWithMouse: NSScreen {
        get {
            return NSScreen.screens.first {
                NSMouseInRect(NSEvent.mouseLocation, $0.frame, false)
            } ?? NSScreen.screens[0]
        }
    }
    
    /**
     The unique set of all available window process ids from a given screen.
     */
    private static var allWindowIds: Set<pid_t> {
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
    private static var allWindowOnScreen: [Dictionary<String, Any>] {
        get {
            let options = CGWindowListOption([.optionOnScreenOnly, .excludeDesktopElements])
            return CGWindowListCopyWindowInfo(options, kCGNullWindowID) as! [Dictionary<String, Any>]
        }
    }
}
