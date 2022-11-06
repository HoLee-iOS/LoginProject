//
//  CommonViewModel.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/06.
//

import Foundation

protocol CommonViewModel {
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
    
}
