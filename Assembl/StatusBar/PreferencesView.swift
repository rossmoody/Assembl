import SwiftUI
import KeyboardShortcuts

struct PreferencesView: View {
    var body: some View {
        TabView {
            Form {
                KeyboardShortcuts.Recorder("", name: .shortcut)
            }
        }.frame(width: 450, height: 250)
    }
}

struct Preferences_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView()
    }
}
