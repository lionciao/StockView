//
//  StockManagedObject+Decodable.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import Foundation

extension StockManagedObject {
    
    func decode() -> CompanyModel? {
        guard
            let symbol = symbol,
            let nickname = nickname
        else { return nil }
        return CompanyModel(
            symbol: symbol,
            nickname: nickname
        )
    }
}
