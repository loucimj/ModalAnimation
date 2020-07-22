//
//  ViewController.swift
//  ModalAnimation
//
//  Created by Javier Loucim on 21/07/2020.
//

import UIKit

class ViewController: UIViewController {

    let customTransitioningDelegate = ModalPresentationTransitioningDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(open)))
    }
    
    @objc func open() {
        let viewController = ModalViewController()
        if #available(iOS 13.0, *) {
            viewController.isModalInPresentation = true
        }
        viewController.modalPresentationStyle = .custom
        viewController.transitioningDelegate = customTransitioningDelegate
        self.navigationController?.present(viewController, animated: true, completion: nil)
    }

}

