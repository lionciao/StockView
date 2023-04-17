//
//  FavoritesListViewModel.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

protocol FavoritesListViewModelDelegate: AnyObject {
    
    func didFetchCompanyList()
}

final class FavoritesListViewModel {
    
    weak var delegate: FavoritesListViewModelDelegate?
    
    private(set) var companyList: [CompanyModel] = []
    var shouldShowEmptyView: Bool { return companyList.isEmpty }
    let title: String = "追蹤"
    
    private let favoritesRepository: FavoritesRepository
    private let listRepository: StockListRepository
    
    init(
        favoritesRepository: FavoritesRepository,
        listRepository: StockListRepository
    ) {
        self.favoritesRepository = favoritesRepository
        self.listRepository = listRepository
    }
    
    func stock(at index: Int) -> StockModel? {
        let symbol = companyList[index].symbol
        return listRepository.symbolToStockMap[symbol]
    }
}

// MARK: - Fetch

extension FavoritesListViewModel: TabBarViewModelFavoritesDelegate {
    
    func tabBarViewModel(
        _ viewModel: TabBarViewModel,
        didFetchFavoritesList stocks: [CompanyModel]
    ) {
        companyList = stocks
        delegate?.didFetchCompanyList()
    }
}
