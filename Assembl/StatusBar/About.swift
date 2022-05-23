import SwiftUI

struct About: View {
    var body: some View {
        VStack {
            Image("app-icon")
            Text("Text")
        }.frame(width: 300,
                height: 400,
                alignment: .center)
    }
}

struct About_Preview: PreviewProvider {
    static var previews: some View {
        About()
    }
}
