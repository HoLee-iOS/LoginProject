//
//  SignUpViewController.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/02.
//

import UIKit

import RxSwift
import RxCocoa

class SignUpViewController: BaseViewController {

    let customView = SignUpView()
    
    let disposeBag = DisposeBag()
    
    override func loadView() {
        self.view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        customView.passwordTextField.rx.text
            .orEmpty
            .map{ $0.count >= 8 }
            .bind(onNext: { value in
                self.customView.signUpButton.isEnabled = value
            })
            .disposed(by: disposeBag)
        
        
    }
}
