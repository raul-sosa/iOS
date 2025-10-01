//
//  PaisajeRow.swift
//  Paisajes
//
//  Created by Raul Sosa on 30/09/25.
//

import SwiftUI

struct PaisajeRow: View {
    var paisaje: Paisaje
    
    var body: some View {
        HStack {
            paisaje.image
                .resizable()
                .frame(width: 50, height: 50)
            Text(paisaje.name)
            
            Spacer()
        }
    }
}

#Preview("Facultad") {
    Group{
        PaisajeRow(paisaje: paisajes[0])
        PaisajeRow(paisaje: paisajes[1])
    }
}

