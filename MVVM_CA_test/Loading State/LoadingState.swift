//
//  LoadingState.swift
//  Networking_Example
//
//  Copyright © 2021 IQUII s.r.l. All rights reserved.
//

enum LoadingState<Value, Error: Swift.Error> {
    case idle
    case loading
    case success(Value)
    case failure(Error)
}

extension LoadingState {
    
    var value: Value? {
        guard case .success(let value) = self else { return nil }
        return value
    }
    
}

extension LoadingState {
    
    func map<T>(_ transform: (Value) -> T) -> LoadingState<T, Error> {
        switch self {
        case .idle:
            return .idle
        case .loading:
            return .loading
        case .success(let value):
            return .success(transform(value))
        case .failure(let error):
            return .failure(error)
        }
    }
    
}
