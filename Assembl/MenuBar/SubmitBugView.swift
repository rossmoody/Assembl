import Foundation
import SwiftUI

struct SubmitBug: View {
    var body: some View {
        Text("Test")
    }
}

struct SubmitBugPreview: PreviewProvider {
    static var previews: some View {
        SubmitBug()
            .frame(width: 300,
                   height: 200,
                   alignment: .topLeading)
            .padding(30)
    }
}
