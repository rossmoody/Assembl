import Cocoa
import Foundation

class A11yElement {
    let element: AXUIElement

    let processId: pid_t

    init(window: AXUIElement, processId: pid_t) {
        element = window
        self.processId = processId
    }

        }
    var title: String? {
        copyAttributeValue(of: kAXTitleAttribute)
    }

    var role: String? {
        copyAttributeValue(of: kAXRoleAttribute)
    }

    var position: CGPoint? {
        if let result: AXValue = copyAttributeValue(of: kAXPositionAttribute) {
            var positionPointer = CGPoint()
            AXValueGetValue(result, .cgPoint, &positionPointer)
            return positionPointer
        }

        return nil
    }

    var size: CGSize? {
        if let result: AXValue = copyAttributeValue(of: kAXSizeAttribute) {
            var sizePointer = CGSize()
            AXValueGetValue(result, .cgSize, &sizePointer)
            return sizePointer
        }
        return nil
    }

    var rect: CGRect? {
        if let position = position as CGPoint?, let size = size as CGSize? {
            return CGRect(origin: position, size: size)
        }
        return nil
    }

    var isOnScreenWithMouse: Bool {
        if let windowPosition = position, let size = size {
            let screenFrame = Screen.screenWithMouse.frame
            let normalizedPosition = CGPoint(x: windowPosition.x,
                                             y: screenFrame.origin.y + size.height)

            return screenFrame.contains(normalizedPosition)
        }

        return false
    }

    var isWindow: Bool {
        role == kAXWindowRole
    }

    var isMinimized: Bool {
        if let result: Bool = copyAttributeValue(of: kAXMinimizedAttribute) {
            return result
        }
        return false
    }

    var isHidden: Bool {
        if let result: Bool = copyAttributeValue(of: kAXHiddenAttribute) {
            return result
        }
        return false
    }

    var isResizable: Bool {
        var resizable: DarwinBoolean = false
        AXUIElementIsAttributeSettable(element, kAXSizeAttribute as CFString, &resizable)
        return resizable.boolValue
    }

    var isFullScreen: Bool {
        if let fullScreenBtnAttr: AXUIElement = copyAttributeValue(of: kAXFullScreenButtonAttribute) {
            var subroleAttr: AnyObject?
            AXUIElementCopyAttributeValue(
                fullScreenBtnAttr,
                kAXSubroleAttribute as CFString,
                &subroleAttr
            )
            return subroleAttr as! String == kAXZoomButtonSubrole ? true : false
        }
        return false
    }

    var isSheet: Bool {
        let sheetRole: String? = copyAttributeValue(of: kAXSheetRole)
        return sheetRole == kAXSheetRole
    }

    var windowNumber: CGWindowID {
        var windowId = 0 as CGWindowID

        let matchingWindows = Screen.allWindowOnScreen.filter { infoDict -> Bool in
            if let bounds = infoDict[kCGWindowBounds as String] as? [String: CGFloat] {
                if bounds["X"] == rect?.origin.x,
                   bounds["Y"] == rect?.origin.y,
                   bounds["Height"] == rect?.height,
                   bounds["Width"] == rect?.width
                {
                    return true
                }
            }
            return false
        }

        if let firstMatch = matchingWindows.first {
            windowId = firstMatch[kCGWindowNumber as String] as! CGWindowID
        }

        return windowId
    }

    func set(position to: CGPoint) {
        var pointer = to
        if let position = AXValueCreate(.cgPoint, &pointer) {
            AXUIElementSetAttributeValue(element, kAXPositionAttribute as CFString, position)
        }
    }

    func set(size to: CGSize) {
        var pointer = to
        if let size = AXValueCreate(.cgSize, &pointer) {
            AXUIElementSetAttributeValue(element, kAXSizeAttribute as CFString, size)
        }
    }

    func set(size: CGSize, position: CGPoint) {
        bringToFront()
        set(position: position)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.set(size: size)
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.set(position: position)
        }
    }

    func bringToFront() {
        if let app = NSRunningApplication(processIdentifier: processId) {
            AXUIElementSetAttributeValue(element, kAXMainAttribute as CFString, true as CFTypeRef)
            app.activate(options: .activateIgnoringOtherApps)
        }
    }

    func logProperties() {
        let computedProperties =
            [
                "title": title,
                "isResizable": isResizable,
                "rect": rect,
//                "processId": processId,
                "isFullscreen": isFullScreen,
                "isWindow": isWindow,
//                "isSheet": isSheet,
                "isOnMouseWindow": isOnScreenWithMouse,
//                "role": role,
                "screenFrame": Screen.screenWithMouse.frame,
            ] as [String: Any?]

        print(computedProperties as NSDictionary)
    }

    private func copyAttributeValue<Type>(of attribute: String) -> Type? {
        var ref: CFTypeRef?
        let result = AXUIElementCopyAttributeValue(element, attribute as CFString, &ref)
        if result == .success { return ref as? Type }
        return nil
    }
}
