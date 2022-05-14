import Foundation
import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    
    func applicationDidFinishLaunching(_ notification: Notification) {
        let statusBar = NSStatusBar.system
        let statusBarMenu = NSMenu(title: "Assembl")
        
        statusBarItem = statusBar.statusItem(withLength: NSStatusItem.squareLength)
        statusBarItem.button?.title = "🌯"
        statusBarItem.button?.toolTip = "Assembl App"
        statusBarItem.menu = statusBarMenu
        
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

