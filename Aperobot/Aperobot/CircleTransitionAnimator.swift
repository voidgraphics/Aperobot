//
//  CircleTransitionAnimator.swift
//  CircleTransition
//
//  Created by Adrien Leloup on 2/04/17.
//  Copyright © 2017 Adrien Leloup. All rights reserved.
//

import UIKit

class CircleTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning, CAAnimationDelegate {
    
    weak var transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! BaseViewController
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! BaseViewController
        let button = fromViewController.cartButton
        
        containerView.addSubview(toViewController.view)

        let circleMaskPathInitial = UIBezierPath(ovalIn: (button?.frame)!)
        let extremePoint = CGPoint(x: (button?.center.x)! - 0, y: (button?.center.y)! + toViewController.view.bounds.height)
        let radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y * extremePoint.y))
        let circleMaskPathFinal = UIBezierPath(ovalIn: (button?.frame)!.insetBy(dx: -radius, dy: -radius))
        
        let maskLayer = CAShapeLayer()
        maskLayer.path = circleMaskPathFinal.cgPath
        toViewController.view.layer.mask = maskLayer
        
        let maskLayerAnimation = CABasicAnimation(keyPath: "path")
        maskLayerAnimation.fromValue = circleMaskPathInitial.cgPath
        maskLayerAnimation.toValue = circleMaskPathFinal.cgPath
        maskLayerAnimation.duration = self.transitionDuration(using: transitionContext)
        maskLayerAnimation.delegate = self
        maskLayer.add(maskLayerAnimation, forKey: "path")
        
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.transitionContext?.completeTransition(!self.transitionContext!.transitionWasCancelled)
        self.transitionContext?.viewController(forKey: UITransitionContextViewControllerKey.from)?.view.layer.mask = nil
    }
    
    func mask(viewToMask: UIView, maskRect: CGRect, invert: Bool = false) {
        let maskLayer = CAShapeLayer()
        let path = CGMutablePath()
        if (invert) {
            path.addRect(viewToMask.bounds)
        }
        path.addRect(maskRect)
        
        maskLayer.path = path
        if (invert) {
            maskLayer.fillRule = kCAFillRuleEvenOdd
        }
        
        // Set the mask of the view.
        viewToMask.layer.mask = maskLayer;
    }
    
}
