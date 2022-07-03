import KeyboardShortcuts
import LaunchAtLogin
import SwiftUI

struct HeadlineDescription: View {
    var title: String
    var description: String

    var body: some View {
        VStack {
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.bottom, 4)
            Text(description)
                .font(.body)
                .lineSpacing(3)
                .multilineTextAlignment(.center)
        }
    }
}

struct WelcomeContent: View {
    var progress: Int

    var body: some View {
        switch progress {
        case 1:
            HeadlineDescription(title: loc("WELCOME_SHORTCUT_HEADLINE", ""),
                                description: loc("WELCOME_SHORTCUT_DESCRIPTION", ""))

            KeyboardShortcuts.Recorder("", name: .shortcut)
                .padding(.top)

        case 2:
            HeadlineDescription(title: loc("WELCOME_LOGIN_HEADLINE", "Login headline"),
                                description: loc("WELCOME_LOGIN_DESCRIPTION", "Login description"))

            LaunchAtLogin.Toggle {
                Text("Launch at login").padding(.top)
            }

        default:
            HeadlineDescription(title: loc("WELCOME_PERMISSION_HEADLINE", ""),
                                description: loc("WELCOME_PERMISSION_DESCRIPTION", ""))
        }
    }
}
