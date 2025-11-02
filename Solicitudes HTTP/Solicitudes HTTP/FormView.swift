//
//  FormView.swift
//  Solicitudes HTTP
//
//  Created by Raul Sosa on 01/11/25.
//

import SwiftUI

struct FormView: View {
    
    let apiBridge = ApiBridge()
    @Environment(\.dismiss) var dismiss

    var persona: Persona?

    var isEditMode: Bool {
        persona != nil
    }

    @State private var nombre: String = ""
    @State private var apellido: String = ""
    @State private var sexo: String = "Otro"
    @State private var fh_nac: Date = Date()
    @State private var rol: String = "Estudiante"
    
    @State private var mensaje: String = ""
    
    let sexos = ["Hombre", "Mujer", "Otro"]
    let roles = ["Estudiante", "Docente", "Administrativo"]
 
    var body: some View {
        Form {
            Section(header: Text("Información Personal")) {
                TextField("Nombre", text: $nombre)
                TextField("Apellido", text: $apellido)
                
                Picker("Sexo", selection: $sexo) {
                    ForEach(sexos, id: \.self) { Text($0) }
                }
                .pickerStyle(.segmented)
                
                DatePicker("Fecha de nacimiento", selection: $fh_nac, displayedComponents: .date)
                
                Picker("Rol", selection: $rol) {
                    ForEach(roles, id: \.self) { Text($0) }
                }
            }
            
            Section {
                Button(isEditMode ? "Guardar Cambios" : "Crear Persona") {
                    guardarCambios()
                }
            }
            
            Text(mensaje)
                .foregroundColor(.red)
        }

        .navigationTitle(isEditMode ? "Editar Persona" : "Crear Persona")
        .onAppear {
            if let persona = persona {
                self.nombre = persona.nombre ?? ""
                self.apellido = persona.apellido ?? ""
                self.sexo = persona.sexo ?? "Otro"
                self.rol = persona.rol ?? "Estudiante"
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd"
                if let dateString = persona.fh_nac, let date = dateFormatter.date(from: dateString) {
                    self.fh_nac = date
                }
            }
        }
    }
    
    func guardarCambios() {
        guard !nombre.isEmpty, !apellido.isEmpty else {
            self.mensaje = "Nombre y apellido no pueden estar vacíos."
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fechaString = dateFormatter.string(from: fh_nac)
        
        // b. Crear instancia
        // Usamos el id existente O un '0' como dummy si es nuevo.
        // El servidor POST debería ignorar este ID y asignar uno nuevo.
        let personaParaGuardar = Persona(
            id: persona?.id ?? 0,
            nombre: self.nombre,
            apellido: self.apellido,
            sexo: self.sexo,
            fh_nac: fechaString,
            rol: self.rol
        )
        
        // c. Codificar a JSON (igual que antes)
        let encoder = JSONEncoder()
        guard let jsonData = try? encoder.encode(personaParaGuardar),
              let jsonString = String(data: jsonData, encoding: .utf8) else {
            self.mensaje = "Error al codificar JSON"
            return
        }
        
        // d. Mandar la información
        if isEditMode {
            // --- MODO EDICIÓN (PATCH) ---
            // (Esta parte es igual que antes)
            guard let id = persona?.id else { return }
            apiBridge.patch(endpoint: "/escuela/persona/\(id)", body: jsonString) { response in
                DispatchQueue.main.async {
                    if response != nil {
                        dismiss() // Cierra la vista
                    } else {
                        self.mensaje = "Error al actualizar en el servidor."
                    }
                }
            }
        } else {
            // --- MODO CREAR (POST) ---
            // ¡Aquí usamos la función POST que ya teníamos!
            apiBridge.post(endpoint: "/escuela/persona", body: jsonString) { response in
                DispatchQueue.main.async {
                    if response != nil {
                        dismiss() // Cierra la vista
                    } else {
                        self.mensaje = "Error al crear en el servidor."
                    }
                }
            }
        }
    }
}
