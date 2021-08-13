//
//  LoginViewController.swift
//  TodoApp
//
//  Created by ALEMDAR on 13.08.2021.
//

import SnapKit
import UIKit

class LoginViewController: UIViewController {
    
    private let labelPageTitle: UILabel = {
        let label = UILabel()
        label.text = "LOGIN"
        label.textColor = Color.secondary
        label.font = UIFont(name: "Avenir-Black", size: 14)
        label.attributedText = NSAttributedString(string: label.text ?? "", attributes: [.kern : 4])
        return label
    }()
    
    private let labelEmail: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = Color.secondary
        label.font = UIFont(name: "Avenir-Book", size: 12)
        return label
    }()
    
    private let textFieldEmail: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Avenir-Book", size: 12)
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private let stackViewEmail: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let labelPassword: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = Color.secondary
        label.font = UIFont(name: "Avenir-Book", size: 12)
        return label
    }()
    
    private let labelForgot: UILabel = {
        let label = UILabel()
        label.text = "Forgot?"
        label.textColor = Color.secondary.withAlphaComponent(0.5)
        label.font = UIFont(name: "Avenir-Book", size: 12)
        label.attributedText = NSAttributedString(string: label.text ?? "", attributes: [.underlineStyle: NSUnderlineStyle.thick.rawValue])
        return label
    }()
    
    private let textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Avenir-Book", size: 12)
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private let stackViewPassword: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let stackViewPasswordWithForgot: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        return stackView
    }()
    
    private let stackViewLogin: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let buttonLogin: UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.backgroundColor = Color.secondary
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.tintColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let labelRegister: UILabel = {
        let label = UILabel()
        label.textColor = Color.secondary
        label.font = UIFont(name: "Avenir-Heavy", size: 14)
        label.attributedText = NSAttributedString(string: "New User? Register Here", attributes: [.underlineStyle: 1])
        return label
    }()
    
    private let viewLoginContent: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        buttonLogin.addTarget(self, action: #selector(buttonLoginAction), for: .touchUpInside)
    }
    
    @objc func buttonLoginAction() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primary
        layout()
        addGesture()
        textFieldDelegate()
    }
    
    private func textFieldDelegate() {
        textFieldEmail.delegate = self
        textFieldPassword.delegate = self
    }
    
    private func addGesture() {
        view.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(endEditingGesture))
        view.addGestureRecognizer(gesture)
    }
    
    @objc private func endEditingGesture() {
        view.endEditing(true)
        UIView.animate(withDuration: 0.3) {
            self.viewLoginContent.snp.updateConstraints { (maker) in
                maker.centerY.equalToSuperview()
            }
            self.view.layoutIfNeeded()
        }
    }
    
    private func layout(){
        
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(viewLoginContent)
        viewLoginContent.snp.makeConstraints { (make) in
            make.leading.equalTo(safeArea).offset(32)
            make.trailing.equalTo(safeArea).offset(-32)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-50)
            make.width.height.equalTo(200)
        }
        
        view.addSubview(labelPageTitle)
        labelPageTitle.snp.makeConstraints { (make) in
            make.top.equalTo(safeArea).offset(33)
            make.centerX.equalTo(safeArea)
        }
        
        stackViewEmail.addArrangedSubview(labelEmail)
        stackViewEmail.addArrangedSubview(textFieldEmail)
        textFieldEmail.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        
        stackViewPasswordWithForgot.addArrangedSubview(labelPassword)
        stackViewPasswordWithForgot.addArrangedSubview(labelForgot)
        
        stackViewPassword.addArrangedSubview(stackViewPasswordWithForgot)
        stackViewPassword.addArrangedSubview(textFieldPassword)
        textFieldPassword.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        stackViewLogin.addArrangedSubview(stackViewEmail)
        stackViewLogin.addArrangedSubview(stackViewPassword)
        
        viewLoginContent.addSubview(stackViewLogin)
        stackViewLogin.snp.makeConstraints { (make) in
            make.centerY.equalTo(viewLoginContent.snp.centerY)
            make.leading.equalTo(viewLoginContent)
            make.trailing.equalTo(viewLoginContent)
        }
        
        viewLoginContent.addSubview(buttonLogin)
        buttonLogin.snp.makeConstraints { (make) in
            make.top.equalTo(stackViewLogin.snp.bottom).offset(40)
            make.leading.equalTo(viewLoginContent)
            make.trailing.equalTo(viewLoginContent)
            make.height.equalTo(50)
        }
        
        viewLoginContent.addSubview(labelRegister)
        labelRegister.snp.makeConstraints { (make) in
            make.top.equalTo(buttonLogin.snp.bottom).offset(40)
            make.centerX.equalTo(viewLoginContent)
        }
        
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.3) {
            self.viewLoginContent.snp.updateConstraints { (maker) in
                maker.centerY.equalToSuperview().offset(-200)
            }
            self.view.layoutIfNeeded()
        }
    }
}
