//
//  StockEntity.swift
//  StockView
//
//  Created by Ciao on 2023/4/16.
//

import Foundation

struct StockEntity: Decodable {
    
    /// 產業別
    let industryID: String
    
    /// 公司代號
    let symbol: String
    
    /// 公司簡稱
    let nickname: String
    
    /// 公司名稱
    let name: String
    
    /// 公司網址
    let urlString: String
    
    /// 董事長
    let chairman: String
    
    /// 總經理
    let generalManager: String
    
    /// 公司成立日期 yyyyMMdd
    let started: String
    
    /// 上市日期 yyyyMMdd
    let listed: String
    
    /// 總機
    let telephoneNumber: String
    
    /// 統一編號
    let taxIDNumber: String
    
    /// 地址
    let address: String
    
    /// 實收資本額 (元)
    let contributedCapital: String
    
    /// 普通股每股面額 (新台幣 XX.0000 元)
    let parValuePerShareOfCommonStock: String
    
    /// 特別股 (n)
    let preferredStock: String
    
    /// 私募股數 (n)
    let privatePlacement: String
    
    private enum CodingKeys: String, CodingKey {
        case industryID = "產業別"
        case symbol = "公司代號"
        case nickname = "公司簡稱"
        case name = "公司名稱"
        case urlString = "網址"
        case chairman = "董事長"
        case generalManager = "總經理"
        case started = "成立日期"
        case listed = "上市日期"
        case telephoneNumber = "總機電話"
        case taxIDNumber = "營利事業統一編號"
        case address = "過戶地址"
        case contributedCapital = "實收資本額"
        case parValuePerShareOfCommonStock = "普通股每股面額"
        case preferredStock = "特別股"
        case privatePlacement = "私募股數"
    }
}
