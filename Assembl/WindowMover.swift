import Cocoa
import Foundation

final class WindowMover {
    static func assemble() {
        if !sortedResizableWindows.isEmpty {
            gridResizableWindows(windows: sortedResizableWindows)
        }

        if !sortedFixedWindows.isEmpty {
            print(sortedFixedWindows)
        }
    }

    private static func gridResizableWindows(windows: [A11yElement]) {
        let columns = Int(ceil(sqrt(CGFloat(windows.count))))
        let rows = Int(ceil(CGFloat(windows.count) / CGFloat(columns)))

        var size = CGSize(
            width: Screen.rect.width / CGFloat(columns),
            height: Screen.rect.height / CGFloat(rows)
        )

        for (index, window) in windows.enumerated() {
            let column = index % Int(columns)
            let row = index / Int(columns)

            let position = CGPoint(
                x: Screen.rect.origin.x + size.width * CGFloat(column),
                y: Screen.rect.origin.y + size.height * CGFloat(row)
            )

            if (index + 1) == windows.count {
                size.width = CGFloat((columns - column) * Int(size.width))
            }

            window.set(size: size, position: position)
        }
    }

    private static var sortedResizableWindows: [A11yElement] {
        let resizableWindows = Screen.resizableWindows

        for window in resizableWindows {
            window.set(size: CGSize(width: 0, height: 0))
        }

        return sortWindows(resizableWindows)
    }

    private static var sortedFixedWindows: [A11yElement] {
        sortWindows(Screen.fixedWindows)
    }

    private static func sortWindows(_ windows: [A11yElement]) -> [A11yElement] {
        windows.sorted { windowA, windowB in
            if let rectA = windowA.rect, let rectB = windowB.rect {
                if rectA.width != rectB.width {
                    return rectA.width > rectB.width
                }
            }

            return windowA.windowNumber < windowB.windowNumber
        }
    }
}
