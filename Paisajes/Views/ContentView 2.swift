//
//  ContentView 2.swift
//  Paisajes
//
//  Created by Raul Sosa on 30/09/25.
//


//
//  ContentView.swift
//  Paisajes
//
//  Created by Alumno 17 on 10/09/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        VStack {
            MapView()
                .frame(height: 300)
            
            
            CircularImage()
                .offset(y: -130)
                .padding(.bottom, -130)
            
            VStack(alignment: .leading) {
                Text("Facultad de Ingenieria")
                    .font(.title)
                .foregroundColor(.green)
                
                HStack {
                    Text("Siglo XXIII")
                        .font(.subheadline)
                    .multilineTextAlignment(.leading)
                    Spacer()
                    Text("Campeche")
                        .multilineTextAlignment(.leading)
                        .font(.subheadline)
                }
                Divider()
                
                Text("Acerca de la Facultad de Ingenieria")
                    .font(.title2)
                Text("La mejor escuela de la ciudad")
               
            }
            .padding()
            
            Spacer()
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
