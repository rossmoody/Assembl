import Foundation
import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            GeneralView()
                .tabItem {
                    Label("General", systemImage: "gearshape")
                }
        }
        .frame(width: 300, height: 200, alignment: .topLeading)
        .padding(30)
    }
}
