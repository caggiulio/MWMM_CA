//
//  BeerViewModel.swift
//  MVVM_CA_test
//
//  Created by Nunzio Giulio Caggegi on 23/02/21.
//

import Foundation
import Combine

import Foundation

protocol BeerViewModelPresentationLogic: AnyObject {
    func presentSuccess(beers: [Beer])
    func presentFailure(error: Error)
}

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
    //private var beers: AnyCancellable?
    
    init(beerRepository: BeerRepository) {
        self.beerRepository = beerRepository
        fetchBeerUseCase = FetchBeerUseCase(beerRepository: beerRepository)
        filteredBeerUseCase = BeersFilteredUseCase(beerRepository: beerRepository)
        
        fetchBeerUseCase.presentationLayer = self
        filteredBeerUseCase.presentationLayer = self
        
        /*self.beers = beerRepository.$fetchedBeers
            .sink(receiveValue: { (beers) in
                self.state.loadingState = .success(beers)
            })*/
    }
    
    // MARK: - Internal methods
    
    func loadBeers(page: Int) {
        state.loadingState = .loading
     
        fetchBeerUseCase.execute(page: page)
    }
    
    func loadFilteredBeers(filter: String) {
        state.loadingState = .loading
     
        filteredBeerUseCase.execute(filter: filter)
    }

}

// MARK: - State

extension BeerViewModel {
    
    class State {
        @Published var loadingState: BeersLoadingState = .idle
    }
    
}

extension BeerViewModel: BeerViewModelPresentationLogic {
    func presentSuccess(beers: [Beer]) {
        self.state.loadingState = .success(beers)
    }
    
    func presentFailure(error: Error) {
        self.state.loadingState = .failure(error)
    }
}
