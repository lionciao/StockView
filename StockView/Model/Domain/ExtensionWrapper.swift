//
//  ExtensionWrapper.swift
//  StockView
//
//  Created by Ciao on 2023/4/17.
//

import Foundation

/// ExtensionWrapper is compatible types. This type provides an extension point for
/// convenience methods in ExtensionWrapper.
public struct ExtensionWrapper<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/// Represents a `value` type that is compatible with ExtensionCompatibleValue. You can use `ew` property to get a
/// value in the namespace of ExtensionWrapper.
///
/// example:
/// ```
/// extension String: ExtensionCompatibleValue {}
/// public extension ExtensionWrapper where Base == String { }
/// ```
public protocol ExtensionCompatibleValue {}

public extension ExtensionCompatibleValue {
    
    var ew: ExtensionWrapper<Self> {
        return ExtensionWrapper(self)
    }
}
