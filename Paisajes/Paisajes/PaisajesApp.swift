//
//  PaisajesApp.swift
//  Paisajes
//
//  Created by Alumno 17 on 10/09/25.
//

import SwiftUI

@main
struct PaisajesApp: App {

    @State private var modelData = ModelData()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(modelData)
        }
    }
}
