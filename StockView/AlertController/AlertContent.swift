//
//  AlertContent.swift
//  StockView
//
//  Created by Ciao on 2023/4/20.
//

struct AlertContent {
    
    let title: String
    let content: String
    let doButtonText: String
    let cancelButtonText: String = "取消"
    
    init(isFavorites: Bool, companyText: String) {
        self.title = isFavorites ? "從追蹤列表移除" : "加入追蹤列表"
        self.content = isFavorites ? "是否將 \(companyText)從追蹤列表移除？" : "是否將 \(companyText)加入追蹤列表內？"
        self.doButtonText = isFavorites ? "移除" : "加入"
    }
}
