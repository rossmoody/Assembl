import SwiftUI
import Cocoa

@main
struct AssemblApp: App {
    
    @NSApplicationDelegateAdaptor private var appDelegate: AppDelegate
    
    var body: some Scene {
        Settings {
            TabView {
                GeneralView()
                    .tabItem {
                        Label("General", systemImage: "gearshape")
                    }
                
                AssemblProView()
                    .tabItem {
                        Label("Settings", systemImage: "gearshape")
                    }
            }
        }
    }
}





