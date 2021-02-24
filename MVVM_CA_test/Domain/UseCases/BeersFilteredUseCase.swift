//
//  GetBeersFilteredUseCase.swift
//  MVVM_CA_test
//
//  Created by Nunzio Giulio Caggegi on 23/02/21.
//

import Foundation
import Combine

protocol BeersFilteredUseCaseProtocol {
    func execute(filter: String) -> AnyPublisher<[Beer], Error>
}

/// In this use case i would filters the fetched beers. If there aren't fetched beers, call the API to fetch them
class BeersFilteredUseCase: BeersFilteredUseCaseProtocol {
    
    private let beerRepository: BeerRepository
    private var cancellables: Set<AnyCancellable> = []
    
    var filter: String?
    
    init(beerRepository: BeerRepository) {
        self.beerRepository = beerRepository
    }
    
    func execute(filter: String) -> AnyPublisher<[Beer], Error> {
        return Future { promise in
            guard !self.beerRepository.fetchedBeers.isEmpty else {
                promise(.failure(NSError(domain: "No data", code: -1, userInfo: nil)))
                return
            }
            
            let beers = self.beerRepository.fetchedBeers
            let filteredBeers = beers.filter({ (beer) -> Bool in
                return (beer.name?.contains(filter) ?? false)
            })
            
            promise(.success(filteredBeers))
        }.eraseToAnyPublisher()
    }
    
}

