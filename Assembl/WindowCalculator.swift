import Foundation
import Cocoa

class WindowCalculator {
    /**
     The full screen rectangle at the current resolution including
     any space currently occupied by the menu bar and dock
     */
    var frame: NSRect  {
        get {
            return WindowCalculator.screenWithMouse.frame
        }
    }
    
    var visibleFrame: NSRect  {
        get {
            return WindowCalculator.screenWithMouse.visibleFrame
        }
    }
    
    static var screenWithMouse: NSScreen {
        get {
            return NSScreen.screens.first {
                NSMouseInRect(NSEvent.mouseLocation, $0.frame, false)
            } ?? NSScreen.screens[0]
        }
    }
}
