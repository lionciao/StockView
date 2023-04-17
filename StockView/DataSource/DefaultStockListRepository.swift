//
//  DefaultStockListRepository.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

final class DefaultStockListRepository: StockListRepository {
    
    private(set) var industryIDToStocksMap: [IndustryID : [StockModel]] = [:]
    
    private(set) var symbolToStockMap: [String : StockModel] = [:]
    
    private let service: NetworkService
    
    init(service: NetworkService = defaultService) {
        self.service = service
    }
    
    func getStockList(
        completion: @escaping (Result<[StockModel], Error>) -> Void
    ) {
        let request = StockListRequest()
        defaultService.send(request) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let entity):
                let models = entity.map { $0.ew.map() }
                self.industryIDToStocksMap = Dictionary(grouping: models, by: { $0.industryID })
                models.forEach { self.symbolToStockMap[$0.symbol] = $0 }
                completion(.success(models))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
