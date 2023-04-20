//
//  StockDetailViewModel.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import Foundation

final class StockDetailViewModel {
    
    var title: String { "\(stock.symbol) \(stock.nickname)" }
    let stock: StockModel
    private let favoritesRepositoy: FavoritesRepository
    
    fileprivate static let numberFormatter = NumberFormatter()
    
    init(
        stock: StockModel,
        favoritesRepositoy: FavoritesRepository
    ) {
        self.stock = stock
        self.favoritesRepositoy = favoritesRepositoy
    }
}

extension StockDetailViewModel {
    
    func isFavorites() -> Bool {
        return favoritesRepositoy.isFavorites(stock: stock)
    }
    
    func alertContent() -> AlertContent {
        return AlertContent(
            isFavorites: isFavorites(),
            companyText: "\(stock.symbol) \(stock.nickname)"
        )
    }
    
    func doFavoritesAction() {
        do {
            try favoritesRepositoy.doFavoritesAction(stock: stock)
        } catch {
            // TODO: Error handling
            print("error: \(error)")
        }
    }
}

extension StockModel {
    
    var contributedCapitalText: String {
        let formatter = StockDetailViewModel.numberFormatter
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let value = formatter.string(from: NSNumber(value: contributedCapital)) ?? ""
        return "\(value) 元"
    }
    
    var issuedShareText: String {
        let formatter = StockDetailViewModel.numberFormatter
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let value = formatter.string(from: NSNumber(value: contributedCapital)) ?? ""
        return "\(value) 股（含私募 \(privatePlacement) 股）"
    }
    
    var preferredStockText: String {
        let formatter = StockDetailViewModel.numberFormatter
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 0
        let value = formatter.string(from: NSNumber(value: preferredStock)) ?? ""
        return "\(value) 股"
    }
}
