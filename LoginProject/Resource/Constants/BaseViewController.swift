//
//  BaseViewController.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/02.
//

import Foundation
import UIKit
import Toast

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        configure()
        setConstraints()
        bindData()
    }
    
    func configure() { }
    
    func setConstraints() { }
    
    func bindData() { }
    
    func transitionVC<T: UIViewController>(vc: T.Type) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = vc.init()
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    func showToastMessage(_ message: String) {
        self.view.makeToast(message, position: .bottom)
    }
}
