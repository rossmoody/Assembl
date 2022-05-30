import Cocoa
import Foundation

class StatusItemManager: NSObject {
    var statusItem: NSStatusItem?

    var popover: NSPopover?

    var converterVC: ConverterViewController?
}
