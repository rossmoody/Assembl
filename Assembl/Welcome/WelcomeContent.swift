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
            HeadlineDescription(title: "Enable permissions",
                                description: "Assembl requires Accessibility permissions in order to move and resize windows. Go to System Preferences > Security & Privacy > Privacy > Accessibility and ensure Assembl is checked. If the items are disabled, click the padlock and enter your password.")

        case 2:
            HeadlineDescription(title: "Launch on login",
                                description: "Assembl runs in the background and isn’t available in the dock by default. To save yourself trips to the Applications folder, it is advised to launch automatically during login.")

        default:
            HeadlineDescription(title: "Set a keyboard shortcut",
                                description: "Assembl uses this shortcut to organize available windows from the screen your mouse cursor is on. It can be changed later in Preferences.")
        }
    }
}
