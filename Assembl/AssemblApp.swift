import SwiftUI
import KeyboardShortcuts

@main
struct AssemblApp: App {
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            Form {
                KeyboardShortcuts.Recorder("", name: .shortcut)
            }.padding()
        }
        
        Settings {}
    }
}


