import Foundation
import SwiftUI

struct SettingsView: View {
    var body: some View {
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
        .frame(width: 400, height: 300, alignment: .topLeading)
        .padding(30)
    }
}
