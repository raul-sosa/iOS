//
//  PaisajeList.swift
//  Paisajes
//
//  Created by Raul Sosa on 30/09/25.
//

import SwiftUI

struct PaisajeList: View {
    var body: some View {
        NavigationSplitView {
            List (paisajes) { paisaje in
                NavigationLink {
                    PaisajeDetail(paisaje: paisaje)
                } label: {
                    PaisajeRow(paisaje: paisaje)
                }
            }
            .navigationTitle("Paisajes")
        } detail: {
            Text("Selecciona un paisaje")
        }
    }
}

#Preview() {
    PaisajeList()
}
