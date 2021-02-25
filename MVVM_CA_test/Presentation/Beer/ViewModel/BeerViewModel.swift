//
//  BeerViewModel.swift
//  MVVM_CA_test
//
//  Created by Nunzio Giulio Caggegi on 23/02/21.
//

import Combine
import MVVM_Framework

class BeerViewModel {
    
    // MARK: - Business logic properties
    
    typealias BeersLoadingState = LoadingState<[Beer], Error>
    typealias BeersPublisher = AnyPublisher<BeersLoadingState, Never>
    lazy var beersLoadingState: BeersPublisher = state.$loadingState.eraseToAnyPublisher()
    
    private let state = State()
    private var cancellables = Set<AnyCancellable>()
    
    private let fetchBeerUseCase: FetchBeerUseCase
    private let filteredBeerUseCase: BeersFilteredUseCase
    
    init(fetchBeerUseCase: FetchBeerUseCase, filteredBeerUseCase: BeersFilteredUseCase) {
        self.fetchBeerUseCase = fetchBeerUseCase
        self.filteredBeerUseCase = filteredBeerUseCase
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
