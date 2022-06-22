import SwiftUI

struct WelcomeWindow: View {
    @ObservedObject var model = ProgressBarModel()

    var body: some View {
        VStack {
            VStack {
                WelcomeContent(progress: model.progress)
                WelcomeFooter(model: model, progress: model.progress)
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
