import Foundation
import Cocoa

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
    return NSLocalizedString(key, comment: comment)
}



/**
 Logging extension for printing class details to the console
 */
public protocol Logger : CustomStringConvertible { }

extension Logger {
    var description: String {
        let mirror = Mirror(reflecting: self)
        var str = "\(mirror.subjectType)("
        var first = true
        for (label, value) in mirror.children {
            if let label = label {
                if first {
                    first = false
                } else {
                    str += ", "
                }
                str += label
                str += ": "
                str += "\(value)"
            }
        }
        str += ")"
        return str
    }
}

