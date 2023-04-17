//
//  IndustryListViewModel.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import Foundation

protocol IndustryListViewModelDelegate: AnyObject {
    
    func didFetchIndustryList()
}

final class IndustryListViewModel {
    
    weak var delegate: IndustryListViewModelDelegate?
    
    private(set) var industyList: [IndustryModel] = []
    var shouldShowEmptyView: Bool { return industyList.isEmpty }
    
    private let listRepository: StockListRepository
    
    init(
        listRepository: StockListRepository
    ) {
        self.listRepository = listRepository
    }
}

extension IndustryListViewModel: TabBarViewModelDelegate {
    
    func tabBarViewModel(
        _ viewModel: TabBarViewModel,
        didFetchStockList stocks: [StockModel]
    ) {
        self.industyList = listRepository.industryIDToStocksMap.map {
            IndustryModel(
                name: $0.name,
                numberOfCompanies: $1.count
            )
        }
        self.delegate?.didFetchIndustryList()
    }
}

struct IndustryModel {
    
    let name: String
    let numberOfCompanies: Int
}
