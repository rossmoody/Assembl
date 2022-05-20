import Foundation

struct WindowInfo {
    let number: CFNumber
    let processId: pid_t
    let storeType: CFNumber
    let layer: CFNumber
    let sharingState: CFNumber
    let alpha: CFNumber
    let bounds: CGRect
    let ownerName: CFString
    
    init(of window: Dictionary<String, Any>) {
        number = window[kCGWindowNumber as String] as! CFNumber
        processId = window[kCGWindowOwnerPID as String] as! pid_t
        storeType = window[kCGWindowStoreType as String] as! CFNumber
        layer = window[kCGWindowLayer as String] as! CFNumber
        sharingState = window[kCGWindowSharingState as String] as! CFNumber
        alpha = window[kCGWindowAlpha as String] as! CFNumber
        bounds = CGRect.init(dictionaryRepresentation: window[kCGWindowBounds as String] as! CFDictionary) ?? CGRect.init()
        ownerName = window[kCGWindowOwnerName as String] as! CFString
    }
    
    /**
     An array information about all windows in a given screen. This includes hidden windows that
     may come from background apps or menu items (even though it says OnScreenOnly).
     */
    static var allWindows: [Dictionary<String, Any>] {
        get {
            let options = CGWindowListOption([.optionOnScreenOnly, .excludeDesktopElements])
            return CGWindowListCopyWindowInfo(options, kCGNullWindowID) as! [Dictionary<String, Any>]
        }
    }
    
    /**
     A set of all available window process ids
     */
    static var allProcessIds: Set<pid_t> {
        get {
            var processIds: Set<pid_t> = []
            
            for window in allWindows {
                processIds.insert(WindowInfo(of: window).processId)
            }
            
            return processIds
        }
    }
}
