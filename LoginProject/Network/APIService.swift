//
//  APIService.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/02.
//

import Foundation
import Alamofire

struct Login: Codable {
    let token: String
}

struct Profile: Codable {
    let user: Inform
}

struct Inform: Codable {
    let photo: String
    let email: String
    let username: String
}


class APIService {
    
    func signup(userName: String, email: String, password: String) {
        
        AF.request(Router.signup(userName: userName, email: email, password: password)).validate(statusCode: 200..<299).responseString { response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func login(email: String, password: String) {
        
        AF.request(Router.login(email: email, password: password)).validate(statusCode: 200..<299).responseDecodable(of: Login.self) { response in
            switch response.result {
            case .success(let data):
                UserDefaults.standard.set(data.token, forKey: "token")
                print(UserDefaults.standard.string(forKey: "token")!)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func profile() {
        
        AF.request(Router.me).validate(statusCode: 200..<299).responseDecodable(of: Profile.self) { response in
            switch response.result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
        }
        
    }
}
