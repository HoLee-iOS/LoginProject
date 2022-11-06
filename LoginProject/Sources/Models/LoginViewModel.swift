//
//  LoginViewModel.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/03.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class LoginViewModel {
    
    var email = BehaviorRelay(value: "이메일을 입력해주세요")
    var password = BehaviorRelay(value: "비밀번호를 입력해주세요")
    
    func requestLogin(email: String, password: String) {
        APIService.login(email: email, password: password) { value, statusCode, error in
            
        }
    }    
}
