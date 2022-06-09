import Cocoa
import Foundation

final class WindowMover {
    static func assemble() {
        var windows = Screen.allAxWindowsOnScreen

        if !windows.isEmpty {
            windows = sortWindows(windows)
            gridWindows(windows)
        }
    }

    private static func gridWindows(_ windows: [A11yElement]) {
        let columns = Int(ceil(sqrt(CGFloat(windows.count))))
        let rows = Int(ceil(CGFloat(windows.count) / CGFloat(columns)))

        var size = CGSize(
            width: Screen.rect.width / CGFloat(columns),
            height: Screen.rect.height / CGFloat(rows)
        )

        for (index, window) in windows.enumerated() {
            let isLastWindow = (index + 1) == windows.count
            let column = index % Int(columns)
            let row = index / Int(columns)

            let position = CGPoint(
                x: Screen.rect.origin.x + size.width * CGFloat(column),
                y: Screen.rect.origin.y + size.height * CGFloat(row)
            )

            if !window.isResizable {
                window.set(position: position)
                continue
            }

            if isLastWindow {
                size.width = CGFloat((columns - column) * Int(size.width))
            }

            window.set(size: size, position: position)
        }
    }

    private static func sortWindows(_ windows: [A11yElement]) -> [A11yElement] {
        windows.sorted { windowA, windowB in
            windowA.processId < windowB.processId
        }
    }
}
