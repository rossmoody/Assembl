import Foundation
import SwiftUI

final class MenuController: NSMenu, NSMenuDelegate {
    @Environment(\.openURL) var openURL
    
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
                action: #selector(handlePreferencesAction),
                keyEquivalent: ",")
        .target = self
        
        addItem(.separator())
        
        addItem(withTitle: loc("ABOUT", "Label for information about app in status bar."),
                action: #selector(handleAboutAction),
                keyEquivalent: "")
        .target = self
        
        addItem(withTitle: loc("CHECK_FOR_UPDATES", "Menu label to manually check for updates from App Store."),
                action: #selector(checkForUpdates),
                keyEquivalent: "")
        .target = self
        
        addItem(withTitle: loc("SUPPORT", "Label for help information about app in status bar."),
                action: #selector(handleSupportAction),
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
    
    @objc private func handleAboutAction() {
        //TODO
        NSApp.orderFrontStandardAboutPanel(options: [:])
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @objc private func handleSupportAction() {
        openURL(URL(string: "https://rossmoody.com")!)
    }
    
    @objc private func handlePreferencesAction() {
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        NSApp.activate(ignoringOtherApps: true)
    }
    
    @objc private func checkForUpdates() {
        print("To do")
    }
    
    static func toggleDockIconSetting(state showDockIcon: Bool) {
        if showDockIcon {
            NSApp.setActivationPolicy(NSApplication.ActivationPolicy.regular)
        } else {
            NSApp.setActivationPolicy(NSApplication.ActivationPolicy.accessory)
        }
    }
}
