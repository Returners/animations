//
//  ExpandImageAnimationController.swift
//  animations
//
//  Created by Andy Shen on 2017-08-30.
//  Copyright © 2017 Andy Shen. All rights reserved.
//

import UIKit

class ExpandImageAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 1.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let tabVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? UITabBarController,
        let fromVC = tabVC.viewControllers!.first as? HomeViewController,
            let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? BigImageViewController else {
                return
        }
        
        let initialFrame = fromVC.imageView.bounds
        let finalFrame = toVC.imageView.bounds
        
        let scaleX = finalFrame.width / initialFrame.width
        let scaleY = finalFrame.height / initialFrame.height
        let scaleTransform = CATransform3DMakeScale(scaleX, scaleY, 1)
        
        let translateY = toVC.imageView.layer.position.y - fromVC.imageView.layer.position.y
        let translateTransform = CATransform3DMakeTranslation(0, translateY, 0)
        
        let finalTransform = CATransform3DConcat(scaleTransform, translateTransform)
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toVC.view)
        toVC.view.isHidden = true
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animateKeyframes(
            withDuration: duration,
            delay: 0,
            options: .calculationModeCubic, animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 1/2, animations: {
                    fromVC.imageView.layer.transform = finalTransform
                })
        }) { (finished) in
            toVC.view.isHidden = false
            fromVC.imageView.layer.transform = CATransform3DIdentity
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    
}
