//
//  BaseViewController.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/22/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    func setupViews() {
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false
    }
    
    func setupConstraints() {
        
    }
    
    func addMenuButton() {
        let image = UIImage(named: "cm_menu_white")
        let barButton = UIBarButtonItem(image: image,
                                        style: .plain,
                                        target: self,
                                        action: #selector(onMenu(barButton:)))
        navigationItem.setLeftBarButton(barButton, animated: false)
    }
    
    // MARK: Button actions
    func onMenu(barButton: UIBarButtonItem) {
        evo_drawerController?.toggleLeftDrawerSide(animated: true, completion: nil)
    }
}
