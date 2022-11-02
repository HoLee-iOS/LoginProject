//
//  SignUpView.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/02.
//

import Foundation
import UIKit
import SnapKit

class SignUpView: BaseView {
    
    let userNameTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        return text
    }()
    
    let emailTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        return text
    }()
    
    let passwordTextField: UITextField = {
        let text = UITextField()
        text.backgroundColor = .white
        return text
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("가입하기", for: .normal)
        return button
    }()
    
    override func configureUI() {
        [userNameTextField, emailTextField, passwordTextField, signUpButton].forEach { self.addSubview($0) }
    }
    
    override func setConstraints() {
        userNameTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide).offset(30)
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
}
