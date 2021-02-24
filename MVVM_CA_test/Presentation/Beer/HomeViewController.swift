//
//  ViewController.swift
//  MVVM_CA_test
//
//  Created by Nunzio Giulio Caggegi on 23/02/21.
//

import UIKit
import Combine

class HomeViewController: UIViewController {

    // MARK: - Business logic properties
    
    private var cancellables: Set<AnyCancellable> = []
    private let viewModel: BeerViewModel
    private let router: RouterProtocol
    
    // MARK: - Object lifecycle
    
    init(viewModel: BeerViewModel) {
        self.viewModel = viewModel
        self.router = HomeRouter()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBinds()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            self.loadBeers(page: 1)
        }
        
        /*DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.loadBeers(page: 2)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            self.loadBeers(page: 3)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
            self.loadFilteredBeers(filter: "Ale")
        }*/
    }
    
    // MARK: - Configure methods
    
    private func configureBinds() {
        viewModel.beersLoadingState
            .sink { state in
                switch state {
                case .idle:
                    print("IDLE")
                    break
                case .loading:
                    print("LOADING")
                    break
                case .success(let beers):
                    print("SUCCESS")
                    print(beers)
                case .failure(let error):
                    print("FAILURE")
                    print(error.localizedDescription)
                }
            }
            .store(in: &cancellables)
    }

    // MARK: - Private methods
    
    private func loadBeers(page: Int) {
        viewModel.loadBeers(page: page)
    }
    
    private func loadFilteredBeers(filter: String) {
        viewModel.loadFilteredBeers(filter: filter)
    }
}

