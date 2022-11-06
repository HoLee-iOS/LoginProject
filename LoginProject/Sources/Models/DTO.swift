//
//  DTO.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/06.
//

import Foundation

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
