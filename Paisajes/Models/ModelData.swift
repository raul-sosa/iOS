//
//  ModelData.swift
//  Paisajes
//
//  Created by Raul Sosa on 24/09/25.
//
import Foundation

@available(iOS 17.0, *)
@Observable
class ModelData {
    var paisajes: [Paisaje] = load("landmarkData.json")
}


func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("No se pudo encontrar \(filename) en el bundle principal.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("No se pudo cargar \(filename) desde el bundle principal:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("No se pudo decodificar \(filename) como \(T.self):\n\(error)")
    }
}
