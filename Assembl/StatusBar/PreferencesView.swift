import SwiftUI
import Cocoa
import KeyboardShortcuts

struct PreferencesView: View {
    
    @State private var showDockIcon = false
    
    var body: some View {
        Form {
            KeyboardShortcuts.Recorder("", name: .shortcut)
            Toggle.init("Show dock icon", isOn: $showDockIcon)
                .onChange(of: showDockIcon) { value in
                    MenuController
                        .toggleDockIconSetting(state: showDockIcon)
                }
        }.padding(40)
    }
}

struct Preferences_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
