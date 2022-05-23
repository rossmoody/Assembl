import SwiftUI

struct AboutView: View {
    var body: some View {
        VStack {
            Image("MenuIcon")
            Text("Text")
        }.frame(width: 300,
                height: 400,
                alignment: .center)
    }
}

struct About_Preview: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
