//
//  NetworkRequest+DefaultImplement.swift
//  StockView
//
//  Created by Ciao on 2023/4/16.
//

import Foundation

extension NetworkRequest {
    
    var baseURL: URL { return URL(string: "https://openapi.twse.com.tw/v1")!  }
    var sampleData: Data { Data() }
    var headers: [String : String]? { return nil }
}
