//
//  BeerViewModel.swift
//  MVVM_CA_test
//
//  Created by Nunzio Giulio Caggegi on 23/02/21.
//

import Foundation
import Combine

class BeerViewModel {
    
    // MARK: - Business logic properties
    
    typealias BeersLoadingState = LoadingState<[Beer], Error>
    typealias BeersPublisher = AnyPublisher<BeersLoadingState, Never>
    lazy var beersLoadingState: BeersPublisher = state.$loadingState.eraseToAnyPublisher()
    
    private let state = State()
    private var cancellables = Set<AnyCancellable>()
    
    private let fetchBeerUseCase: FetchBeerUseCase
    private let filteredBeerUseCase: BeersFilteredUseCase
    
    private let beerRepository: BeerRepository
    
    
    init(beerRepository: BeerRepository) {
        self.beerRepository = beerRepository
        fetchBeerUseCase = FetchBeerUseCase(beerRepository: beerRepository)
        filteredBeerUseCase = BeersFilteredUseCase(beerRepository: beerRepository)
    }
    
    // MARK: - Internal methods
    
    func loadBeers(page: Int) {
        state.loadingState = .loading
     
        fetchBeerUseCase.execute(page: page)
            .sink { completion in
                switch completion {
                
                case .finished:
                    break
                case .failure(let error):
                    self.state.loadingState = .failure(error)
                }
            } receiveValue: { (beers) in
                self.state.loadingState = .success(beers)
            }.store(in: &cancellables)

    }
    
    func loadFilteredBeers(filter: String) {
        state.loadingState = .loading
     
        filteredBeerUseCase.execute(filter: filter)
            .sink { completion in
                switch completion {
                
                case .finished:
                    break
                case .failure(let error):
                    self.state.loadingState = .failure(error)
                }
            } receiveValue: { (beers) in
                self.state.loadingState = .success(beers)
            }.store(in: &cancellables)
    }

}

// MARK: - State

extension BeerViewModel {
    
    class State {
        @Published var loadingState: BeersLoadingState = .idle
    }
    
}
