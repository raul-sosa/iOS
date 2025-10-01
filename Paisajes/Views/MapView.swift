import SwiftUI
import MapKit

struct MapView: View {
    var coordinate: CLLocationCoordinate2D
    @State private var region: MKCoordinateRegion

    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
        self._region = State(initialValue: MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        ))
    }

    var body: some View {
        Group {
            if #available(iOS 17.0, macOS 14.0, tvOS 17.0, watchOS 10.0, *) {
                Map(initialPosition: .region(region))
            } else {
                Map(coordinateRegion: $region)
            }
        }
    }
}

#Preview {
    MapView(coordinate: CLLocationCoordinate2D(
        latitude: 19.845_911,
        longitude: -90.477_336
    ))
}
