// PaisajeDetail.swift

import SwiftUI

struct PaisajeDetail: View {
    @Environment(ModelData.self) var modelData
    var paisaje: Paisaje

    var paisajeIndex: Int {
        modelData.paisajes.firstIndex(where: { $0.id == paisaje.id })!
    }

    var body: some View {
        @Bindable var modelData = modelData

        ScrollView {
            MapView(coordinate: paisaje.locationCoordinate)
                .frame(height: 300)

            CircularImage(image: paisaje.image)
                .offset(y: -130)
                .padding(.bottom, -130)

            VStack(alignment: .leading) {

                HStack {
                    Text(paisaje.name)
                        .font(.title)

                    FavoriteButton(isSet: $modelData.paisajes[paisajeIndex].isFavorite)
                }

                HStack {
                    Text(paisaje.location)
                    Spacer()
                    Text(paisaje.state)
                }
                .font(.subheadline)
                .foregroundStyle(.secondary)

                Divider()

                Text("Acerca de \(paisaje.name)")
                    .font(.title2)
                Text(paisaje.description)
            }
            .padding()
        }
        .navigationTitle(paisaje.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    let modelData = ModelData()
    return PaisajeDetail(paisaje: modelData.paisajes[0])
        .environment(modelData)
}
