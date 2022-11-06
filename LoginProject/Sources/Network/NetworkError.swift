//
//  NetworkError.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/03.
//

import Foundation

//네트워크 에러에 대한 열거형 케이스
enum NetworkError: Error {
    case badRequest
    case serverError
    case networkFail
}
