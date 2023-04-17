//
//  LocalFavoritesRepository.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import Foundation

final class LocalFavoritesRepository {

    private(set) var favoritesStocks: [CompanyModel] = []
    private let service: StockService
    
    init(service: StockService) {
        self.service = service
    }
}

// MARK: - FavoritesRepository

extension LocalFavoritesRepository: FavoritesRepository {
    
    func isFavorites(stock: StockModel) -> Bool {
        var isFavorites = false
        favoritesStocks.forEach { stock in
            if stock.symbol == stock.symbol {
                isFavorites = true
            }
        }
        return isFavorites
    }
    
    func addToFavorites(stock: StockModel) throws {
        try service.saveStock(stock)
    }
    
    func removeFromFavorites(stock: StockModel) throws {
        try service.removeStock(stock)
    }
    
    func doFavoritesAction(stock: StockModel) throws {
        if isFavorites(stock: stock) {
            try removeFromFavorites(stock: stock)
        } else {
            try addToFavorites(stock: stock)
        }
    }
}

// MARK: - Fetch

extension LocalFavoritesRepository {
    
    func getStockList(
        completion: @escaping (Result<[CompanyModel], Error>) -> Void
    ) {
        do {
            try service.fetchStocks(completion: { [weak self] stocks in
                guard let self = self else { return }
                self.favoritesStocks = stocks
                completion(.success(stocks))
            })
        } catch {
            completion(.failure(error))
        }
    }
}
