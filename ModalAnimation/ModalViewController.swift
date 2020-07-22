//
//  ModalViewController.swift
//  ModalAnimation
//
//  Created by Javier Loucim on 21/07/2020.
//

import Foundation
import UIKit

class ModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.blue
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(close)))
    }
    @objc func close() {
        self.dismiss(animated: true, completion: nil)
    }
}
