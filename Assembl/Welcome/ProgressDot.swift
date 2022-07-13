import SwiftUI

struct ProgressDot: View {
    var step: Int
    var progress: Int

    var body: some View {
        Circle().frame(width: 10.0,
                       height: 10.0)
            .foregroundColor(isCurrent() ? .blue : .gray)
    }

    private func isCurrent() -> Bool {
        if progress == step {
            return true
        }

        return false
    }
}
