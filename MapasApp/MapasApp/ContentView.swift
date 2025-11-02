//
//  ContentView.swift
//  MapasApp
//
//  Created by Raul Sosa on 20/10/25.
//

import SwiftUI
import MapKit
import CoreLocation
import Combine

struct LocationInfo: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct ContentView: View {

    @StateObject private var locationManager = LocationManager()
 
    @State private var cameraPosition: MapCameraPosition = .region(MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 19.847707, longitude: -90.476276),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    ))
    let restaurantes = [
        LocationInfo(name: "Trancas, El gorila", coordinate: CLLocationCoordinate2D(latitude: 19.8436, longitude: -90.5283)),
        LocationInfo(name: "Italiannis", coordinate: CLLocationCoordinate2D(latitude: 19.8450, longitude: -90.5295)),
        LocationInfo(name: "Las Alitas", coordinate: CLLocationCoordinate2D(latitude: 19.8443, longitude: -90.5289))
    ]
    

    @State private var selection: String = "Trancas, El gorila"

    var body: some View {
        ZStack(alignment: .top) {
            Map(position: $cameraPosition) {
                ForEach(restaurantes) { restaurante in
                    Marker(restaurante.name, coordinate: restaurante.coordinate)
                }
            }
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Picker("Escoge un lugar", selection: $selection) { 
                    ForEach(restaurantes) { rest in
                        Text(rest.name).tag(rest.name)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(10)
                .padding(.top, 50)

                Spacer()
                Button {
                    withAnimation {
                        cameraPosition = .region(locationManager.region) //
                    }
                } label: {
                    Text("Ir a mi Ubicación")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding(.bottom, 40)
            }
            .onChange(of: selection) { newSelection in
                if let newLocation = restaurantes.first(where: { $0.name == newSelection }) {
                    
                    let newRegion = MKCoordinateRegion(
                        center: newLocation.coordinate,
                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
                    )
                    withAnimation {
                        cameraPosition = .region(newRegion)
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
