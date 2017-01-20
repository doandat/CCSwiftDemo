//
//  ShowImageAnimationController.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/18/17.
//  Copyright © 2017 com. All rights reserved.
//


import UIKit

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    fileprivate var image: UIImage?
    fileprivate var fromDelegate: ImageTransitionProtocol?
    fileprivate var toDelegate: ImageTransitionProtocol?
    fileprivate var isDismiss: Bool?
    
    // MARK: Setup Methods
    
    func setupImage(image: UIImage)
    {
        self.image = image
    }
        
    func setupImageTransition(image: UIImage, fromDelegate: ImageTransitionProtocol, toDelegate: ImageTransitionProtocol, isDismiss: Bool){
        self.image = image
        self.fromDelegate = fromDelegate
        self.toDelegate = toDelegate
        self.isDismiss = isDismiss
    }
    
    // MARK: UIViewControllerAnimatedTransitioning
    
    // 1: Set animation speed
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 2: Get view controllers involved
        
        
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containerView = transitionContext.containerView
        
        // 3: Set the destination view controllers frame
        toVC?.view.frame = (fromVC?.view.frame)!
        
        // 4: Create transition image view
        let imageView = UIImageView(image: image)
        
        if let pIsDismiss = isDismiss
        {
            imageView.contentMode = pIsDismiss ? UIViewContentMode.scaleAspectFill : UIViewContentMode.scaleAspectFit
        }
        else
        {
            imageView.contentMode = .scaleAspectFit
        }
        
        imageView.frame = (fromDelegate == nil) ? CGRect(x: 0, y: 0, width: 0, height: 0) : fromDelegate!.imageWindowFrame()
        imageView.clipsToBounds = true
        containerView.addSubview(imageView)
        
        fromDelegate!.tranisitionSetup()
        toDelegate!.tranisitionSetup()
        
        // 5: Create from screen snapshot
        let fromSnapshot = fromVC?.view.snapshotView(afterScreenUpdates: true)
        fromSnapshot?.frame = (fromVC?.view.frame)!
        containerView.addSubview(fromSnapshot!)
        
        // 6: Create to screen snapshot
        let toSnapshot = toVC?.view.snapshotView(afterScreenUpdates: true)
        toSnapshot?.frame = (fromVC?.view.frame)!
//        toSnapshot?.frame.origin.y -= 64.0;

        containerView.addSubview(toSnapshot!)
        toSnapshot?.alpha = 0
        
        // 7: Bring the image view to the front and get the final frame
        containerView.bringSubview(toFront: imageView)
        let toFrame = (self.toDelegate == nil) ? CGRect(x: 0, y: 0, width: 0, height: 0) : self.toDelegate!.imageWindowFrame()
        
        // 8: Animate change
        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            toSnapshot?.alpha = 1
            imageView.frame = toFrame
            
        }, completion:{ [weak self] (finished) in
            
            self?.toDelegate!.tranisitionCleanup()
            self?.fromDelegate!.tranisitionCleanup()
            
            // 9: Remove transition views
            imageView.removeFromSuperview()
            fromSnapshot?.removeFromSuperview()
            toSnapshot?.removeFromSuperview()
            
            if toVC!.responds(to: Selector(("removeProperty")))
            {
                toVC!.perform(Selector(("removeProperty")))
            }

            
            // 10: Complete transition
            if !transitionContext.transitionWasCancelled {
                containerView.addSubview((toVC?.view)!)
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    deinit {
        print("deinit AnimationController")
    }
}

