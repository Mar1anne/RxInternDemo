//
//  MenuViewController.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/22/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class MenuViewController: BaseViewController {

    let tableView = UITableView()
    private let disposeBag = DisposeBag()

    let menuOptions = Observable.just(["My Posts", "Popular posts", "Sync", "Logout"]) // TODO: Change them runtime if other options are needed or changed
        
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
    }
    
    //MARK: - View setup
    override func setupViews() {
        super.setupViews()
        
        view.backgroundColor = .yellow
        
        let headerSize = CGSize(width: Constants.UI.screenWidth, height: Constants.UI.screenHeight*0.5)
        let headerView = MenuTableHeaderView(frame: CGRect(origin: CGPoint.zero, size: headerSize))
        headerView.bindTo(userObservable: UserManager.shared.observableUser!)
        
        tableView.isScrollEnabled = false
        tableView.tableFooterView = UIView()
        tableView.tableHeaderView = headerView
        tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: MenuTableViewCell.identifier)

        view.addSubview(tableView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    //MARK: - Rx setup
    private func setupTableView() {
        menuOptions
            .bindTo(tableView.rx.items(cellIdentifier: MenuTableViewCell.identifier, cellType: MenuTableViewCell.self)) { (row, element, cell) in
            cell.textLabel?.text = element
        }
        .addDisposableTo(disposeBag)
    }
}
