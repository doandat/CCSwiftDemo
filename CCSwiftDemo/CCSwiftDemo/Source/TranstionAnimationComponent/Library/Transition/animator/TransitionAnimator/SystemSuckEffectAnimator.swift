//
//  Created by Tom Baranes on 30/03/16.
//  Copyright © 2016 IBAnimatable. All rights reserved.
//

import UIKit

public class SystemSuckEffectAnimator: NSObject, AnimatedTransitioning {
  // MARK: - AnimatorProtocol
  public var transitionAnimationType: TransitionAnimationType
  public var transitionDuration: Duration = defaultTransitionDuration
  public var reverseAnimationType: TransitionAnimationType?
  public var interactiveGestureType: InteractiveGestureType?

    //MARK: delegate AnimatorProtocol
    public var image: UIImage?
    public var fromDelegate: ImageTransitionProtocol?
    public var toDelegate: ImageTransitionProtocol?

  public init(transitionDuration: Duration) {
    self.transitionDuration = transitionDuration
    self.transitionAnimationType = .systemSuckEffect
    self.reverseAnimationType = .systemSuckEffect
    super.init()
  }
}

extension SystemSuckEffectAnimator: UIViewControllerAnimatedTransitioning {
  public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
    return retrieveTransitionDuration(transitionContext: transitionContext)
  }

  public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
    animateWithCATransition(transitionContext: transitionContext, type: TransitionAnimationType.SystemTransitionType.suckEffect, subtype: nil)
  }
}
