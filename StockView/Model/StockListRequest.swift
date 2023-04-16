//
//  StockListRequest.swift
//  StockView
//
//  Created by Ciao on 2023/4/16.
//


import Foundation

struct StockListRequest: NetworkRequest {
    
    typealias Entity = [StockEntity]

    let path: String = "/opendata​/t187ap03_P"
    let method: Method = .get
    let task: Task = .requestPlain
}
