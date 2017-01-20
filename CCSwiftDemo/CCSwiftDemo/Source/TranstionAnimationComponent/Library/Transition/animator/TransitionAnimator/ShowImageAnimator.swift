//
//  ShowImageAnimator.swift
//  CCSwiftDemo
//
//  Created by DatDV on 1/17/17.
//  Copyright © 2017 com. All rights reserved.
//

import Foundation

public class ShowImageAnimator: NSObject , AnimatedTransitioning{
    // MARK: - AnimatorProtocol
    public var transitionAnimationType: TransitionAnimationType
    public var transitionDuration: Duration = defaultTransitionDuration
    public var reverseAnimationType: TransitionAnimationType?
    public var interactiveGestureType: InteractiveGestureType?
    
    //MARK: delegate AnimatorProtocol
    public var image: UIImage?
    public var fromDelegate: ImageTransitionProtocol?
    public var toDelegate: ImageTransitionProtocol?
    
    // MARK: - private
    fileprivate var fromDirection: TransitionAnimationType.Direction
    fileprivate var isHorizontal = false
    fileprivate var isReverse = false
    fileprivate var isFade = false
    
    
    public init(from direction: TransitionAnimationType.Direction, isFade: Bool, transitionDuration: Duration) {
        fromDirection = direction
        self.transitionDuration = transitionDuration
        self.isFade = isFade
        isHorizontal = fromDirection.isHorizontal
        
        switch fromDirection {
        case .right:
            self.transitionAnimationType = .showImage(to: .right, isFade: isFade)
            self.reverseAnimationType = .showImage(to: .left, isFade: isFade)
            self.interactiveGestureType = .pan(from: .right)
            isReverse = true
        case .top:
            self.transitionAnimationType = .showImage(to: .top, isFade: isFade)
            self.reverseAnimationType = .showImage(to: .bottom, isFade: isFade)
            self.interactiveGestureType = .pan(from: .top)
            isReverse = false
        case .bottom:
            self.transitionAnimationType = .showImage(to: .bottom, isFade: isFade)
            self.reverseAnimationType = .showImage(to: .top, isFade: isFade)
            self.interactiveGestureType = .pan(from: .bottom)
            isReverse = true
        default:
            self.transitionAnimationType = .showImage(to: .left, isFade: isFade)
            self.reverseAnimationType = .showImage(to: .right, isFade: isFade)
            self.interactiveGestureType = .pan(from: .left)
            isReverse = false
        }
        super.init()
    }
}

extension ShowImageAnimator: UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return retrieveTransitionDuration(transitionContext: transitionContext)
    }
    
//    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
//        let (tempfromView, tempToView, tempContainerView) = retrieveViews(transitionContext: transitionContext)
//        guard let fromView = tempfromView, let toView = tempToView, let containerView = tempContainerView else {
//            transitionContext.completeTransition(true)
//            return
//        }
//        
//        let travelDistance = isHorizontal ? containerView.bounds.width : containerView.bounds.height
//        let travel = CGAffineTransform(translationX: isHorizontal ? (isReverse ? travelDistance : -travelDistance) : 0, y: isHorizontal ? 0 : (isReverse ? travelDistance : -travelDistance))
//        containerView.addSubview(toView)
//        if isFade {
//            toView.alpha = 0
//        }
//        toView.transform = travel.inverted()
//        animateSlideTransition(toView: toView, fromView: fromView, travel: travel) {
//            fromView.transform = CGAffineTransform.identity
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }
//    }
   
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let (tempfromVC, temptoVC, tempcontainerView) = retrieveViewControllers(transitionContext: transitionContext)
        
        guard let fromVC = tempfromVC, let toVC = temptoVC, let containerView = tempcontainerView else {
            transitionContext.completeTransition(true)
            return
        }
        
        // 3: Set the destination view controllers frame
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = (fromDelegate == nil) ? CGRect(x: 0, y: 0, width: 0, height: 0) : fromDelegate!.imageWindowFrame()
        imageView.clipsToBounds = true
        
        fromDelegate?.tranisitionSetup()
        toDelegate?.tranisitionSetup()
        
        // 5: Create from screen snapshot
        let fromSnapshot = fromVC.view.snapshotView(afterScreenUpdates: true)
        fromSnapshot?.frame = fromVC.view.frame
        containerView.addSubview(fromSnapshot!)

        // 6: Create to screen snapshot
        let toSnapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        toSnapshot?.frame = fromVC.view.frame
        containerView.addSubview(toSnapshot!)
        toSnapshot?.alpha = 0

        // 7: Bring the image view to the front and get the final frame
        containerView.bringSubview(toFront: imageView)
        let toFrame = (self.toDelegate == nil) ? CGRect(x: 0, y: 0, width: 0, height: 0) : self.toDelegate!.imageWindowFrame()

        // 8: Animate change
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.85, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            toSnapshot?.alpha = 1
            imageView.frame = toFrame
            
        }, completion:{ [weak self] (finished) in
            
            self?.toDelegate?.tranisitionCleanup()
            self?.fromDelegate?.tranisitionCleanup()
            
            // 9: Remove transition views
            imageView.removeFromSuperview()
            fromSnapshot?.removeFromSuperview()
            toSnapshot?.removeFromSuperview()
            
            // 10: Complete transition
            if !transitionContext.transitionWasCancelled {
                containerView.addSubview(toVC.view)
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })

        
//        let travelDistance = isHorizontal ? containerView.bounds.width : containerView.bounds.height
//        let travel = CGAffineTransform(translationX: isHorizontal ? (isReverse ? travelDistance : -travelDistance) : 0, y: isHorizontal ? 0 : (isReverse ? travelDistance : -travelDistance))
//        containerView.addSubview(toView)
//        if isFade {
//            toView.alpha = 0
//        }
//        toView.transform = travel.inverted()
//        animateSlideTransition(toView: toView, fromView: fromView, travel: travel) {
//            fromView.transform = CGAffineTransform.identity
//            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
//        }
    }

/*
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // 2: Get view controllers involved
        
        
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let containerView = transitionContext.containerView
        
        // 3: Set the destination view controllers frame
        toVC?.view.frame = (fromVC?.view.frame)!
        
        // 4: Create transition image view
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
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
            
            // 10: Complete transition
            if !transitionContext.transitionWasCancelled {
                containerView.addSubview((toVC?.view)!)
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    */
}

// MARK: - Animation

private extension ShowImageAnimator {
    func animateSlideTransition(toView: UIView, fromView: UIView, travel: CGAffineTransform, completion: @escaping AnimatableCompletion) {
        UIView.animate(withDuration: transitionDuration, animations: {
            fromView.transform = travel
            toView.transform = CGAffineTransform.identity
            if self.isFade {
                fromView.alpha = 0
                toView.alpha = 1
            }
        },
                       completion: { _ in
                        completion()
        })
    }
}


extension ShowImageAnimator
{
    // MARK: Setup Methods
    
    func setupImageTransition(image: UIImage, fromDelegate: ImageTransitionProtocol, toDelegate: ImageTransitionProtocol){
        self.image = image
        self.fromDelegate = fromDelegate
        self.toDelegate = toDelegate
    }

    
    

}




