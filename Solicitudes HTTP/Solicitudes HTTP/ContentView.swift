//
//  ContentView.swift
//  Solicitudes HTTP
//
//  Created by Raul Sosa on 01/11/25.
//

import SwiftUI
import SwiftData

import SwiftUI

struct ContentView: View {
    
    let apiBridge = ApiBridge()
    let decoder = JSONDecoder()
    
    @State private var personas: [Persona] = []
    @State private var respuesta: String = "Cargando..."
    
    var body: some View {
        NavigationStack {
            List(personas) { persona in
                NavigationLink(destination: FormView(persona: persona)) {
                    VStack(alignment: .leading) {
                        Text("\(persona.nombre ?? "Sin") \(persona.apellido ?? "Nombre")")
                            .font(.headline)
                        Text(persona.rol ?? "Sin rol")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .navigationTitle("Personas")

            .task {
                cargarDatos()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {

                    NavigationLink(destination: FormView(persona: nil)) {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    func cargarDatos() {
        apiBridge.get(endpoint: "/escuela/persona") { response in
            guard let response = response,
                  let jsonData = response.data(using: .utf8) else {
                DispatchQueue.main.async {
                    self.respuesta = "Error: No se pudo cargar datos."
                }
                return
            }
            
            do {
                let personasDecodificadas = try decoder.decode([Persona].self, from: jsonData)
                DispatchQueue.main.async {
                    self.personas = personasDecodificadas
                }
                
            } catch {
                DispatchQueue.main.async {
                    self.respuesta = "Error: JSON malformado. \(error.localizedDescription)"
                }
            }
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
