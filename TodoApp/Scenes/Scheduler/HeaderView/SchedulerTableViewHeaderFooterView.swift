//
//  SchedulerTableViewHeaderFooterView.swift
//  TodoApp
//
//  Created by ALEMDAR on 31.08.2021.
//

import UIKit
import SnapKit

class SchedulerHeader: UITableViewHeaderFooterView {
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.textColor = Color.secondary.withAlphaComponent(0.5)
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String){
        labelTitle.text = title
    }
    
    private func setupUI(){
        backgroundView = UIView(frame: self.bounds)
        backgroundView?.backgroundColor = .white
    }
    
    private func layout(){
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(32)
            make.bottom.trailing.equalToSuperview()
        }
    }
    
}
