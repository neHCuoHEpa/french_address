//
//  Models.swift
//  FrenchAdress
//
//  Created by Slav Sarafski on 2.10.23.
//

import Foundation

struct AdressesResponse: Decodable {
    var type: String
    var version: String
    var attribution: String
    var licence: String
    var query: String
    var limit: Int
    var features: [Adress]
}

struct Adress: Decodable, Identifiable, Equatable {
    
    var id: String { properties.id }
    
    var type: String
    var geometry: AdressGeometry
    var properties: AdressesProperties
    
    var formatted: String {
        if let housenumber = properties.housenumber,
           !housenumber.isEmpty {
            return "1, route de la Paix, 75001 Paris\n\(housenumber),\(properties.street),\n\(properties.postcode) \(properties.city)"
        }
        return "1, route de la Paix, 75001 Paris\n\\(properties.street),\n\(properties.postcode) \(properties.city)"
    }
    
    static func == (lhs: Adress, rhs: Adress) -> Bool {
        lhs.id == rhs.id
    }
}

struct AdressGeometry: Decodable {
    var type: String
    var coordinates: [Double]
}

struct AdressesProperties: Decodable {
    var id: String
    var type: String
    var name: String
    var postcode: String
    var citycode: String
    var city: String
    var district: String?
    var context: String
    var street: String
    var label: String
    var score: Double
    var housenumber: String?
    var x: Double
    var y: Double
    var importance: Double
}
