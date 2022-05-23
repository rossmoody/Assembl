import Foundation
import Cocoa

class Screen {
    private let screen = Screen.screenWithMouse
    
    var rect: CGRect {
        get {
            return CGRect.init(origin: origin, size: size)
        }
    }
    
    var origin: CGPoint {
        get {
            return CGPoint.init(x: screen.visibleFrame.origin.x,
                                y: screen.frame.height - (screen.visibleFrame.height + screen.visibleFrame.origin.y))
        }
    }
    
    var size: CGSize {
        get {
            return screen.visibleFrame.size
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
