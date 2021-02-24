//
//  FetchBeerUseCase.swift
//  MVVM_CA_test
//
//  Created by Nunzio Giulio Caggegi on 23/02/21.
//

import Foundation
import Combine

protocol FetchBeerUseCaseProtocol {
    func execute(page: Int) -> AnyPublisher<[Beer], Error>
}

class FetchBeerUseCase: FetchBeerUseCaseProtocol {
    
    private let beerRepository: BeerRepository
    private var cancellables: Set<AnyCancellable> = []
        
    init(beerRepository: BeerRepository) {
        self.beerRepository = beerRepository
    }
    
    func execute(page: Int) -> AnyPublisher<[Beer], Error> {
        return Future { promise in
            self.beerRepository.fetchBeers(page: page)
                .sink(receiveCompletion: { completion in
                    switch completion {
                    
                    case .finished:
                        break
                    case .failure(let error):
                        promise(.failure(error))
                    }
                }, receiveValue: { beers in
                    promise(.success(beers))
                }).store(in: &self.cancellables)
        }.eraseToAnyPublisher()
    }    
}
