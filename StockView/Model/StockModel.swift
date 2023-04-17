//
//  StockModel.swift
//  StockView
//
//  Created by Ciao on 2023/4/16.
//

import Foundation

struct StockModel {
    
    /// 產業別
    let industryID: IndustryID
    
    /// 公司代號
    let symbol: String
    
    /// 公司簡稱
    let nickname: String
    
    /// 公司名稱
    let name: String
    
    /// 公司網址
    let url: URL?
    
    /// 董事長
    let chairman: String
    
    /// 總經理
    let generalManager: String
    
    /// 公司成立日期 yyyy/MM/dd
    let started: String
    
    /// 上市日期 yyyy/MM/dd
    let listed: String
    
    /// 總機
    let telephoneNumber: String
    
    /// 統一編號
    let taxIDNumber: String
    
    /// 地址
    let address: String
    
    /// 實收資本額 (元)
    let contributedCapital: Int
    
    /// 普通股每股面額 (新台幣 XX.0000 元)
    let parValuePerShareOfCommonStockText: String
    
    /// 普通股每股面額 (元)
    let parValuePerShareOfCommonStock: Int
    
    /// 特別股 (n)
    let preferredStock: Int
    
    /// 私募股數 (n)
    let privatePlacement: Int
    
    /// 已發行股數 (n)
    /// 計算公式：(實收資本額 / 普通股每股面額) - 特別股股數
    var issuedShare: Int {
        if parValuePerShareOfCommonStock != 0 {
            return (contributedCapital / parValuePerShareOfCommonStock) - preferredStock
        }
        return 0
    }
}
