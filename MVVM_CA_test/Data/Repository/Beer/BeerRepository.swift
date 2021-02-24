//
//  BeerRepo.swift
//  MVVM_CA_test
//
//  Created by Nunzio Giulio Caggegi on 23/02/21.
//

import Networking
import Combine

protocol BeerRepoProtocol {
    func fetchBeers(page: Int?) -> AnyPublisher<[Beer], Error>
}

protocol BeerDataToStore {
    var fetchedBeers: [Beer] { get }
}

class BeerRepo: BeerRepoProtocol, BeerDataToStore {
    
    private var worker: BeersWorkerProtocol = Manager.networking.beer
    private var cancellables: Set<AnyCancellable> = []
    
    var fetchedBeers: [Beer] = [Beer]()
        
    func fetchBeers(page: Int? = nil) -> AnyPublisher<[Beer], Error> {
        return Future { promise in
            
            self.worker.getBeers(page: page ?? 1)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    promise(.failure(error))
                }
            } receiveValue: { (beers) in
                self.fetchedBeers += beers
                promise(.success(beers))
            }.store(in: &self.cancellables)
        }.eraseToAnyPublisher()
    }
}
