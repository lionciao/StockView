//
//  FavoritesRepository.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

protocol FavoritesRepository {
    
    var favoritesStocks: [CompanyModel] { get }
    
    func isFavorites(stock: StockModel) -> Bool
    
    func addToFavorites(stock: StockModel) throws
    
    func removeFromFavorites(stock: StockModel) throws
    
    func doFavoritesAction(stock: StockModel) throws
    
    func getStockList(
        completion: @escaping (Result<[CompanyModel], Error>) -> Void
    )
}
