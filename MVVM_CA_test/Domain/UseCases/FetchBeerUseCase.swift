//
//  FetchBeerUseCase.swift
//  MVVM_CA_test
//
//  Created by Nunzio Giulio Caggegi on 23/02/21.
//

import Foundation
import Combine

protocol FetchBeerUseCaseProtocol {
    func execute(page: Int)
}

class FetchBeerUseCase: FetchBeerUseCaseProtocol {
    
    private let beerRepository: BeerRepository
    private var cancellables: Set<AnyCancellable> = []
    weak var presentationLayer: BeerViewModelPresentationLogic?
        
    init(beerRepository: BeerRepository) {
        self.beerRepository = beerRepository
    }
    
    func execute(page: Int) {
        beerRepository.fetchBeers(page: page)
            .sink(receiveCompletion: { completion in
                switch completion {
                
                case .finished:
                    break
                case .failure(let error):
                    self.presentationLayer?.presentFailure(error: error)
                }
            }, receiveValue: { beers in
                self.presentationLayer?.presentSuccess(beers: beers)
            }).store(in: &cancellables)
    }    
}
