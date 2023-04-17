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
    
    fileprivate static let numberFormatter = NumberFormatter()
    
    init(
        stock: StockModel
    ) {
        self.stock = stock
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
