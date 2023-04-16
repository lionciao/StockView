//
//  ServiceError.swift
//  StockView
//
//  Created by Ciao on 2023/4/16.
//

import Foundation

/// Errors occured in `NetworkService`.
public enum ServiceError: LocalizedError {

    /// The receive data cannot decode to an instance of the target type.
    case decodeFailed(reason: Error)
}
