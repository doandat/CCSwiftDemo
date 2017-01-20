//
//  AnimatedPresenting.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/16/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation

public protocol AnimatedPresenting: ViewControllerAnimatedTransitioning {
    
}

public extension AnimatedPresenting {
    public func isPresenting(transitionContext: UIViewControllerContextTransitioning) -> Bool {
        let (fromViewController, toViewController, _) = retrieveViewControllers(transitionContext: transitionContext)
        return toViewController?.presentingViewController == fromViewController
    }
}
