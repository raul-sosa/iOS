//
//  ModelData.swift
//  Paisajes
//
//  Created by Raul Sosa on 24/09/25.
//
import Foundation

func load<T: Decodable>(_ fileName: String) -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: fileName, withExtension: nil)
    else {
        fatalError("No encontre el archivo \(fileName) en los recursos de la app.")
    }
    
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("No pude abrir el archivo \(fileName) de los recursos de la app:\n\(error)")
    }
    
    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("No pude leer \(fileName) como \(T.self):\n\(error)")
    }
}

var paisajes: [Paisaje] = load("landmarkData.json")

