//
//  NewTaskViewController.swift
//  TodoApp
//
//  Created by ALEMDAR on 31.08.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class NewTaskViewController: BaseViewController<NewTaskViewModel> {
    
    private let viewTop: UIView = {
        let view = UIView()
        view.backgroundColor = Color.primary
        return view
    }()
    
    private let textFieldTaskName: UITextField = {
        let textField = UITextField()
        textField.textColor = Color.secondary
        textField.tintColor = Color.secondary
        textField.font = UIFont(name: Font.Avenir.black, size: 24)
        textField.attributedPlaceholder = NSAttributedString(string: "Write here....", attributes: [.foregroundColor: Color.secondary.withAlphaComponent(0.5)])
        return textField
    }()
    
    private let labelDate: UILabel = {
        let label = UILabel()
        label.text = "Complete by"
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    private let datePickerDate: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.minimumDate = Date()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.backgroundColor = Color.primary
        datePicker.tintColor = Color.secondary
        return datePicker
    }()
    
    private let labelPriority: UILabel = {
        let label = UILabel()
        label.text = "Priority"
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    private let pickerPriority: UIPickerView = {
        let pickerView = UIPickerView()
        return pickerView
    }()
    
    private let labelMoreOption: UILabel = {
        let label = UILabel()
        label.text = "More Options"
        label.textColor = Color.secondary.withAlphaComponent(0.5)
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    private let labelSaveAsAlarm: UILabel = {
        let label = UILabel()
        label.text = "Save as alarm"
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    private let switchAlarm: UISwitch = {
        let _switch = UISwitch()
        _switch.onTintColor = Color.lightGreen
        return _switch
    }()
    
    private let labelShowAsNotification: UILabel = {
        let label = UILabel()
        label.text = "Show as notification"
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.book, size: 12)
        return label
    }()
    
    private let switchNotification: UISwitch = {
        let _switch = UISwitch()
        _switch.onTintColor = Color.lightGreen
        return _switch
    }()
    
    private let buttonCheck: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "accept-new-task"), for: .normal)
        button.layer.masksToBounds = false
        button.layer.shadowColor = Color.secondary.cgColor
        button.layer.shadowOpacity = 0.5
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowRadius = 2
        return button
    }()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupUI() {
        
        guard let navigationBar = navigationController?.navigationBar else { return }
                
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "close-icon"), style: .plain, target: self, action: #selector(closeScene))
        
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

    override func viewWillAppear(_ animated: Bool) {
        hideTabBar()
    }
    
    @objc private func closeScene(){
        setToInitialValues()
        showTabBar()
        tabBarController?.selectedIndex = .zero
    }
    
    private func setToInitialValues(){
        textFieldTaskName.text = ""
        datePickerDate.date = Date()
        pickerPriority.selectRow(0, inComponent: 0, animated: true)
        switchAlarm.isOn = false
        switchNotification.isOn = false
    }
    
    override func bind() {
 
        // Bind priorities to picker
        Observable.just(TaskPriority.allCases).bind(to: pickerPriority.rx.itemTitles) { row, element in
            return element.rawValue
        }.disposed(by: disposeBag)
        
        // Insert task to realm
        buttonCheck.rx.tap.subscribe(onNext: {
            
            if ((self.textFieldTaskName.text ?? "").isEmpty) {
                AlertManager.shared.showAlert(layout: .messageView, type: .error, message: "Please enter a task name!")
                return
            }
            
            let name = self.textFieldTaskName.text ?? ""
            let priority = TaskPriority.allCases[self.pickerPriority.selectedRow(inComponent: 0)]
            let isAlarm = self.switchAlarm.isOn
            let isNotification = self.switchNotification.isOn
            let date = self.datePickerDate.date
            
            let task = Task(name: name, priority: priority, isDone: false, isAlarm: isAlarm, isNotification: isNotification, date: date)
            task.insertToRealm()
            
            AlertManager.shared.showAlert(layout: .messageView, type: .success, message: "Task added successfully.")
            self.closeScene()
            
        }).disposed(by: disposeBag)
        
    }
    
    override func layout() {
        
        view.addSubview(viewTop)
        viewTop.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
        }
        
        viewTop.addSubview(textFieldTaskName)
        textFieldTaskName.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(32)
            make.bottom.trailing.equalToSuperview().offset(-32)
        
        }
        
        view.addSubview(labelDate)
        labelDate.snp.makeConstraints { (make) in
            make.top.equalTo(viewTop.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        view.addSubview(datePickerDate)
        datePickerDate.snp.makeConstraints { (make) in
            make.top.equalTo(labelDate.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(32)

        }
        
        view.addSubview(labelPriority)
        labelPriority.snp.makeConstraints { (make) in
            make.top.equalTo(datePickerDate.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        view.addSubview(pickerPriority)
        pickerPriority.snp.makeConstraints { (make) in
            make.top.equalTo(labelPriority.snp.bottom)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
            make.height.equalTo(100)
        }
        
        view.addSubview(labelMoreOption)
        labelMoreOption.snp.makeConstraints { (make) in
            make.top.equalTo(pickerPriority.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(32)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        view.addSubview(labelSaveAsAlarm)
        labelSaveAsAlarm.snp.makeConstraints { (make) in
            make.top.equalTo(labelMoreOption.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
        }
        
        view.addSubview(switchAlarm)
        switchAlarm.snp.makeConstraints { (make) in
            make.centerY.equalTo(labelSaveAsAlarm)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        view.addSubview(labelShowAsNotification)
        labelShowAsNotification.snp.makeConstraints { (make) in
            make.top.equalTo(labelSaveAsAlarm.snp.bottom).offset(32)
            make.leading.equalToSuperview().offset(32)
        }
        
        view.addSubview(switchNotification)
        switchNotification.snp.makeConstraints { (make) in
            make.centerY.equalTo(labelShowAsNotification)
            make.trailing.equalToSuperview().offset(-32)
        }
        
        view.addSubview(buttonCheck)
        buttonCheck.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-16)
        }
        
    }
    
}
