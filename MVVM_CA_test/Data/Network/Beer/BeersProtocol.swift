//
//  BeersProtocol.swift
//  Networking_Example
//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation
import Combine
import Networking

protocol BeersWorkerProtocol {
    var networking: NetworkingProtocol { get }

    func getBeers(page: Int) -> AnyPublisher<[Beer], Swift.Error>
}
