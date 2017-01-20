//
//  AnimatedTransitioning.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/16/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation

/**
 AnimatedTransitioning is the protocol of all Animator subclasses
 */
public protocol AnimatedTransitioning: ViewControllerAnimatedTransitioning
{
    /**
     Transition amimation type: used to specify the transition animation.
    */
    var transitionAnimationType: TransitionAnimationType {get set}
    
    /**
     Reverse animation type : used to specify the revers animation for pop or dismiss
     */
    var reverseAnimationType: TransitionAnimationType? {get set}
    
    /**
     Interactive gesture type: used to specify the gesture type to pop or dismiss.
     */
    var interactiveGestureType: InteractiveGestureType? {get set}
    
    
    //to show image
    //MARK: delegate
    
    var image: UIImage? {get set}
    var fromDelegate: ImageTransitionProtocol? {get set}
    var toDelegate: ImageTransitionProtocol? {get set}

    
}

public extension AnimatedTransitioning
{
    public func animateWithCATransition(transitionContext: UIViewControllerContextTransitioning, type: TransitionAnimationType.SystemTransitionType, subtype: String?)
    {
        let (_, tempToView, tempContainerView) = retrieveViews(transitionContext: transitionContext)
        
        guard let toView = tempToView, let containerView = tempContainerView else
        {
            transitionContext.completeTransition(true)
            return
        }
        
        let (_, tempToViewController, _) = retrieveViewControllers(transitionContext: transitionContext)
        if let toViewController = tempToViewController
        {
            toView.frame = transitionContext.finalFrame(for: toViewController)
        }
        
        containerView.addSubview(toView)
        
        CALayer.animate ({
          
            let transition = CATransition()
            transition.type = type.rawValue
            if let subtype = subtype
            {
                transition.subtype = subtype
            }
            transition.duration = self.transitionDuration(using: transitionContext)
            // Use `EaseOutQubic` for system built-in transition animations. Thanks to @lexrus
            transition.timingFunction = CAMediaTimingFunction(controlPoints: 0.215, 0.61, 0.355, 1)
            containerView.layer.add(transition, forKey: kCATransition)
            
        }, completion: {
           transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
}


//MARK: protocol

//public protocol ImageTransitionProtocol {
//    func tranisitionSetup()
//    func tranisitionCleanup()
//    func imageWindowFrame() -> CGRect
//}
//


