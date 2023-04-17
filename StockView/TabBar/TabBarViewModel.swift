//
//  TabBarViewModel.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import Foundation

final class TabBarViewModel {

    let repository: StockListRepository
    
    init(repository: StockListRepository = DefaultStockListRepository()) {
        self.repository = repository
    }
    
    func fetchStockList() {
        repository.getStockList { result in
            if case let .failure(error) = result {
                // TODO: Error handling
                print("error: \(error)")
            }
        }
    }
}
