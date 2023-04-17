//
//  CompanyListViewModel.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import Foundation

final class CompanyListViewModel {
    
    private(set) var companyList: [CompanyModel] = []
    var shouldShowEmptyView: Bool { return companyList.isEmpty }
    var title: String { industryID.name }
    
    private let listRepository: StockListRepository
    private let industryID: IndustryID
    
    init(
        listRepository: StockListRepository,
        industryID: IndustryID
    ) {
        self.listRepository = listRepository
        self.industryID = industryID
        self.companyList = listRepository.industryIDToStocksMap[industryID]?.compactMap {
            CompanyModel(
                symbol: $0.symbol,
                nickname: $0.nickname
            )
        } ?? []
    }
    
    func stock(at index: Int) -> StockModel? {
        let symbol = companyList[index].symbol
        return listRepository.symbolToStockMap[symbol]
    }
}

struct CompanyModel {
    
    let symbol: String
    let nickname: String
}
