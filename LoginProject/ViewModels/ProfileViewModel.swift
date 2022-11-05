//
//  ProfileViewModel.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/04.
//

import Foundation
import RxSwift
import RxCocoa

class ProfileViewModel {
    
    let photo = PublishRelay<Data>()
    let email = PublishRelay<String>()
    let username = PublishRelay<String>()

    
    func requestProfile() {
        APIService.profile { [weak self] value, statusCode, error in
            guard let value = value else { return }
            guard let url = URL(string: value.user.photo) else { return }
            DispatchQueue.global().async {
                guard let data = try? Data(contentsOf: url) else { return }
                DispatchQueue.main.async {
                    self?.photo.accept(data)
                    self?.email.accept(value.user.email)
                    self?.username.accept(value.user.username)
                }
            }            
        }
    }    
}
