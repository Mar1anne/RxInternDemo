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

class MenuViewController: BaseViewController, MenuView {

    let tableView = UITableView()
    private let disposeBag = DisposeBag()
    private var presenter: MenuViewPresenter!
    
    
    init(withPresenter presenter: MenuViewPresenter) {
        super.init()
        self.presenter = presenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        presenter.detachView(self)
    }
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter.attachView(self)
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
        // Cell selection handler
        tableView
            .rx
            .itemSelected
            .subscribe { [weak self] (indexPath) in
                if let cellIndexPath = indexPath.element {
                    self?.tableView.deselectRow(at: cellIndexPath, animated: false)
                    self?.presenter.onMenuOptionSelected(atIndex: cellIndexPath.row)
                }
                self?.evo_drawerController?.toggleLeftDrawerSide(animated: true, completion: nil)
            }.addDisposableTo(disposeBag)
    }
    
    //MARK: - MenuView methods
    func setMenuOptions(_ options: Observable<[String]>) {
        options
            .bindTo(tableView.rx.items(cellIdentifier: MenuTableViewCell.identifier,
                                       cellType: MenuTableViewCell.self))
            { (row, element, cell) in
                cell.textLabel?.text = element
            }
            .addDisposableTo(disposeBag)
    }
    
}
