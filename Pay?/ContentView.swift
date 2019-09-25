import SwiftUI

struct ContentView: View {
  var body: some View {
    ZStack(alignment: Alignment.top) {
      MapView()
    }.edgesIgnoringSafeArea(.all)
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
