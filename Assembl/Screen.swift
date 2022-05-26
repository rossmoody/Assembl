import Foundation
import Cocoa

class Screen {
    static var rect: CGRect {
        get {
            let origin = CGPoint.init(x: screenWithMouse.visibleFrame.origin.x,
                                      y: screenWithMouse.frame.height - (screenWithMouse.visibleFrame.height + screenWithMouse.visibleFrame.origin.y))
            
            return CGRect.init(origin: origin, size: screenWithMouse.visibleFrame.size)
        }
    }
    
    private static var screenWithMouse: NSScreen {
        get {
            return NSScreen.screens.first {
                NSMouseInRect(NSEvent.mouseLocation, $0.frame, false)
            } ?? NSScreen.screens[0]
        }
    }
}
