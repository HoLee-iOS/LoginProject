//
//  BaseViewController.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/02.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        configure()
        setConstraints()
    }
    
    func configure() { }
    
    func setConstraints() { }
    
//    func showToastMessage(_ message: String) {
//        self.view.makeToast(message, position: .bottom)
//    }
}
