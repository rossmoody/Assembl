import SwiftUI

struct HeadlineDescription: View {
    var title: String
    var description: String

    var body: some View {
        VStack {
            Text(title)
            Text(description)
        }
    }
}

struct WelcomeContent: View {
    var progress: Double

    var body: some View {
        switch progress {
        case 1.0:
            HeadlineDescription(title: "Headlines 2", description: "Descriptions 2")

        case 2.0:
            HeadlineDescription(title: "Headlines 3", description: "Descriptions 3")

        default:
            HeadlineDescription(title: "Headlines 1", description: "Descriptions 1")
        }
    }
}
