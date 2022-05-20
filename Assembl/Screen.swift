import Foundation
import Cocoa

class Screen {
    /**
     The screen that is most likely to be the currently focused
     */
    private let activeScreen: NSScreen
    
    init() {
        self.activeScreen = NSScreen.main ?? NSScreen.screens[0]
    }
    
    /**
     The full screen rectangle at the current resolution including
     any space currently occupied by the menu bar and dock
     */
    var frame: NSRect  {
        get {
            return self.activeScreen.frame
        }
    }
    
    var visibleFrame: NSRect  {
        get {
            return self.activeScreen.frame
        }
    }
}
