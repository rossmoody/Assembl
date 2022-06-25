import SwiftUI

struct WelcomeGraphic: View {
    var progress: Int

    var body: some View {
        switch progress {
        case 1:
            Rectangle()
                .frame(width: 480, height: 240, alignment: .top)
                .foregroundColor(.blue)

        case 2:
            Rectangle()
                .frame(width: 480, height: 240, alignment: .top)
                .foregroundColor(.green)

        default:
            Rectangle()
                .frame(width: 480, height: 240, alignment: .top)
                .foregroundColor(.green)
        }
    }
}
