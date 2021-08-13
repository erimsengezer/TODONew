//
//  LoginViewController.swift
//  TodoApp
//
//  Created by ALEMDAR on 13.08.2021.
//

import SnapKit
import UIKit

class RegisterViewController: UIViewController {
    
    private let labelPageTitle: UILabel = {
        let label = UILabel()
        label.text = "REGISTER"
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
    
    private let labelConfirmPassword: UILabel = {
        let label = UILabel()
        label.text = "Confirm Password"
        label.textColor = Color.secondary
        label.font = UIFont(name: "Avenir-Book", size: 12)
        return label
    }()
    
    private let textFieldConfirmPassword: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont(name: "Avenir-Book", size: 12)
        textField.layer.cornerRadius = 8
        return textField
    }()
    
    private let stackViewConfirmPassword: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
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
        button.setTitle("Register", for: .normal)
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
        label.attributedText = NSAttributedString(string: "Have account? Log In", attributes: [.underlineStyle: 1])
        return label
    }()
    
    private let viewLoginContent: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.primary
        layout()
    }
    
    private func layout(){
        
        let safeArea = view.safeAreaLayoutGuide
        
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
        
        stackViewPassword.addArrangedSubview(labelPassword)
        stackViewPassword.addArrangedSubview(textFieldPassword)
        textFieldPassword.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        stackViewConfirmPassword.addArrangedSubview(labelConfirmPassword)
        stackViewConfirmPassword.addArrangedSubview(textFieldConfirmPassword)
        textFieldConfirmPassword.snp.makeConstraints { (make) in
            make.height.equalTo(50)
        }
        
        stackViewLogin.addArrangedSubview(stackViewEmail)
        stackViewLogin.addArrangedSubview(stackViewPassword)
        stackViewLogin.addArrangedSubview(stackViewConfirmPassword)
        
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
        
        view.addSubview(viewLoginContent)
        viewLoginContent.snp.makeConstraints { (make) in
            make.leading.equalTo(safeArea).offset(32)
            make.trailing.equalTo(safeArea).offset(-32)
            make.center.equalTo(safeArea)
        }
    }
}
