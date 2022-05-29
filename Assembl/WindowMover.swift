import Cocoa
import Foundation

final class WindowMover {
    
    static func assemble() {
        if !Screen.resizableWindows.isEmpty {
            gridResizableWindows(windows: self.resizableWindowsSortedBySize())
        }
    }
    
    private static func gridResizableWindows(windows: [A11yElement]) {
        let columns = Int(ceil(sqrt(CGFloat(windows.count))))
        let rows = Int(ceil(CGFloat(windows.count) / CGFloat(columns)))
        
        var size = CGSize(
            width: Screen.rect.width / CGFloat(columns),
            height: Screen.rect.height / CGFloat(rows))
        
        for (index, window) in windows.enumerated() {
            let column = index % Int(columns)
            let row = index / Int(columns)
            
            let position = CGPoint(
                x: Screen.rect.origin.x + size.width * CGFloat(column),
                y: Screen.rect.origin.y + size.height * CGFloat(row))
            
            if index + 1 == windows.count {
                size.width = CGFloat((columns - column) * Int(size.width))
            }
            
            window.logProperties()
            window.set(size: size, position: position)
        }
    }
    
    private static func resizableWindowsSortedBySize() -> [A11yElement] {
        for window in Screen.resizableWindows {
            window.set(size: CGSize(width: 0, height: 0))
        }
        
        return Screen.resizableWindows.sorted { (windowA, windowB) in
            if let rectA = windowA.rect, let rectB = windowB.rect {
                if rectA.width == rectB.width {
                    return rectA.height > rectB.height
                }
                
                return rectA.width > rectB.width
            }
            
            return windowA.processId < windowB.processId
        }
    }
    
    private static func fixedWindowsSortedBySize() -> [A11yElement] {
        Screen.nonSizableWindows.sorted { (windowA, windowB) in
            windowA.rect?.width ?? 0 > windowB.rect?.width ?? 0
        }
    }
}
