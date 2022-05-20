import Foundation
import Cocoa

struct A11yElement {
    /**
     The accessibility elements representing a window that can be moved and resized
     */
    var element: AXUIElement
    
    init(_ element: AXUIElement) {
        self.element = element
    }
    
    /**
     Applications can include multiple windows in an array based on pid. This loops through
     all unique processIds and returns an array of valid window objects of an application
     */
    static var allWindows: [A11yElement] {
        get {
            var elements = [A11yElement]()
            
            for processId in WindowInfo.allProcessIds {
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
    
    var title: String {
        get {
            var title: CFTypeRef?
            AXUIElementCopyAttributeValue(self.element, kAXTitleAttribute as CFString, &title)
            return title as! String
        }
    }
    
    var position: CGPoint {
        get {
            var position = CGPoint.init()
            var positionRef: CFTypeRef?
            
            let result = AXUIElementCopyAttributeValue(self.element, kAXPositionAttribute as CFString, &positionRef)
            if result == .success {
                AXValueGetValue(positionRef as! AXValue, .cgPoint, &position)
            }
            
            return position
        }
    }
    
    var size: CGSize {
        get {
            var size = CGSize.init()
            var sizeRef: CFTypeRef?
            
            let result = AXUIElementCopyAttributeValue(self.element, kAXSizeAttribute as CFString, &sizeRef)
            if result == .success {
                AXValueGetValue(sizeRef as! AXValue, .cgSize, &size)
            }
            
            return size
        }
    }
}

