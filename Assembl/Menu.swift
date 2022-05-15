import Foundation
import AppKit

class Menu: NSMenu, NSMenuDelegate {
    
    override init(title: String) {
        super.init(title: title)
        self.delegate = delegate
        createMenuItems()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    @objc private func quit() {
        NSApp.terminate(nil)
    }
    
    @objc private func orderABurrito() {
        print("Ordering a burrito!")
    }
    
    func createMenuItems() {
        addItem(withTitle: "Preferences",
                action: #selector(orderABurrito),
                keyEquivalent: ",")
        .target = self
        
        addItem(.separator())
        
        addItem(withTitle: "About",
                action: #selector(orderABurrito),
                keyEquivalent: "")
        .target = self
        
        addItem(withTitle: "Help",
                action: #selector(orderABurrito),
                keyEquivalent: "")
        .target = self
        
        addItem(.separator())
        
        addItem(withTitle: "Quit",
                action: #selector(quit),
                keyEquivalent: "q")
        .target = self
        
    }
}

