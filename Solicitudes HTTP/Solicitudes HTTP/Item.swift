//
//  Item.swift
//  Solicitudes HTTP
//
//  Created by Raul Sosa on 01/11/25.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
