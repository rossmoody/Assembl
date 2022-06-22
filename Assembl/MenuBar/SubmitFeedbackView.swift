import Foundation
import SwiftUI

struct SubmitFeedback: View {
    @State private var email: String = ""
    @State private var description: String = ""

    var body: some View {
        HStack(alignment: .top, spacing: 20.0) {
            VStack {
                Image("app_icon")
                    .resizable()
                    .frame(width: 60, height: 60, alignment: .top)
            }.frame(width: 60, height: 400, alignment: .topLeading)

            VStack(alignment: .trailing, spacing: 16) {
                VStack(alignment: .leading) {
                    Text("Submit feedback")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding(.bottom, 2)

                    Text("Please provide a detailed description of the problem, question, or idea. Thanks for helping to make Assembl a better experience.")
                        .font(.body)
                        .lineSpacing(6)
                        .opacity(0.80)
                        .padding(.bottom, 12)
                }

                Picker("Feedback type", selection: .constant(1)) {
                    Text("Feedback").tag(1)
                    Text("Bug report").tag(2)
                    Text("Feature request").tag(2)
                }
                .labelsHidden()

                TextField("email@example.com", text: $email)
                    .styles()

                TextEditor(text: $description)
                    .styles()

                Button("Send feedback") {
                    print("Test")
                }
            }
        }
    }
}

struct SubmitBugPreview: PreviewProvider {
    static var previews: some View {
        SubmitFeedback()
            .submitFeedbackStyles()
    }
}
