//
//  ProfileViewController.swift
//  TodoApp
//
//  Created by ALEMDAR on 2.09.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ProfileViewController: BaseViewController<ProfileViewModel> {
    
    private let viewTop: UIView = {
        let view = UIView()
        view.backgroundColor = Color.primary
        return view
    }()
    
    private let labelFullName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.black, size: 24)
        return label
    }()
    
    private let labelEmail: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    private let stackViewUserInfo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    private let imageViewUser: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "me")
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 28
        return imageView
    }()
    
    private let labelNotification: UILabel = {
        let label = UILabel()
        label.text = "Notification Settings"
        label.textColor = Color.secondary.withAlphaComponent(0.5)
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    private let labelEmailNotification: UILabel = {
        let label = UILabel()
        label.text = "Get email notifications"
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    private let switchEmailNotification: UISwitch = {
        let _switch = UISwitch()
        _switch.onTintColor = Color.lightGreen
        return _switch
    }()
    
    private let labelVibrate: UILabel = {
        let label = UILabel()
        label.text = "Vibrate on alert"
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    private let switchVibrate: UISwitch = {
        let _switch = UISwitch()
        _switch.onTintColor = Color.lightGreen
        return _switch
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.load()
    }
    
    override func setupUI() {
        
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu-bar"), style: .plain, target: self, action: #selector(openMenu))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu-note"), style: .plain, target: self, action: #selector(openEditProfile))
        
        navigationBar.setValue(true, forKey: "hidesShadow")
        navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationBar.layer.shadowOpacity = 0.2
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.layer.shadowRadius = 5
        
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = Color.primary
        navigationBar.titleTextAttributes = [
            .foregroundColor: Color.secondary,
            .font: UIFont(name: Font.Avenir.black, size: 14) as Any,
            .kern: 4,
        ]

        view.backgroundColor = .white
    }
    
    @objc private func openMenu(){
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        present(menuVC, animated: false, completion: nil)
    }
    
    @objc private func openEditProfile(){
       //MARK: - Edit Profile Scene
    }
    
    override func bind() {
        
        viewModel.user.subscribe(onNext: { user in
            
            guard let user = user else { return }
            
            if user.fullName.isEmpty {
                user.fullName = "Full Name"
            }
            
            self.labelFullName.text = user.fullName
            self.labelEmail.text = user.email
            
            if user.isVibrationOpen {
                self.switchVibrate.isOn = true
            }
            
            if user.isNotificationOpen {
                self.switchEmailNotification.isOn = true
            }
            
        }).disposed(by: disposeBag)
        
        switchEmailNotification.rx.value.subscribe(onNext: { state in
            self.viewModel.user.value?.setIsNotificationOpen(state: state)
        }).disposed(by: disposeBag)
        
        switchVibrate.rx.value.subscribe(onNext: { state in
            self.viewModel.user.value?.setIsVibrationOpen(state: state)
        }).disposed(by: disposeBag)
        
    }
        
    override func layout() {
        
        view.addSubview(viewTop)
        viewTop.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
        }
        
        viewTop.addSubview(imageViewUser)
        imageViewUser.snp.makeConstraints { (make) in
            make.leading.top.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-32)
            make.width.height.equalTo(56)
        }
        
        viewTop.addSubview(stackViewUserInfo)
        stackViewUserInfo.snp.makeConstraints { (make) in
            make.leading.equalTo(imageViewUser.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-32)
            make.centerY.equalTo(imageViewUser)
        }
        
        stackViewUserInfo.addArrangedSubview(labelFullName)
        stackViewUserInfo.addArrangedSubview(labelEmail)
        
        view.addSubview(labelNotification)
        labelNotification.snp.makeConstraints { (make) in
            make.top.equalTo(viewTop.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
        }
        
        view.addSubview(labelEmailNotification)
        labelEmailNotification.snp.makeConstraints { (make) in
            make.top.equalTo(labelNotification.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
        }
        
        view.addSubview(switchEmailNotification)
        switchEmailNotification.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-32)
            make.centerY.equalTo(labelEmailNotification)
        }
        
        view.addSubview(labelVibrate)
        labelVibrate.snp.makeConstraints { (make) in
            make.top.equalTo(labelEmailNotification.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
        }
        
        view.addSubview(switchVibrate)
        switchVibrate.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().offset(-32)
            make.centerY.equalTo(labelVibrate)
        }
          
    }
    
}
