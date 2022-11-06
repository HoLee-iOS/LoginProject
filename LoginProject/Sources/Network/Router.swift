//
//  Router.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/02.
//

import Foundation
import Alamofire

//URL컨버터블로 API통신
enum Router: URLRequestConvertible {
    
    case signup(userName: String, email: String, password: String)
    case login(email: String, password: String)
    case me
    
    var baseURL: URL {
        return URL(string: "http://api.memolease.com/api/v1/users/")!
    }
    
    var method: HTTPMethod {
        switch self {
        case .signup: return .post
        case .login: return .post
        case .me: return .get
        }
    }
    
    var path: String {
        switch self {
        case .signup: return "signup"
        case .login: return "login"
        case .me: return "me"
        }
    }
    
    var headers: HTTPHeaders {
        switch self {
        case .signup, .login:
            return ["Content-Type" : "application/x-www-form-urlencoded"]
        case .me:
            return [
                "Authorization": "Bearer \(UserDefaults.standard.string(forKey: "token") ?? "")",
                "Content-Type" : "application/x-www-form-urlencoded"
            ]
        }
    }
    
    var parameters: [String : String] {
        switch self {
        case .signup(let username, let email, let password):
            return [
                "userName" : username,
                "email" : email,
                "password" : password
            ]
        case .login(let email, let password):
            return [
                "email" : email,
                "password" : password
            ]
        default:
            return ["":""]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var request = URLRequest(url: url)
        request.method = method
        request.headers = headers
        //통신의 컨텐트 타입이 form-urlencoded이므로 파라미터의 인코딩을 해당 타입에 맞게 해주고 API통신을 요청
        request = try URLEncodedFormParameterEncoder().encode(parameters, into: request)
        
        return request
    }
}
