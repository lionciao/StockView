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
    
    let listRepository: StockListRepository
    
    init(
        listRepository: StockListRepository
    ) {
        self.listRepository = listRepository
    }
    
    func industryID(at index: Int) -> IndustryID {
        return industyList[index].id
    }
}

extension IndustryListViewModel: TabBarViewModelDelegate {
    
    func tabBarViewModel(
        _ viewModel: TabBarViewModel,
        didFetchStockList stocks: [StockModel]
    ) {
        self.industyList = listRepository.industryIDToStocksMap.map {
            IndustryModel(
                id: $0,
                numberOfCompanies: $1.count
            )
        }
        self.delegate?.didFetchIndustryList()
    }
}

struct IndustryModel {
    
    let id: IndustryID
    let numberOfCompanies: Int
}
