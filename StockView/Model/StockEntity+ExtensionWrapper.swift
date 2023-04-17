//
//  StockEntity+ExtensionWrapper.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import Foundation

extension StockEntity: ExtensionCompatibleValue {}

extension ExtensionWrapper where Base == StockEntity {
    
    func map() -> StockModel {
        return StockModel(
            industryID: base.industryID,
            symbol: base.symbol,
            nickname: base.nickname,
            name: base.name,
            url: URL(string: base.urlString),
            chairman: base.chairman,
            generalManager: base.generalManager,
            started: map(dateString: base.started),
            listed: map(dateString: base.listed),
            telephoneNumber: base.telephoneNumber,
            taxIDNumber: base.taxIDNumber,
            address: base.address,
            contributedCapital: Int(base.contributedCapital) ?? 0,
            parValuePerShareOfCommonStockText: base.parValuePerShareOfCommonStock,
            parValuePerShareOfCommonStock: map(parValuePerShareOfCommonStockText: base.parValuePerShareOfCommonStock),
            preferredStock: Int(base.preferredStock) ?? 0,
            privatePlacement: Int(base.privatePlacement) ?? 0
        )
    }
}

private extension ExtensionWrapper where Base == StockEntity {
    
    /// get int value out of text.
    /// e.g. ("新台幣10.0000元") -> 10
    func map(parValuePerShareOfCommonStockText: String) -> Int {
        let strArray = parValuePerShareOfCommonStockText.split(separator: ".")

        for item in strArray {
            let part = item.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

            if let intValue = Int(part) {
                return intValue
            }
        }
        return 0
    }
    
    /// convert date string yyyyMMdd to yyyy/MM/dd
    /// e.g. ("19571230") -> 1957/12/30
    func map(dateString: String) -> String {
        let dateformattor = DateFormatter()
        dateformattor.dateFormat = "yyyyMMdd"
        let date = dateformattor.date(from: dateString)
        dateformattor.dateFormat = "yyyy-MM-dd"
        if let date = date {
            return dateformattor.string(from: date)
        }
        return ""
    }
}
