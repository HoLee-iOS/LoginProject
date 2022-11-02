//
//  LoginViewController.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/03.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import SnapKit

class LoginViewController: BaseViewController {
    
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    
    var loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인하기", for: .normal)
        button.backgroundColor = .systemGreen
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        view.backgroundColor = .white
        [emailTextField, passwordTextField, loginButton].forEach {
            view.addSubview($0)
        }
    }
    
    override func setConstraints() {
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(60)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(60)
        }
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(60)
        }
    }
    
    override func bindData() {
        
        viewModel.email
            .asDriver()
            .drive(emailTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        viewModel.password
            .asDriver()
            .drive(passwordTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        passwordTextField.rx.text
            .orEmpty
            .map { $0.count >= 8 }
            .withUnretained(self)
            .bind { (vc, value) in
                vc.loginButton.isEnabled = value
                value ? (vc.loginButton.backgroundColor = .systemGreen) : (vc.loginButton.backgroundColor = .systemGray)
            }
            .disposed(by: disposeBag)
        
        loginButton.rx.tap
            .withUnretained(self)
            .subscribe { (vc, _) in
                guard let email = vc.emailTextField.text else { return }
                guard let password = vc.passwordTextField.text else { return }
                vc.viewModel.requestLogin(email: email, password: password)
            }
            .disposed(by: disposeBag)
        
        viewModel.success
            .withUnretained(self)
            .bind { (vc, value) in
                print(value)
//                vc.modalPresentationStyle = .overFullScreen
//                vc.present(SignUpViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    
    
}
