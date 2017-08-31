//
//  ExpandCardAnimationController.swift
//  animations
//
//  Created by Andy Shen on 2017-08-30.
//  Copyright © 2017 Andy Shen. All rights reserved.
//

import UIKit

class ExpandCardAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var originFrame = CGRect.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? CardViewController else {
            return
        }
        
        let initialFrame = originFrame
        let finalFrame = toVC.view.bounds
        
        let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
        snapshot?.frame = initialFrame
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        containerView.addSubview(snapshot!)
        toVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1, animations: {
                    snapshot?.frame = finalFrame
                })
        }) { _ in
            toVC.view.isHidden = false
            snapshot?.removeFromSuperview()
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
    }
    
}
