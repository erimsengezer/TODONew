//
//  File.swift
//  TodoApp
//
//  Created by ALEMDAR on 10.08.2021.
//

import SnapKit

class SplashViewController: UIViewController {
    
    private enum Constants {
        enum Logo {
            static let width: CGFloat = 122
            static let height: CGFloat = 230
        }
    }
    
    private let stackViewLogo: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        return stackView
    }()
    
    private let imageViewLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let labelLogoBottom: UILabel = {
        let label = UILabel()
        label.text = "Simple Task Manager"
        label.font = UIFont(name: "Avenir-Book", size: 12)
        label.textColor = Color.secondary
        return label
    }()
    
    private let labelScreenBottom: UILabel = {
        let label = UILabel()
        label.text = "© 2021 Candy"
        label.font = UIFont(name: "Avenir-Book", size: 12)
        label.textColor = Color.secondary.withAlphaComponent(0.5)
        return label
    }()
    
    private let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.trackTintColor = .white
        progressView.progressTintColor = Color.secondary
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Color.primary
        layout()
    }
    
    private func layout() {
        
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(stackViewLogo)
        stackViewLogo.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview()
        }
        
        stackViewLogo.addArrangedSubview(imageViewLogo)
        imageViewLogo.snp.makeConstraints { (make) in
            make.width.equalTo(Constants.Logo.width)
            make.height.equalTo(Constants.Logo.height)
        }
        
        stackViewLogo.addArrangedSubview(labelLogoBottom)
        
        view.addSubview(labelScreenBottom)
        labelScreenBottom.snp.makeConstraints { (make) in
            make.bottom.equalTo(-24)
            make.centerX.equalTo(safeArea.snp.centerX)
        }
        
        view.addSubview(progressView)
        progressView.snp.makeConstraints { (make) in
            make.top.equalTo(stackViewLogo.snp.bottom).offset(20)
            make.width.equalTo(Constants.Logo.width)
            make.centerX.equalTo(safeArea.snp.centerX)
        }
        
    }
    
}
