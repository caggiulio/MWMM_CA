//
//  NetworkingManager.swift
//  Networking_Example
//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation
import Networking

struct NetworkingManager {
    
    let beer: BeersWorkerProtocol = {
        let networking = Networking(
            baseURL: Constants.baseURLBeers
        )
        // networking.logLevel = .none
        return BeerWorker(networking: networking)
    }()
    
}
