import KeyboardShortcuts
import LaunchAtLogin
import SwiftUI

struct GeneralView: View {
    @AppStorage("showDockIcon") private var showDockIcon = false

    var body: some View {
        Form {
            KeyboardShortcuts.Recorder(loc("PREF_SHORTCUT_LABEL", ""), name: .shortcut)

            Text(loc("PREF_SHORTCUT_DESCRIPTION", "Description of what the app does when shortcut pressed."))
                .font(.caption2)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.leading)

            Divider().padding(.vertical, 10)

            LaunchAtLogin.Toggle { Text(loc("PREF_LAUNCH_LOGIN", "")) }

            Toggle(loc("PREF_DOCK", ""), isOn: $showDockIcon)
                .onAppear {
                    setDockIcon(state: showDockIcon)
                }
                .onChange(of: showDockIcon) { _ in
                    setDockIcon(state: showDockIcon)
                }
        }
    }

    private func setDockIcon(state showDockIcon: Bool) {
        NSApp.setActivationPolicy(showDockIcon ? .regular : .accessory)
        bringAppToFront()
    }
}

struct GeneralViewPreview: PreviewProvider {
    static var previews: some View {
        GeneralView()
            .frame(width: 600, height: 600, alignment: .top)
            .padding()
    }
}
