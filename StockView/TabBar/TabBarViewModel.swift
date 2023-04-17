//
//  TabBarViewModel.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import Foundation

protocol TabBarViewModelDelegate: AnyObject {

    func tabBarViewModel(
        _ viewModel: TabBarViewModel,
        didFetchStockList stocks: [StockModel]
    )
}

protocol TabBarViewModelFavoritesDelegate: AnyObject {
    
    func tabBarViewModel(
        _ viewModel: TabBarViewModel,
        didFetchFavoritesList stocks: [CompanyModel]
    )
}

final class TabBarViewModel {
    
    weak var delegate: TabBarViewModelDelegate?
    weak var favoritesDelegate: TabBarViewModelFavoritesDelegate?

    let listRepository: StockListRepository
    let favoritesRepository: FavoritesRepository
    
    init(
        listRepository: StockListRepository = DefaultStockListRepository(),
        favoritesRepository: FavoritesRepository = LocalFavoritesRepository(
            service: LocalService(persistence: Persistence())
        )
    ) {
        self.listRepository = listRepository
        self.favoritesRepository = favoritesRepository
    }
    
    func fetchStockList() {
        listRepository.getStockList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let stocks):
                self.delegate?.tabBarViewModel(self, didFetchStockList: stocks)
            case .failure(let error):
                // TODO: Error handling
                print("error: \(error)")
            }
        }
    }
    
    func fetchFavoritesList() {
        favoritesRepository.getStockList { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let stocks):
                self.favoritesDelegate?.tabBarViewModel(self, didFetchFavoritesList: stocks)
            case .failure(let error):
                // TODO: Error handling
                print("error: \(error)")
            }
        }
    }
}
