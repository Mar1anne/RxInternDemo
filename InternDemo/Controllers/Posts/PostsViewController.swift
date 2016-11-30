//
//  PostsViewController.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/22/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit

class PostsViewController: BaseViewController, PostsView {

    // TODO: Add collection view
    
    private var presenter: PostsPresenter!
    
    init(withPresenter presenter: PostsPresenter) {
        super.init()
        self.presenter = presenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.presenter.detachView(self)
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.attachView(self)
    }
    
    //MARK: View setup
    override func setupViews() {
        super.setupViews()
        
        view.backgroundColor = .lightGray
        navigationController?.navigationBar.isTranslucent = false
        
        addMenuButton()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
    }
    
    private func addMenuButton() {
        let image = UIImage(named: "cm_menu_white")
        let barButton = UIBarButtonItem(image: image,
                                        style: .plain,
                                        target: self, action: #selector(onMenu(barButton:)))
        navigationItem.setLeftBarButton(barButton, animated: false)
    }
    
    // MARK: Button actions
    func onMenu(barButton: UIBarButtonItem) {
        evo_drawerController?.toggleLeftDrawerSide(animated: true, completion: nil)
    }
    
}
