//
//  GetBeersFilteredUseCase.swift
//  MVVM_CA_test
//
//  Created by Nunzio Giulio Caggegi on 23/02/21.
//

import Foundation
import Combine

protocol BeersFilteredUseCaseProtocol {
    func execute(filter: String)
}

class BeersFilteredUseCase: BeersFilteredUseCaseProtocol {
    
    var beerRepo: BeerRepo?
    private var cancellables: Set<AnyCancellable> = []
    var presentationLayer: BeerViewModelPresentationLogic?
    
    var filter: String?
    
    init(beerRepo: BeerRepo, presentationLayer: BeerViewModelPresentationLogic) {
        self.beerRepo = beerRepo
        self.presentationLayer = presentationLayer
    }
    
    func execute(filter: String) {
        beerRepo?.fetchBeers()
            .sink(receiveCompletion: { completion in
                switch completion {
                
                case .finished:
                    break
                case .failure(let error):
                    self.presentationLayer?.presentError(error: error)
                }
            }, receiveValue: { beers in
                self.getFilteredBeers(beers: beers, filter: filter)
            }).store(in: &cancellables)
    }
    
    private func getFilteredBeers(beers: [Beer], filter: String) {
        let filteredBeers = beers.filter({ (beer) -> Bool in
            return (beer.name?.contains(filter) ?? false)
        })
        
        presentationLayer?.presentBeers(beers: filteredBeers)
    }
    
}

