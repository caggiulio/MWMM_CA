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

/// In this use case i would filters the fetched beers. If there aren't fetched beers, call the API to fetch them
class BeersFilteredUseCase: BeersFilteredUseCaseProtocol {
    
    private let beerRepository: BeerRepository
    private var cancellables: Set<AnyCancellable> = []
    weak var presentationLayer: BeerViewModelPresentationLogic?
    
    var filter: String?
    
    init(beerRepository: BeerRepository) {
        self.beerRepository = beerRepository
    }
    
    func execute(filter: String) {
        guard !beerRepository.fetchedBeers.isEmpty else {
            self.presentationLayer?.presentFailure(error: NSError(domain: "No data Fetched", code: 0, userInfo: nil))
            return
        }
        
        getFilteredBeers(beers: beerRepository.fetchedBeers, filter: filter)
    }
    
    private func getFilteredBeers(beers: [Beer], filter: String) {
        let filteredBeers = beers.filter({ (beer) -> Bool in
            return (beer.name?.contains(filter) ?? false)
        })
        
        presentationLayer?.presentSuccess(beers: filteredBeers)
    }
    
}

