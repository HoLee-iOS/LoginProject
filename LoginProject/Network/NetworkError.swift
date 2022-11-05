//
//  NetworkError.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/03.
//

import Foundation

enum NetworkError: Error {
    case badRequest
    case serverError
    case networkFail
}
