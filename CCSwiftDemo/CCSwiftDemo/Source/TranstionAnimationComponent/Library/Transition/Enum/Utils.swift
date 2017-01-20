//
//  Utils.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/16/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation

extension Array {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript(safe index: Int ) -> Element? {
        return indices.contains(index) ? self[index] : nil  /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    }
}

extension String {
    func toDouble() -> Double? {
        return Double(self)
    }
    func toFloat() -> Float? {
        return Float(self)
    }
    func toInt() -> Int? {
        return Int(self)
    }
}

extension RawRepresentable {
    
    init?(raw: RawValue?) {
        guard let raw = raw else {
            return nil
        }
        self.init(rawValue: raw)
    }
    
    init(raw: RawValue?, defaultValue: Self) {
        guard let value = raw  else {
            self = defaultValue
            return
        }
        self = Self(rawValue: value) ?? defaultValue
    }
}

func iterateEnum<T: Hashable>(from: T.Type) -> AnyIterator<T> {
    var x = 0
    return AnyIterator {
        let next = withUnsafePointer(to: &x) {
            $0.withMemoryRebound(to: T.self, capacity: 1) { $0.pointee }
        }
        defer {
            x += 1
        }
        return next.hashValue == x ? next : nil
    }
}
