import Foundation
import AppKit

final class MenuController: NSMenu, NSMenuDelegate {
    
    override init(title: String) {
        super.init(title: title)
        self.delegate = delegate
        createMenuItems()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func createMenuItems() {
        addItem(withTitle: loc("PREFERENCES", "Label for preferences menu in status bar."),
                action: #selector(openPreferences),
                keyEquivalent: ",")
        .target = self
        
        addItem(.separator())
        
        addItem(withTitle: loc("ABOUT", "Label for information about app in status bar."),
                action: #selector(showAboutView),
                keyEquivalent: "")
        .target = self
        
        addItem(withTitle: loc("CHECK_FOR_UPDATES", "Menu label to manually check for updates from App Store."),
                action: #selector(checkForUpdates),
                keyEquivalent: "")
        .target = self
        
        addItem(withTitle: loc("HELP", "Label for help information about app in status bar."),
                action: #selector(showHelpPanel),
                keyEquivalent: "")
        .target = self
        
        addItem(.separator())
        
        addItem(withTitle: loc("QUIT", "Label to quit the app."),
                action: #selector(quit),
                keyEquivalent: "q")
        .target = self
        
    }
    
    @objc private func quit() {
        NSApp.terminate(nil)
    }
    
    @objc private func showAboutView() {
        NSApp.orderFrontStandardAboutPanel()
    }
    
    @objc private func checkForUpdates() {
        print("To do")
    }
    
    @objc private func showHelpPanel() {
        print("To do")
    }
    
    @objc private func openPreferences() {
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
    }
}
