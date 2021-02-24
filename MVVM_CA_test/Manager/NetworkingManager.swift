//
//  NetworkingManager.swift
//  Networking_Example
//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

import Foundation
import Networking

struct NetworkingManager {
    
    // MARK: - Internal properties
    
    let post: PostWorkerProtocol = {
        let networking = Networking(
            baseURL: Constants.baseURLPosts,
            interceptor: NetworkingInterceptor()
        )
        // networking.logLevel = .none
        return PostWorker(networking: networking)
    }()
    
    let beer: BeersWorkerProtocol = {
        let networking = Networking(
            baseURL: Constants.baseURLBeers,
            interceptor: NetworkingInterceptor()
        )
        // networking.logLevel = .none
        return BeerWorker(networking: networking)
    }()
    
}
