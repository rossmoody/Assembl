import Foundation
import SwiftUI
import SwiftUIWindow

final class StatusMenu: NSMenu, NSMenuDelegate {
    @Environment(\.openURL) var openURL

    override init(title: String) {
        super.init(title: title)
        delegate = delegate
        createMenuItems()
    }

    required init(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func createMenuItems() {
        addItem(withTitle: loc("PREFERENCES", "Label for preferences menu in status bar."),
                action: #selector(handlePreferencesAction),
                keyEquivalent: ",")
            .target = self

        addItem(.separator())

        addItem(withTitle: loc("ABOUT", "Label for information about app in status bar."),
                action: #selector(handleAboutAction),
                keyEquivalent: "")
            .target = self

        addItem(withTitle: loc("QUICK_START", "Menu label for onboarding experience."),
                action: #selector(handleQuickStartAction),
                keyEquivalent: "")
            .target = self

        addItem(withTitle: loc("SUBMIT_BUG", "Menu label to send a bug report."),
                action: #selector(handleSubmitBugAction),
                keyEquivalent: "")
            .target = self

        addItem(withTitle: loc("SUPPORT", "Label for help information about app in status bar."),
                action: #selector(handleSupportAction),
                keyEquivalent: "")
            .target = self

        addItem(.separator())

        addItem(withTitle: loc("QUIT", "Label to quit the app."),
                action: #selector(quit),
                keyEquivalent: "q")
            .target = self
    }

    @objc private func quit() {
        NSApp.terminate(nil)
    }

    @objc private func handleAboutAction() {
        NSApp.orderFrontStandardAboutPanel()
        bringAppToFront()
    }

    @objc private func handleSupportAction() {
        openURL(URL(string: "https://rossmoody.com")!)
    }

    @objc private func handlePreferencesAction() {
        NSApp.sendAction(Selector(("showPreferencesWindow:")), to: nil, from: nil)
        bringAppToFront()
    }

    @objc private func handleSubmitBugAction() {
        SwiftUIWindow.open { _ in
            SubmitFeedback()
                .submitFeedbackStyles()
        }
        bringAppToFront()
    }

    @objc private func handleQuickStartAction() {
        SwiftUIWindow.open { _ in
            WelcomeView().welcomeWindowStyles()
        }
        bringAppToFront()
    }
}
