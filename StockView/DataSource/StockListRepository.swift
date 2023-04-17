//
//  StockListRepository.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import Foundation

protocol StockListRepository {
    
    /// For getting stocks by its industry ID.
    var industryIDToStocksMap: [IndustryID: [StockModel]] { get }
    
    /// For getting stock by its stock symbol.
    var symbolToStockMap: [String: StockModel] { get }
    
    func getStockList(
        completion: @escaping (Result<[StockModel], Error>) -> Void
    )
}
