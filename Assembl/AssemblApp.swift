import SwiftUI
import Cocoa

@main
struct AssemblApp: App {
    
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        Settings {
            SettingsView()
        }
    }
}



