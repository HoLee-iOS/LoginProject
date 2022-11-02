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
    var success = BehaviorSubject<Bool>(value: false)
    
    func requestLogin(email: String, password: String) {
        APIService.login(email: email, password: password) { [weak self] value, statusCode, error in
            guard let statusCode = statusCode else { return }
            switch statusCode {
            case 200..<300:
                self?.success.onNext(true)
            case 300..<400:
                self?.success.onError(NetworkError.networkFail)
            case 400..<500:
                self?.success.onError(NetworkError.badRequest)
            default:
                self?.success.onError(NetworkError.networkFail)
            }
        }
        
    }
    
}
