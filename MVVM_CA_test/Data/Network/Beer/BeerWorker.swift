//
//  BeerWorker.swift
//  Networking_Example
//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation
import Combine
import Networking

class BeerWorker: BeersWorkerProtocol {
    
    // MARK: - Protocol properties

    var networking: NetworkingProtocol
    
    // MARK: - Object lifecycle
    
    init(networking: NetworkingProtocol) {
        self.networking = networking
    }
    
    // MARK: - Protocol methods

    func getBeers(page: Int) -> AnyPublisher<[Beer], Error> {
        let path = ("/beers", [URLQueryItem.init(name: "page", value: "\(page)"), URLQueryItem.init(name: "per_page", value: "25")])
        let request = NetworkingRequest(method: .get, path: path)
        return networking.send(request: request)
    }
    
}
