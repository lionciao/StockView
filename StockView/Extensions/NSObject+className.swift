//
//  NSObject+className.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import Foundation

extension NSObject {

    static var className: String {
        return String(describing: self)
    }
}
