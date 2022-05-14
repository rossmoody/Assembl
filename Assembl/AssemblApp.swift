import SwiftUI

@main
struct AssemblApp: App {
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        WindowGroup {
            Button("Test"){}.padding()
        }
    }
}
