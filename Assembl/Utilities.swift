import Cocoa
import Foundation

/**
 Convenience function for initializing an object and modifying its properties.
 */
@discardableResult
func with<T>(_ item: T, update: (inout T) throws -> Void) rethrows -> T {
    var this = item
    try update(&this)
    return this
}

/**
 Convenience function for referencing localized strings
 */
func loc(_ key: String, _ comment: String) -> String {
    NSLocalizedString(key, comment: comment)
}

func bringAppToFront() {
    NSApp.activate(ignoringOtherApps: true)
}
