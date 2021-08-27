//
//  MenuTableViewCell.swift
//  TodoApp
//
//  Created by ALEMDAR on 26.08.2021.
//

import UIKit
import SnapKit

class MenuTableViewCell: UITableViewCell {
    
    private let labelTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        label.textColor = Color.secondary
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(title: String){
        labelTitle.text = title
    }
    
    private func layout(){
        contentView.addSubview(labelTitle)
        labelTitle.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(16)
            make.bottom.trailing.equalToSuperview().offset(-16)
        }
    }
    
}
