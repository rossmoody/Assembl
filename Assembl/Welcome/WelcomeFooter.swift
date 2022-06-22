import SwiftUI

struct WelcomeFooter: View {
    @Environment(\.dismiss) private var dismiss

    var model: ProgressBarModel

    var progress: Double

    var body: some View {
        HStack {
            Button("Previous", action: model.handlePrevious)
                .linkStyles()

            ProgressView(value: model.progress, total: 2.0)

            if progress < 2.0 {
                Button("Next", action: model.handleNext)
                    .linkStyles()
            } else {
                Button("Done", action: { dismiss() }).linkStyles()
            }
        }
    }
}

final class ProgressBarModel: ObservableObject {
    @Published var progress = 0.0

    func handlePrevious() {
        if progress > 0.0 {
            progress -= 1.0
        }
    }

    func handleNext() {
        if progress < 2.0 {
            progress += 1.0
        }
    }
}
