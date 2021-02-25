//
//  HomeAssembler.swift
//  MVVM_CA_test
//
//  Created by Nunzio Giulio Caggegi on 25/02/21.
//

import Foundation

class HomeAssembler: HomeAssemblerInjector { }

protocol HomeAssemblerInjector {
    func resolve(beerRepository: BeerRepository) -> HomeViewController
    
    func resolve(beerRepository: BeerRepository) -> BeerViewModel
    
    func resolve(beerRepository: BeerRepository) -> FetchBeerUseCase
    
    func resolve(beerRepository: BeerRepository) -> BeersFilteredUseCase
}

extension HomeAssembler {
    func resolve(beerRepository: BeerRepository) -> HomeViewController {
        return HomeViewController(viewModel: resolve(beerRepository: beerRepository))
    }
    
    func resolve(beerRepository: BeerRepository) -> BeerViewModel {
        return BeerViewModel(fetchBeerUseCase: resolve(beerRepository: beerRepository), filteredBeerUseCase: resolve(beerRepository: beerRepository))
    }
    
    func resolve(beerRepository: BeerRepository) -> FetchBeerUseCase {
        return FetchBeerUseCase(beerRepository: beerRepository)
    }
    
    func resolve(beerRepository: BeerRepository) -> BeersFilteredUseCase {
        return BeersFilteredUseCase(beerRepository: beerRepository)
    }
}
