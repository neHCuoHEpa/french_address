//
//  SearchViewModel.swift
//  FrenchAdress
//
//  Created by Slav Sarafski on 2.10.23.
//

import Foundation
import MapKit

class SearchViewModel: ObservableObject {
    
    @Published var searchText: String = ""
    @Published var addresses: [Adress] = []
    
    @Published var selectedAddress: Adress?
    @Published var coordinateRegion: MKCoordinateRegion = .init()
    
    func search(value: String) {
        if value.count < 3 { return }
        Task {
            do {
                let result = try await Network.shared.request(.search(value))
                
                // Update collection view content
                DispatchQueue.main.async {
                    self.addresses = result
                }
                
            } catch {
                print("Request failed with error: \(error)")
            }
        }
    }
    
    func calculateRegion(address: Adress?) {
        if let address,
           address.geometry.coordinates.count > 1 {
            let x = address.geometry.coordinates[0]
            let y = address.geometry.coordinates[1]
            let coordinates = CLLocationCoordinate2D(latitude: y, longitude: x)
            self.coordinateRegion = MKCoordinateRegion(center: coordinates,
                                                       latitudinalMeters: 1000.0,
                                                       longitudinalMeters: 1000.0)

        }
    }
}
