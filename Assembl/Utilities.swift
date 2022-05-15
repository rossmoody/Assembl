import Foundation
import Cocoa

/**
 Convenience function for initializing an object and modifying its properties.
 ```
 let label = with(NSTextField()) {
 $0.stringValue = "Foo"
 $0.textColor = .systemBlue
 view.addSubview($0)
 }
 ```
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

