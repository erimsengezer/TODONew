//
//  MenuViewController.swift
//  TodoApp
//
//  Created by ALEMDAR on 25.08.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MenuViewController: BaseViewController<MenuViewModel> {
    
    private let viewMenu: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private let viewMenuTop: UIView = {
        let view = UIView()
        return view
    }()
    
    private let viewMenuBorder: UIView = {
        let view = UIView()
        view.backgroundColor = Color.secondary.withAlphaComponent(0.2)
        return view
    }()
    
    private let imageViewProfile: UIView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "me")
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let labelUserName: UILabel = {
        let label = UILabel()
        label.text = "Samet"
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.black, size: 24)
        return label
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        addGestures()
        configureTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewMenu.frame.origin.x = -(view.frame.width - 75)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.viewMenu.frame.origin.x = 0
        }, completion: nil)
    }
    
    override func setupUI(){
        view.backgroundColor = .none
    }
    
    private func configureTableView(){
        tableView.register(cellType: MenuTableViewCell.self)
    }
    
    private func addGestures(){
        let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(swipeToLeft))
        swipeGesture.direction = .left
        viewMenu.addGestureRecognizer(swipeGesture)
    }
    
    @objc func swipeToLeft(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.viewMenu.frame.origin.x = -(self.view.frame.width - 75)
        } completion: { done in
            if done {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    override func bind(){
        viewModel.elements.bind(to: tableView.rx.items(cellIdentifier: MenuTableViewCell.identifier, cellType: MenuTableViewCell.self)) { row, model, cell in
            cell.configure(title: model)
        }.disposed(by: disposeBag)
        
        viewModel.load()
    }
    
    override func layout(){
        
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(viewMenu)
        viewMenu.snp.makeConstraints { (make) in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-75)
        }
        
        viewMenu.addSubview(viewMenuTop)
        viewMenuTop.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalTo(safeArea)
        }
        
        viewMenuTop.addSubview(imageViewProfile)
        imageViewProfile.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(16)
            make.width.height.equalTo(50)
            make.bottom.equalToSuperview().offset(-16)
        }
        
        viewMenuTop.addSubview(labelUserName)
        labelUserName.snp.makeConstraints { (make) in
            make.centerY.equalTo(imageViewProfile)
            make.leading.equalTo(imageViewProfile.snp.trailing).offset(16)
        }
        
        viewMenu.addSubview(viewMenuBorder)
        viewMenuBorder.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(viewMenuTop.snp.bottom)
            make.height.equalTo(1)
        }
        
        viewMenu.addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(viewMenuBorder.snp.bottom)
            make.leading.bottom.trailing.equalToSuperview()
        }
    }
    
}
