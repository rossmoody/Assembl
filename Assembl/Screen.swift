import Foundation
import Cocoa

class Screen {
    
    private static let screen = Screen.screenWithMouse
    
    static var rect: CGRect {
        get {
            return CGRect.init(origin: Screen.origin, size: Screen.size)
        }
    }
    
    private static var origin: CGPoint {
        get {
            return CGPoint.init(x: screen.visibleFrame.origin.x,
                                y: screen.frame.height - (screen.visibleFrame.height + screen.visibleFrame.origin.y))
        }
    }
    
    private static var size: CGSize {
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
