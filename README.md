# ModalAnimation

An example using a custom transition delegate

<img src="video/video.gif" width="375" />

## Code

```swift
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
        guard let dimmingView = self.dimmingView, completed else { return }
        
        dimmingView.removeFromSuperview()
    }
    
}
final class ModalPresentationTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    // MARK: - UIViewControllerTransitioningDelegate
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return ModalPresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}
```

and in the presenting view controller: 

```swift

    @objc func open() {
        let viewController = ModalViewController()
        if #available(iOS 13.0, *) {
            viewController.isModalInPresentation = true
        }
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = customTransitioningDelegate
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }

```
