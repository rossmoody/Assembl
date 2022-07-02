import SwiftUI

struct WelcomeGraphic: View {
    var progress: Int

    var body: some View {
        switch progress {
        case 1:
            Image("welcome_permissions")
                .frame(width: 480, height: 240)

        case 2:
            Image("welcome_login")
                .frame(width: 480, height: 240)

        default:
            Image("welcome_shortcut")
                .frame(width: 480, height: 240)
        }
    }
}

struct WelcomeGraphicPreview: PreviewProvider {
    static var previews: some View {
        WelcomeGraphic(progress: 1)
    }
}
