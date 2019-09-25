import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  func makeUIView(context: Context) -> MKMapView {
    MKMapView(frame: .zero)
  }

  func updateUIView(_ view: MKMapView, context: Context) {
  }
}

struct MapView_Preview: PreviewProvider {
  static var previews: some View {
    MapView()
  }
}
