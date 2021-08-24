//
//  RegisterViewController.swift
//  TodoApp
//
//  Created by ALEMDAR on 13.08.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class RegisterViewController: BaseViewController<RegisterViewModel> {
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private let scrollViewContent: UIView = {
        let view = UIView()
        return view
    }()
    
    private let labelPageTitle: UILabel = {
        let label = UILabel()
        label.text = "REGISTER"
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.black, size: 14)
        label.attributedText = NSAttributedString(string: label.text ?? "", attributes: [.kern : 4])
        return label
    }()
    
    private let labelEmail: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    private let textFieldEmail: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont(name: Font.Avenir.book, size: 12)
        textField.layer.cornerRadius = 8
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        let spacingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftView = spacingView
        textField.rightView = spacingView
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
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    private let textFieldPassword: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont(name: Font.Avenir.book, size: 12)
        textField.layer.cornerRadius = 8
        textField.isSecureTextEntry = true
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        let spacingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftView = spacingView
        textField.rightView = spacingView
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
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    private let textFieldConfirmPassword: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = .white
        textField.font = UIFont(name: Font.Avenir.book, size: 12)
        textField.layer.cornerRadius = 8
        textField.isSecureTextEntry = true
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        let spacingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
        textField.leftView = spacingView
        textField.rightView = spacingView
        return textField
    }()
    
    private let stackViewConfirmPassword: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let stackViewRegister: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private let buttonRegister: UIButton = {
        let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = Color.secondary
        button.titleLabel?.font = UIFont(name: Font.Avenir.heavy, size: 14)
        button.tintColor = .white
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let labelTermsAndPolicies: UILabel = {
        let label = UILabel()
        label.text = """
                By registering, you automatically accept the Terms & Policies of candy app.
            """
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let labelLogin: UILabel = {
        let label = UILabel()
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.heavy, size: 14)
        label.attributedText = NSAttributedString(string: "Have account? Log In", attributes: [.underlineStyle: 1])
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let viewRegisterContent: UIView = {
        let view = UIView()
        return view
    }()
    
    var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addGesture()
    }
    
    override func setupUI(){
        view.backgroundColor = Color.primary
    }
    
    override func bind(){

        textFieldEmail.rx.text.map{ $0 ?? "" }.bind(to: viewModel.emailFieldViewModel.value).disposed(by: disposeBag)
        textFieldPassword.rx.text.map{ $0 ?? "" }.bind(to: viewModel.passwordFieldViewModel.value).disposed(by: disposeBag)
        textFieldConfirmPassword.rx.text.map{ $0 ?? "" }.bind(to: viewModel.repasswordFieldViewModel.value).disposed(by: disposeBag)
                
        buttonRegister.rx.tap.subscribe(onNext: {
            if self.viewModel.isValidForm() {
                self.viewModel.register()
                if self.viewModel.isSuccess.value {
                    self.dismiss(animated: true, completion: nil)
                }
            }else{
                self.viewModel.showAlert()
            }
        }).disposed(by: disposeBag)
    }
    
    private func addGesture(){
        let gesture = UITapGestureRecognizer(target: self, action: #selector(endEditingGesture))
        view.addGestureRecognizer(gesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelLoginTapped))
        labelLogin.addGestureRecognizer(tapGesture)
    }
    
    @objc private func endEditingGesture(){
        view.endEditing(true)
    }
    
    @objc private func labelLoginTapped(){
        dismiss(animated: true, completion: nil)
    }
    
    override func layout(){
        
        let safeArea = self.view.safeAreaLayoutGuide
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalTo(safeArea)
        }
        
        scrollView.addSubview(scrollViewContent)
        scrollViewContent.snp.makeConstraints { (make) in
            make.top.leading.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
            make.trailing.equalTo(scrollView)
            make.height.equalTo(view).priority(250)
            make.width.equalTo(view)
        }
        
        scrollViewContent.addSubview(labelPageTitle)
        labelPageTitle.snp.makeConstraints { (make) in
            make.top.equalTo(scrollViewContent).offset(32)
            make.centerX.equalTo(scrollViewContent)
        }
        
        scrollViewContent.addSubview(viewRegisterContent)
        viewRegisterContent.snp.makeConstraints { (make) in
            make.top.equalTo(labelPageTitle.snp.bottom).offset(50)
            make.leading.equalTo(scrollViewContent).offset(32)
            make.trailing.equalTo(scrollViewContent).offset(-32)
            make.bottom.equalTo(scrollViewContent)
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
        
        stackViewRegister.addArrangedSubview(stackViewEmail)
        stackViewRegister.addArrangedSubview(stackViewPassword)
        stackViewRegister.addArrangedSubview(stackViewConfirmPassword)
        
        viewRegisterContent.addSubview(stackViewRegister)
        stackViewRegister.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(viewRegisterContent)
        }
        
        viewRegisterContent.addSubview(buttonRegister)
        buttonRegister.snp.makeConstraints { (make) in
            make.top.equalTo(stackViewRegister.snp.bottom).offset(40)
            make.leading.equalTo(viewRegisterContent)
            make.trailing.equalTo(viewRegisterContent)
            make.height.equalTo(50)
        }
        
        viewRegisterContent.addSubview(labelTermsAndPolicies)
        labelTermsAndPolicies.snp.makeConstraints { (make) in
            make.top.equalTo(buttonRegister.snp.bottom).offset(40)
            make.leading.equalTo(viewRegisterContent).offset(60)
            make.trailing.equalTo(viewRegisterContent).offset(-60)
        }
        
        viewRegisterContent.addSubview(labelLogin)
        labelLogin.snp.makeConstraints { (make) in
            make.top.equalTo(labelTermsAndPolicies.snp.bottom).offset(40)
            make.centerX.equalTo(viewRegisterContent)
        }
        
    }
}
