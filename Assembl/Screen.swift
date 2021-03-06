import Cocoa
import Foundation

class Screen {
    /**
     The normalized screen rect for available screen real estate not including the dock or status menu bar
     */
    static var rect: CGRect {
        var normalizedRect = screenWithMouse.frame
        let frameOfScreenWithMenuBar = NSScreen.screens[0].frame as CGRect
        normalizedRect.origin.y = frameOfScreenWithMenuBar.height - screenWithMouse.frame.maxY
        return normalizedRect
    }

    /**
     Applications represented by a processId can include multiple windows in an array. This loops through
     all unique process ids and returns an array of A11yElements of an application represented
     on the screen with a mouse cursor.
     */
    static var allAxWindowsOnScreen: [A11yElement] {
        var validA11yElements = [A11yElement]()

        for processId in Screen.allWindowIds {
            var applicationWindows: AnyObject?

            AXUIElementCopyAttributeValue(AXUIElementCreateApplication(processId),
                                          kAXWindowsAttribute as CFString,
                                          &applicationWindows)

            guard let windows = applicationWindows as? [AXUIElement],
                  !windows.isEmpty
            else {
                continue
            }

            for window in windows {
                let element = A11yElement(window: window, processId: processId)

                if element.isWindow,
                   element.position != nil,
                   element.isOnScreenWithMouse,
                   !element.isSheet,
                   !element.isHidden,
                   !element.isMinimized,
                   !element.isFullScreen
                {
                    validA11yElements.append(element)
                }
            }
        }

        return validA11yElements
    }

    static var screenWithMouse: NSScreen {
        let mouseLocation = NSEvent.mouseLocation
        let screens = NSScreen.screens
        let screenWithMouse = (screens.first { NSMouseInRect(mouseLocation, $0.frame, false) })
        return screenWithMouse ?? NSScreen.screens[0]
    }

    private static var allWindowIds: Set<pid_t> {
        var processIds: Set<pid_t> = []

        for window in allWindowOnScreen {
            let processId = window[kCGWindowOwnerPID as String] as! pid_t
            processIds.insert(processId)
        }

        return processIds
    }

    static var allWindowOnScreen: [[String: Any]] {
        let options = CGWindowListOption([.optionOnScreenOnly, .excludeDesktopElements])
        return CGWindowListCopyWindowInfo(options, kCGNullWindowID) as! [[String: Any]]
    }
}
