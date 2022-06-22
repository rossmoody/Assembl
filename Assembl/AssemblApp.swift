import Cocoa
import SwiftUI

@main
struct AssemblApp: App {
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            WelcomeWindow().welcomeWindowStyles()
        }
        .windowStyle(.hiddenTitleBar)

        Settings {
            TabView {
                General().tabItem { Label("General", systemImage: "gearshape") }
            }.settingsWindowStyles()
        }
    }
}
