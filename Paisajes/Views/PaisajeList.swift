// PaisajeList.swift

import SwiftUI

struct PaisajeList: View {
    // Modificado en Práctica 3: Se conecta al entorno. [cite: 120]
    @Environment(ModelData.self) var modelData
    
    // Añadido en Práctica 3: Estado para controlar el filtro. [cite: 47]
    @State private var showFavoritesOnly = false
    
    // Añadido en Práctica 3: Filtra los paisajes según el estado. [cite: 57]
    var filteredPaisajes: [Paisaje] {
        modelData.paisajes.filter { paisaje in
            (!showFavoritesOnly || paisaje.isFavorite) // [cite: 59]
        }
    }

    var body: some View {
        NavigationSplitView {
            List {                Toggle(isOn: $showFavoritesOnly) {
                    Text("Solo favoritos") 
                }
                ForEach(filteredPaisajes) { paisaje in
                    NavigationLink {
                        PaisajeDetail(paisaje: paisaje)
                    } label: {
                        PaisajeRow(paisaje: paisaje)
                    }
                }
            }
            .animation(.default, value: filteredPaisajes)
            .navigationTitle("Paisajes")
        } detail: {
            Text("Selecciona un paisaje")
        }
    }
}

#Preview {
    PaisajeList()
        .environment(ModelData())
}
