//
//  SignUpViewModel.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/02.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class SignUpViewModel: CommonViewModel {
    
    let disposeBag = DisposeBag()
    
    var username = BehaviorRelay(value: "닉네임을 입력해주세요")
    var email = BehaviorRelay(value: "이메일을 입력해주세요")
    var password = BehaviorRelay(value: "비밀번호를 입력해주세요")
    var success = BehaviorSubject(value: false)
    
    func requestSignUp(userName: String, email: String, password: String) {
        APIService.signup(userName: userName, email: email, password: password) { [weak self] value, statusCode, error in
            guard let statusCode = statusCode else { return }
            switch statusCode {
            case 200..<300:
                self?.success.onNext(true)
            case 300..<400:
                self?.success.onError(NetworkError.badRequest)
            case 400..<500:
                self?.success.onError(NetworkError.badRequest)
            default:
                self?.success.onError(NetworkError.badRequest)
            }
        }
    }
    
    struct Input {
        let passwordText: ControlProperty<String?>
        let signUpTap: ControlEvent<Void>
        let usernameText: Driver<String>
        let emailText: Driver<String>
        let password: Driver<String>
        let success: BehaviorSubject<Bool>
    }
    
    struct Output {
        let passwordText: Observable<Bool>
        let signUpTap: ControlEvent<Void>
        let usernameText: Driver<String>
        let emailText: Driver<String>
        let password: Driver<String>
        let success: BehaviorSubject<Bool>
    }
    
    func transform(input: Input) -> Output {
        let text = input.passwordText
            .orEmpty
            .map { $0.count >= 8 }
        
        return Output(passwordText: text, signUpTap: input.signUpTap, usernameText: input.usernameText, emailText: input.emailText, password: input.password, success: input.success)
    }
    
}
