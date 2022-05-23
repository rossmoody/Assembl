import Cocoa
import Foundation

/// An A11yElement is a proxy for controlling, moving, and resizing windows in a given view. It uses the
/// accessibility API to control the given window as an AXUIElement. Each A11yElement.element instance
/// property represents a window in view.
class A11yElement {
    /**
     The accessibility element proxy that represents a window that directs size and position updates
     */
    var element: AXUIElement
    
    init(_ element: AXUIElement) {
        self.element = element
    }
    
    var title: String? {
        copyAttributeValue(of: kAXTitleAttribute)
    }
    
    var role: String? {
        copyAttributeValue(of: kAXRoleAttribute)
    }
    
    var isWindow: Bool {
        return self.role == kAXWindowRole
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
        var resizable: DarwinBoolean = true
        AXUIElementIsAttributeSettable(self.element, kAXSizeAttribute as CFString, &resizable)
        return resizable.boolValue
    }
    
    var position: CGPoint? {
        if let result: AXValue = copyAttributeValue(of: kAXPositionAttribute) {
            var positionPointer = CGPoint.init()
            AXValueGetValue(result, .cgPoint, &positionPointer)
            return positionPointer
        }
        return nil
    }
    
    var size: CGSize? {
        if let result: AXValue = copyAttributeValue(of: kAXSizeAttribute) {
            var sizePointer = CGSize.init()
            AXValueGetValue(result, .cgSize, &sizePointer)
            return sizePointer
        }
        return nil
    }
    
    var rect: CGRect? {
        if let position = position as CGPoint?, let size = size as CGSize? {
            return CGRect.init(origin: position, size: size)
        }
        return nil
    }
    
    var isFullScreen: Bool {
        if let fullScreenBtnAttr: AXUIElement = copyAttributeValue(of: kAXFullScreenButtonAttribute) {
            var subroleAttr: AnyObject?
            AXUIElementCopyAttributeValue(
                fullScreenBtnAttr,
                kAXSubroleAttribute as CFString,
                &subroleAttr)
            return subroleAttr as! String == kAXZoomButtonSubrole ? true : false
        }
        return false
    }
    
    var isSheet: Bool {
        let sheetRole: String? = copyAttributeValue(of: kAXSheetRole)
        return sheetRole == kAXSheetRole
    }
    
    var isEnhancedUi: Bool {
        if let enhanced: CFBoolean = copyAttributeValue(of: kAXEnhancedUserInterface) {
            return CFBooleanGetValue(enhanced)
        }
        return false
        
    }
    
    func set(position to: CGPoint) {
        var pointer = to
        if let position = AXValueCreate(.cgPoint, &pointer) {
            AXUIElementSetAttributeValue(self.element, kAXPositionAttribute as CFString, position)
        }
        
    }
    
    func set(size to: CGSize) {
        var pointer = to
        if let size = AXValueCreate(.cgSize, &pointer) {
            AXUIElementSetAttributeValue(self.element, kAXSizeAttribute as CFString, size)
        }
    }
    
    func set(size: CGSize, position: CGPoint) {
        self.set(position: position)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            self.set(size: size)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
            self.set(position: position)
        }
    }
    
    private func copyAttributeValue<Type>(of attribute: String) -> Type? {
        var ref: CFTypeRef?
        let result = AXUIElementCopyAttributeValue(self.element, attribute as CFString, &ref)
        if result == .success {
            return ref as? Type
        }
        return nil
    }
    
    func logProperties() {
        let computedProperties =
        [
            "title": title,
            "isResizable": isResizable,
            "position": position,
            "size": size,
        ] as [String: Any?]
        print(computedProperties as NSDictionary)
    }
}
