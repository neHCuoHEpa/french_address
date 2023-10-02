//
//  Network.swift
//  FrenchAdress
//
//  Created by Slav Sarafski on 2.10.23.
//

import Foundation

enum NetworkRequestType {
    case search(String)
    
    var path: String {
        switch self {
        case .search(_): return Constants.network.search
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let value):
            return [URLQueryItem(name: "q", value: value),
                    URLQueryItem(name: "type", value: "housenumber")]
        }
    }
    
    var request: URLRequest? {
        var components = URLComponents()
        components.scheme = Constants.network.scheme
        components.host = Constants.network.host
        components.path = self.path
        components.queryItems = self.queryItems
        guard let url = components.url else { return nil }
        print(url)
        return URLRequest(url: url)
    }
}

enum NetworkError: Error {
    case invalidURL
}


// MARK: Network
class Network {
    
    static let shared = Network()
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    private init() {
        let configuration = URLSessionConfiguration.default
        self.session = URLSession(configuration: configuration)
        self.decoder = JSONDecoder()
    }
    
    public func request(_ type: NetworkRequestType) async throws -> [Adress] {
        guard let request = type.request else { throw NetworkError.invalidURL }
        let (data, _) = try await session.data(for: request)
        let address = try decoder.decode(AdressesResponse.self, from: data)
        return address.features
    }
}
