//
//  ContentView.swift
//  CoreDataApp
//
//  Created by Raul Sosa on 01/11/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        entity: Item.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.nombre, ascending: true)]
    ) private var items: FetchedResults<Item>

    @State private var showingAddView = false

    var body: some View {
        NavigationStack {
            List {
                ForEach(items) { item in
                    VStack(alignment: .leading) {
                        Text(item.nombre ?? "Sin nombre")
                            .font(.headline)
                        Text("Marca: \(item.marca ?? "N/A")")
                        Text("Precio: $\(item.precio, specifier: "%.2f")")
                        Text("Existencia: \(item.existencia)")
                    }
                }
            }
            .navigationTitle("Inventario (Core Data)")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                FormView()
            }
        }
    }
}

#Preview {
    let controller = PersistenceController.shared
    ContentView()
        .environment(\.managedObjectContext, controller.container.viewContext)
}
