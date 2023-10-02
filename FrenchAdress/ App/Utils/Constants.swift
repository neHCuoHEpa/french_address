//
//  Constants.swift
//  FrenchAdress
//
//  Created by Slav Sarafski on 2.10.23.
//

import Foundation

struct Constants {
    
    static let network = Network()
    
    struct Network {
        let scheme = "https"
        let host = "api-adresse.data.gouv.fr"
        let search = "/search"
    }
    
}
