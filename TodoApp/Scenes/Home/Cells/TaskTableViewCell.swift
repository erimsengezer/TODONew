//
//  TaskTableViewCell.swift
//  TodoApp
//
//  Created by ALEMDAR on 25.08.2021.
//

import UIKit
import SnapKit

class TaskTableViewCell: UITableViewCell {
    
    private let viewContent: UIView = {
        let view = UIView()
        return view
    }()
    
    private let imageViewStatus: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "unchecked")
        return imageView
    }()
    
    private let labelName: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        label.textColor = Color.secondary
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var task: Task?
    
    func configure(task: Task) {
        
        self.task = task
        
        labelName.text = task.name
        
        if task.isDone {
            imageViewStatus.image = UIImage(named: "checked")
            labelName.textColor  = labelName.textColor.withAlphaComponent(0.5)
        }else {
            imageViewStatus.image = UIImage(named: "unchecked")
            labelName.textColor  = labelName.textColor.withAlphaComponent(1)
        }
    
    }
    
    func toggleTaskStatus() {
        
        guard let task = task else { return }
        
        if task.isDone {
            task.isDone = false
            task.setTaskToNotDone()
            
            imageViewStatus.image = UIImage(named: "unchecked")
            labelName.textColor  = labelName.textColor.withAlphaComponent(1)
        }else {
            task.isDone = true
            task.setTaskToDone()
            
            imageViewStatus.image = UIImage(named: "checked")
            labelName.textColor  = labelName.textColor.withAlphaComponent(0.5)
        }
    }
    
    private func setupUI(){
        selectionStyle = .none
    }
    
    private func layout(){
        
        contentView.addSubview(viewContent)
        viewContent.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        viewContent.addSubview(imageViewStatus)
        imageViewStatus.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview()
            make.width.height.equalTo(24)
        }
        
        viewContent.addSubview(labelName)
        labelName.snp.makeConstraints { (make) in
            make.leading.equalTo(imageViewStatus.snp.trailing).offset(24)
            make.trailing.equalToSuperview()
            make.centerY.equalTo(imageViewStatus)
        }
        
    }
    
}
