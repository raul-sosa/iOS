//
//  ApiBridge.swift
//  Solicitudes HTTP
//
//  Created by Raul Sosa on 01/11/25.
//
import Foundation

class ApiBridge {
    
    let baseUrl = "https://fi.jcaguilar.dev/v1"

    func get(endpoint: String, completion: @escaping (String?) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
            print("Error: URL inválida")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in

            if let error = error {
                print("Error en dataTask: \(error.localizedDescription)")
                completion(nil)
                return
            }

            guard let data = data else {
                print("No se recibieron datos")
                completion(nil)
                return
            }

            if let responseString = String(data: data, encoding: .utf8) {
                completion(responseString) // ¡Éxito! [cite: 195]
            } else {
                print("No se pudo decodificar el string")
                completion(nil)
            }
        }

        task.resume()
    }
    
    func post(endpoint: String, body: String, completion: @escaping (String?) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        // Decirle al servidor que estamos enviando JSON
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data")
                completion(nil)
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                completion(responseString)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }

    func patch(endpoint: String, body: String, completion: @escaping (String?) -> Void) {
        
        guard let url = URL(string: "\(baseUrl)\(endpoint)") else {
            print("Invalid URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url)
        // La única diferencia clave con POST:
        request.httpMethod = "PATCH"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = body.data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("No data")
                completion(nil)
                return
            }
            
            if let responseString = String(data: data, encoding: .utf8) {
                completion(responseString)
            } else {
                completion(nil)
            }
        }
        task.resume()
    }
}
