//
//  DefaultNetworkService.swift
//  StockView
//
//  Created by Ciao on 2023/4/16.
//

import Foundation
import Moya

/// A custom service to wrap the third-party framework Moya, decoding response data to entity.
public final class DefaultNetworkService: NetworkService {
    
    private lazy var decoder = makeDecoder()
    
    @discardableResult
    public func send<R: NetworkRequest>(
        _ request: R,
        completion: @escaping CompletionHandler<R>
    ) -> NetworkCancellable? {
        let provider = MoyaProvider<R>()
        let task = provider.request(
            request
        ) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let response):
                do {
                    let entity = try self.decoder.decode(R.Entity.self, from: response.data)
                    completion(.success(entity))
                } catch {
                    completion(.failure(ServiceError.decodeFailed(reason: error)))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return networkCancellable(from: task)
    }
}

// MARK: - CancellableWrapper

extension DefaultNetworkService {
    
    /// A custom wrapper to bridge Cancellable from Moya.
    struct CancellableWrapper: NetworkCancellable {
        
        let cancellable: Cancellable
        
        init(cancellable: Cancellable) {
            self.cancellable = cancellable
        }
        
        func cancel() {
            cancellable.cancel()
        }
    }
}

// MARK: - Helper methods

private extension DefaultNetworkService {
    
    func makeDecoder() -> JSONDecoder {
        let jsonDecoder = JSONDecoder()
        return jsonDecoder
    }
    
    func networkCancellable(from cancellable: Moya.Cancellable) -> NetworkCancellable {
        return CancellableWrapper(cancellable: cancellable)
    }
}
