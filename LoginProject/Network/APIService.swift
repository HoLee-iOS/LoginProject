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
    
    static func signup(userName: String, email: String, password: String, completion: @escaping (String?, Int?, Error?) -> Void) {
        AF.request(Router.signup(userName: userName, email: email, password: password)).responseString { response in
            guard let status = response.response?.statusCode else { return }
            switch response.result {
            case .success(let data):
                completion(data, status, nil)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func login(email: String, password: String, completion: @escaping (String?, Int?, Error?) -> Void) {
        AF.request(Router.login(email: email, password: password)).responseDecodable(of: Login.self) { response in
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success(let data):
                UserDefaults.standard.set(data.token, forKey: "token")
                completion(data.token, statusCode, nil)
            case .failure(let error):
                completion(nil, statusCode, error)
            }
        }
    }
    
    static func profile(completion: @escaping (Profile?, Int?, Error?) -> Void) {
        AF.request(Router.me).validate(statusCode: 200..<299).responseDecodable(of: Profile.self) { response in
            guard let statusCode = response.response?.statusCode else { return }
            switch response.result {
            case .success(let data):
                completion(data, statusCode, nil)
            case .failure(let error):
                completion(nil, statusCode, error)
            }
        }
        
    }
}
