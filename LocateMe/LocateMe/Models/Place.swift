//
//  Place.swift
//  LocateMe
//
//  Created by Abdul Mubeen Mohammed on 2025-04-11.
//

import Foundation

struct Place: Identifiable, Codable {
    // Using a computed identifier from the unique combination of latitude and longitude
    var id: String { "\(lat)-\(lon)" }
    let displayName: String
    let lat: String
    let lon: String
    
    enum CodingKeys: String, CodingKey {
        case displayName = "display_name"
        case lat
        case lon
    }
}
