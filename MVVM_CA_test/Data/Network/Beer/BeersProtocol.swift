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

    @available(iOS 13.0, *)
    func getBeers() -> AnyPublisher<[Beer], Swift.Error>
}
