import KeyboardShortcuts
import LaunchAtLogin
import SwiftUI

struct GeneralView: View {
    @AppStorage("showDockIcon") private var showDockIcon = false

    var body: some View {
        Form {
            KeyboardShortcuts.Recorder("Keyboard shortcut", name: .shortcut)

            Text("This keyboard shortcut will assemble the windows on the screen your mouse is currently on.")
                .font(.caption2)
                .foregroundColor(Color.gray)
                .multilineTextAlignment(.leading)

            Divider().padding(.vertical, 10)

            LaunchAtLogin.Toggle { Text("Launch at login") }

            Toggle("Show in Dock", isOn: $showDockIcon)
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
