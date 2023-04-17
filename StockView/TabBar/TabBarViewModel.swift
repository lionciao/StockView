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

final class TabBarViewModel {
    
    weak var delegate: TabBarViewModelDelegate?

    let repository: StockListRepository
    
    init(repository: StockListRepository = DefaultStockListRepository()) {
        self.repository = repository
    }
    
    func fetchStockList() {
        repository.getStockList { [weak self] result in
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
}
