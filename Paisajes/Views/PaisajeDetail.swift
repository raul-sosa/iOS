import SwiftUI

struct PaisajeDetail: View {
    var paisaje: Paisaje
    
    var body: some View {
        ScrollView {
            VStack {
                MapView(coordinate: paisaje.locationCoordinate)
                    .frame(height: 300)
                
                CircularImage(image: paisaje.image)
                    .offset(y: -130)
                    .padding(.bottom, -130)
                
                VStack(alignment: .leading) {
                    Text(paisaje.name)
                        .font(.title)
                    
                    HStack {
                        Text(paisaje.location)
                        Spacer()
                        Text(paisaje.state)
                    }
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    Divider()
                    
                    Text("Acerca de \(paisaje.name)")
                        .font(.title) // La práctica usa .title2, pero .title también es válido.
                    Text(paisaje.description)
                }
                .padding()
            }
        }

        .navigationTitle(paisaje.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    PaisajeDetail(paisaje: paisajes[0])
}
