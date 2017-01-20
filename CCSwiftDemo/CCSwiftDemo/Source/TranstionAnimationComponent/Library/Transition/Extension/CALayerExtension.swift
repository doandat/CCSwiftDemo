//
//  CALayerExtension.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/16/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation

public extension CALayer {
    class func animate(_ animation: AnimatableExecution, completion: AnimatableCompletion? = nil) {
        CATransaction.begin()
        if let completion = completion {
            CATransaction.setCompletionBlock { completion() }
        }
        animation()
        CATransaction.commit()
    }
}
