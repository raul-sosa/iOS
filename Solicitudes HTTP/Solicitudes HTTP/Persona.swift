//
//  Persona.swift
//  Solicitudes HTTP
//
//  Created by Raul Sosa on 01/11/25.
//

import  Foundation

struct Persona: Codable, Identifiable {
    let id: Int
    let nombre: String?
    let apellido: String?
    let sexo: String?
    let fh_nac: String?
    let rol: String?
}
