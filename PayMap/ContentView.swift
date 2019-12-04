import SwiftUI

struct ContentView : View {
    var body: some View {
        ZStack(alignment: Alignment.top) {
            MapView()
            SlideOverCard {
                VStack {
                    Text("Maitland Bay")
                        .font(.headline)
                    Spacer()
                }
            }
        }
        .edgesIgnoringSafeArea(.vertical)
    }
}
