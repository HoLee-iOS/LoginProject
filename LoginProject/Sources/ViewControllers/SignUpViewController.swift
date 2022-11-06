//
//  SignUpViewController.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/02.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class SignUpViewController: BaseViewController {
    
    var userNameTextField = UITextField()
    var emailTextField = UITextField()
    var passwordTextField = UITextField()
    var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        return button
    }()
    
    let disposeBag = DisposeBag()
    
    let viewModel = SignUpViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configure() {
        view.backgroundColor = .white
        [userNameTextField, emailTextField, passwordTextField, signUpButton].forEach { view.addSubview($0) }
    }
    
    override func setConstraints() {
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(60)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(userNameTextField.snp.bottom).offset(30)
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
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.leading.equalTo(20)
            make.trailing.equalTo(-20)
            make.height.equalTo(44)
        }
    }
    
    override func bindData() {
        
        let input = SignUpViewModel.Input(passwordText: passwordTextField.rx.text, signUpTap: signUpButton.rx.tap, usernameText: viewModel.username.asDriver(), emailText: viewModel.email.asDriver(), password: viewModel.password.asDriver(), success: viewModel.success)
        let output = viewModel.transform(input: input)
        
        output.usernameText
            .drive(userNameTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        output.emailText
            .drive(emailTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        output.password
            .drive(passwordTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        output.passwordText
            .withUnretained(self)
            .bind { (vc, value) in
                vc.signUpButton.isEnabled = value
                value ? (vc.signUpButton.backgroundColor = .systemGreen) : (vc.signUpButton.backgroundColor = .systemGray)
            }
            .disposed(by: disposeBag)
        
        output.signUpTap
            .withUnretained(self)
            .bind { (vc, _) in
                guard let name = vc.userNameTextField.text else { return }
                guard let email = vc.emailTextField.text else { return }
                guard let password = vc.passwordTextField.text else { return }
                vc.viewModel.requestSignUp(userName: name, email: email, password: password)
            }
            .disposed(by: disposeBag)
        
       
        
        output.success
            .withUnretained(self)
            .subscribe { (vc, value) in
                if value {
                    vc.transitionVC(vc: LoginViewController.self)
                }
            } onError: { error in
                self.showToastMessage(error.localizedDescription)
            } onCompleted: {
                print("Completed")
            } onDisposed: {
                print("Disposed")
            }
            .disposed(by: disposeBag)
    }
}
