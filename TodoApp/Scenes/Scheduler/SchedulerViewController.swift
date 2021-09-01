//
//  SchedulerViewController.swift
//  TodoApp
//
//  Created by ALEMDAR on 27.08.2021.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

class SchedulerViewController: BaseViewController<SchedulerViewModel> {
    
    private enum Constants {
        enum TableViewTasks {
            static let height: CGFloat = 56
        }
    }
    
    private let viewTop: UIView = {
        let view = UIView()
        view.backgroundColor = Color.primary
        return view
    }()
    
    private let labelTopTitle: UILabel = {
        let label = UILabel()
        label.text = "Upcoming tasks —"
        label.numberOfLines = 0
        label.textColor = Color.secondary
        label.font = UIFont(name: Font.Avenir.black, size: 24)
        return label
    }()
    
    private let tableViewTasks: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
        tableView.rowHeight = Constants.TableViewTasks.height
        return tableView
    }()
    
    private let viewSearch: UIView = {
        let view = UIView()
        view.backgroundColor = Color.primary
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        view.layer.shadowRadius = 5
        return view
    }()
    
    private let textFieldSearch: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = Color.secondary
        textField.layer.cornerRadius = 8
        textField.font = UIFont(name: Font.Avenir.book, size: 14)
        textField.textColor = .white
        textField.tintColor = .white
        
        let spaceView = UIView()
        spaceView.frame = CGRect(x: 0, y: 0, width: 8, height: 1)
        
        textField.leftView = spaceView
        textField.leftViewMode = .always
        textField.rightView = spaceView
        textField.rightViewMode = .always
        
        return textField
    }()
    
    private let viewSearchTasks: UIView = {
        let view = UIView()
        return view
    }()
    
    private let tableViewSearchTasks: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 32, right: 0)
        tableView.rowHeight = Constants.TableViewTasks.height
        return tableView
    }()
    
    private enum SearchBarState {
        case opened
        case closed
    }
    
    private let disposeBag = DisposeBag()
    private var searchBarState: SearchBarState = .closed
    private var dataSource: RxTableViewSectionedReloadDataSource<SchedulerSection>?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadTasks()
        viewModel.loadTasksByDate()
    }
    
    override func setupUI() {
        
        guard let navigationBar = navigationController?.navigationBar else { return }
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu-bar"), style: .plain, target: self, action: #selector(openMenu))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "magnifier"), style: .plain, target: self, action: #selector(openSearchBar))
        
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
        
        DispatchQueue.main.async {
            self.viewSearch.frame.origin.x = self.view.frame.width
            self.viewSearchTasks.frame.origin.y = self.view.frame.height
        }
    }
    
    @objc private func openMenu(){
        let menuVC = MenuViewController()
        menuVC.modalPresentationStyle = .overFullScreen
        present(menuVC, animated: false, completion: nil)
    }
    
    @objc private func openSearchBar(){
        switch searchBarState {
        case .closed:
            animateToOpenSearchBar()
        case .opened:
            animateToCloseSearchBar()
        break
        }
    }
    
    private func animateToOpenSearchBar(){
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
            self.viewSearch.frame.origin.x = 0
            self.viewSearchTasks.frame.origin.y = 70
        } completion: { done in
            if done {
                self.searchBarState = .opened
                self.textFieldSearch.becomeFirstResponder()
            }
        }
    }
    
    private func animateToCloseSearchBar(){
        
        self.textFieldSearch.rx.text.onNext("")
      
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseInOut) {
                self.viewSearch.frame.origin.x = self.view.frame.width
                self.viewSearchTasks.frame.origin.y = self.view.frame.height
            } completion: { done in
                if done {
                    self.searchBarState = .closed
                    self.textFieldSearch.resignFirstResponder()
                }
            }
        }
    }
    
    private func configureTableView(){
        tableViewTasks.rx.setDelegate(self).disposed(by: disposeBag)
        tableViewTasks.register(cellType: TaskTableViewCell.self)
        tableViewTasks.register(SchedulerHeader.self, forHeaderFooterViewReuseIdentifier: "schedulerHeader")
        
        tableViewSearchTasks.rx.setDelegate(self).disposed(by: disposeBag)
        tableViewSearchTasks.register(cellType: TaskTableViewCell.self)
    }
    
    override func bind() {
        
        // Create a datasource to bind with the tableView
        dataSource = RxTableViewSectionedReloadDataSource<SchedulerSection> { (dataSource, tableView, indexPath, taskItem) -> UITableViewCell in
            
            let cell = tableView.dequeCell(cellType: TaskTableViewCell.self, indexPath: indexPath)
        
            cell.configure(task: taskItem)
            
            return cell
        }
        
        guard let dataSource = dataSource else { return }

        viewModel.taskSections.bind(to: tableViewTasks.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        
        // Change the task status by selecting a task
        tableViewTasks.rx.itemSelected.subscribe(onNext: { indexPath in
            
            guard let cell = self.tableViewTasks.cellForRow(at: indexPath) as? TaskTableViewCell else { return }
        
            cell.toggleTaskStatus()
            
        }).disposed(by: disposeBag)
        
        // Filter tasks by searched text
        let searchedText = textFieldSearch.rx.text
        
        let filteredTasks = Observable.combineLatest(searchedText, viewModel.tasks).map { text, tasks -> [Task] in
            if let text = text, !text.isEmpty {
                return tasks.filter { $0.name.lowercased().contains(text.lowercased()) }
            }
            return []
        }
        
        filteredTasks.bind(to: tableViewSearchTasks.rx.items(cellIdentifier: TaskTableViewCell.identifier, cellType: TaskTableViewCell.self)) { row, model, cell in
            cell.configure(task: model)
        }.disposed(by: disposeBag)
        
        
        // Change task status by selecting a task
        tableViewSearchTasks.rx.itemSelected.subscribe(onNext: { indexPath in
            
            guard let cell = self.tableViewSearchTasks.cellForRow(at: indexPath) as? TaskTableViewCell else {
                return
            }
            
            cell.toggleTaskStatus()
            
            self.viewModel.loadTasksByDate()
            
        }).disposed(by: disposeBag)
        
        // Set an empty state to tableViews
        viewModel.taskSections.subscribe(onNext: { sections in
            if sections.count == 0 {
                self.tableViewTasks.layoutIfNeeded()
                self.tableViewTasks.setEmptyImage("no-results")
            }else {
                self.tableViewTasks.removeEmptyImage()
            }
        }).disposed(by: disposeBag)
        
        filteredTasks.subscribe(onNext: { tasks in
            if tasks.count == 0 {
                self.tableViewSearchTasks.layoutIfNeeded()
                self.tableViewSearchTasks.setEmptyImage("no-results")
            }else {
                self.tableViewSearchTasks.removeEmptyImage()
            }
        }).disposed(by: disposeBag)
        
    }
    
    override func layout() {
        
        view.addSubview(viewTop)
        viewTop.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalToSuperview()
        }
        
        viewTop.addSubview(labelTopTitle)
        labelTopTitle.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(32)
            make.bottom.equalToSuperview().offset(-32)
            make.width.equalTo(120)
        }
        
        view.addSubview(tableViewTasks)
        tableViewTasks.snp.makeConstraints { (make) in
            make.top.equalTo(viewTop.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        view.addSubview(viewSearch)
        viewSearch.snp.makeConstraints { (make) in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(72)
        }
        
        viewSearch.addSubview(textFieldSearch)
        textFieldSearch.snp.makeConstraints { (make) in
            make.top.leading.equalToSuperview().offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.height.equalTo(40)
        }
        
        view.addSubview(viewSearchTasks)
        viewSearchTasks.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(72)
            make.leading.bottom.trailing.equalToSuperview()
        }
        
        viewSearchTasks.addSubview(tableViewSearchTasks)
        tableViewSearchTasks.snp.makeConstraints { (make) in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
        
    }
    
}

extension SchedulerViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: "schedulerHeader") as? SchedulerHeader else {
            return UIView()
        }
        
        guard let dataSource = dataSource else { return UIView() }
        
        view.configure(title: dataSource.sectionModels[section].header)
        
        return view
    }

}
