import SwiftUI

extension TextField {
    func styles() -> some View {
        frame(height: 32)
            .textFieldStyle(.plain)
            .padding(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("border"), lineWidth: 1.0)
            )
    }
}

extension TextEditor {
    func styles() -> some View {
        textFieldStyle(.plain)
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 0, trailing: 6))
            .cornerRadius(5)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color("border"), lineWidth: 1.0)
            )
    }
}

extension Button {
    func linkStyles() -> some View {
        buttonStyle(.link)
            .font(.system(size: 14, weight: .semibold, design: .default))
    }
}

extension NSTextView {
    override open var frame: CGRect {
        didSet {
            backgroundColor = .clear
            drawsBackground = true
        }
    }
}

extension View {
    func submitFeedbackStyles() -> some View {
        preferredColorScheme(.dark)
            .frame(width: 480,
                   height: 420,
                   alignment: .topLeading)
            .padding(32)
    }

    func welcomeWindowStyles() -> some View {
        frame(width: 520, height: 540, alignment: .top)
    }

    func settingsWindowStyles() -> some View {
        frame(width: 300, height: 200, alignment: .topLeading)
            .padding(30)
    }
}
