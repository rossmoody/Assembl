import SwiftUI

struct WelcomeWindow: View {
    @State var progress = 0

    var body: some View {
        VStack {
            WelcomeGraphic(progress: progress)

            VStack(alignment: .center) {
                WelcomeContent(progress: progress)
                Spacer()
                WelcomeFooter(progress: $progress)
            }.padding(40)
        }
    }
}

struct WelcomeWindowPreview: PreviewProvider {
    static var previews: some View {
        WelcomeWindow()
            .welcomeWindowStyles()
    }
}
