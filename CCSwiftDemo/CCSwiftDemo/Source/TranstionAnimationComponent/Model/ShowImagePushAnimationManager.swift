//
//  ShowImagePushAnimationManager.swift
//  CCSwiftDemo
//
//  Created by DoanDat on 1/19/17.
//  Copyright © 2017 com. All rights reserved.
//

import UIKit

class ShowImagePushAnimationManager: NSObject, UINavigationControllerDelegate
{
    var indexPathInit: IndexPath?
    
    var pushAnimation: AnimationController?
    var dismissAnimation: AnimationController?
    
    var interactiveAnimator: InteractiveAnimator?
    
    //MARK: Navigation delegate
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?
    {
        
//        toVC.respondsToSelector(Selector("work"))
        
        
        interactiveAnimator?.connectGestureRecognizer(to: toVC)

        if operation == .pop
        {
            if fromVC.responds(to: Selector(("setupBeforeDismiss")))
            {
                fromVC.perform(Selector(("setupBeforeDismiss")))
            }

            return self.dismissAnimation
        }
        
        return self.pushAnimation
    }
    
    public func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        if let interactiveAnimator = interactiveAnimator, interactiveAnimator.interacting {
            return interactiveAnimator
        } else {
            return nil
        }
    }
    
    deinit {
        print("deinit ShowImagePushAnimationManager")
    }

    
}
