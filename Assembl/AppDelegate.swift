import Foundation
import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusItem: NSStatusItem!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let statusBar = NSStatusBar.system
        let statusBarMenu = NSMenu(title: "Assembl")
        
        statusItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        statusItem.button?.title = "🌯"
        statusItem.button?.toolTip = "Assembl App"
        statusItem.menu = statusBarMenu
        
        statusBarMenu.insertItem(withTitle: "Preferences",
                                 action: #selector(AppDelegate.orderABurrito),
                                 keyEquivalent: "",
                                 at: 0)
        
        statusBarMenu.insertItem(.separator(), at: 1)
        
        statusBarMenu.insertItem(withTitle: "Quit",
                                 action: #selector(AppDelegate.orderABurrito),
                                 keyEquivalent: "",
                                 at: 2)
    }
    
    @objc func orderABurrito() {
        print("Ordering a burrito!")
    }
}

