//
//  NetworkRequest+Moya.swift
//  StockView
//
//  Created by Ciao on 2023/4/16.
//

import Foundation
import Moya

public protocol NetworkRequest: TargetType {
    
    associatedtype Entity: Decodable
}

public typealias Method = Moya.Method
public typealias Task = Moya.Task
public typealias ValidationType = Moya.ValidationType
