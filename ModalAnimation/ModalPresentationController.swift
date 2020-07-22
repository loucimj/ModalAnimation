//
//  ModalPresentationController.swift
//  ModalAnimation
//
//  Created by Javier Loucim on 22/07/2020.
//

import Foundation
import UIKit

class ModalPresentationController: UIPresentationController {
    private lazy var dimmingView: UIView? = {
        guard let container = containerView else { return nil }
        
        let view = UIView(frame: container.bounds)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        return view
    }()
    override func presentationTransitionWillBegin() {
        guard let container = containerView,
            let coordinator = presentingViewController.transitionCoordinator, let dimmingView = self.dimmingView else { return }
        
        dimmingView.alpha = 0
        container.addSubview(dimmingView)
        dimmingView.addSubview(presentedViewController.view)
        
        coordinator.animate(alongsideTransition: { [weak self] context in
            guard let `self` = self, let dimmingView = self.dimmingView else { return }
            
            dimmingView.alpha = 1
            }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        guard let coordinator = presentingViewController.transitionCoordinator else { return }
        
        coordinator.animate(alongsideTransition: { [weak self] (context) -> Void in
            guard let `self` = self, let dimmingView = self.dimmingView else { return }
            
            dimmingView.alpha = 0
            }, completion: nil)
    }
    
    override func dismissalTransitionDidEnd(_ completed: Bool) {
        guard let dimmingView = self.dimmingView else { return }
        if completed {
            dimmingView.removeFromSuperview()
        }
    }
    
}
final class ModalPresentationTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - UIViewControllerTransitioningDelegate
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}
