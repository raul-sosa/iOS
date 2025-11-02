//
//  FormView.swift
//  CoreDataApp
//
//  Created by Raul Sosa on 01/11/25.
//

import SwiftUI
import CoreData

struct FormView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) var dismiss

    @State private var id: UUID = UUID()
    @State private var nombre: String = ""
    @State private var marca: String = ""
    @State private var precio: Float = 0.0
    @State private var existencia: Int32 = 0
    @State private var activo: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Detalles del Producto")) {
                    TextField("Nombre", text: $nombre)
                    TextField("Marca", text: $marca)

                    TextField("Precio", value: $precio, format: .currency(code: "USD"))
                        .keyboardType(.decimalPad)

                    TextField("Existencia", value: $existencia, format: .number)
                        .keyboardType(.numberPad)
                    
                    Toggle("Activo", isOn: $activo)
                }

                Button("Guardar") {
                    guardarItem()
                    dismiss()
                }
            }
            .navigationTitle("Nuevo Item")
        }
    }

    private func guardarItem() {
        let newItem = Item(context: viewContext)
        newItem.id = id
        newItem.nombre = nombre
        newItem.marca = marca
        newItem.precio = precio
        newItem.existencia = existencia
        newItem.activo = activo

        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Error al guardar: \(nsError), \(nsError.userInfo)")
        }
    }
}
