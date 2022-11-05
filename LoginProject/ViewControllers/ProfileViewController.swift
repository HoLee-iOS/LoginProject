//
//  ProfileViewController.swift
//  LoginProject
//
//  Created by 이현호 on 2022/11/04.
//

import Foundation
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProfileViewController: BaseViewController {
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.layer.masksToBounds = true
        return image
    }()
    let emailLabel = UILabel()
    let nameLabel = UILabel()
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그아웃", for: .normal)
        button.backgroundColor = .green
        return button
    }()
    
    let viewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.requestProfile()
        view.backgroundColor = .white
    }
    
    override func configure() {
        [profileImage, emailLabel, nameLabel, logoutButton].forEach { view.addSubview($0) }
    }
    
    override func setConstraints() {
        profileImage.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(40)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(profileImage.snp.width)
        }
        
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImage.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
        
        logoutButton.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(50)
        }
    }
    
    override func bindData() {
        
        viewModel.photo
            .map{ UIImage(data: $0) }
            .asDriver(onErrorJustReturn: UIImage(systemName: "star"))
            .drive(profileImage.rx.image)
            .disposed(by: disposeBag)
        
        viewModel.email
            .asDriver(onErrorJustReturn: "통신 실패")
            .drive(emailLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.username
            .asDriver(onErrorJustReturn: "통신 실패")
            .drive(nameLabel.rx.text)
            .disposed(by: disposeBag)
        
        logoutButton.rx.tap
            .withUnretained(self)
            .bind { (vc, _) in
                UserDefaults.standard.set("", forKey: "token")
                vc.transitionVC(vc: SignUpViewController.self)
            }
            .disposed(by: disposeBag)
    }
    
}
