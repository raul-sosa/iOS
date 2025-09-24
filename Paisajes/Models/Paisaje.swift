//
//  Paisaje.swift
//  Paisajes
//
//  Created by Raul Sosa on 23/09/25.
//

import SwiftUI
import Foundation
import CoreLocation

struct Paisaje: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var location: String
    var state: String
    var description: String
    
    private var imageName: String

    var image: Image {
        Image(imageName)
    }
    
    var coordinates: Coordinates
        
    struct Coordinates: Hashable, Codable {
        var latitude: Double
        var longitude: Double
    }
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(
            latitude: coordinates.latitude,
            longitude: coordinates.longitude
        )
    }
}
