import SwiftUI

struct WelcomeFooter: View {
    @Environment(\.dismiss) private var dismiss

    @Binding var progress: Int

    var body: some View {
        HStack {
            Button("Previous", action: handlePrevious)
                .linkStyles()

            Spacer()

            ProgressDot(step: 0, progress: progress)
            ProgressDot(step: 1, progress: progress)
            ProgressDot(step: 2, progress: progress)

            Spacer()

            if progress < 2 {
                Button("Next", action: handleNext)
                    .linkStyles()
            } else {
                Button("Done", action: { dismiss() })
                    .linkStyles()
            }
        }
    }

    func handlePrevious() {
        if progress > 0 {
            progress -= 1
        }
    }

    func handleNext() {
        if progress < 2 {
            progress += 1
        }
    }
}
