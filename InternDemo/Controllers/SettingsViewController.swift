//
//  SettingsViewController.swift
//  InternDemo
//
//  Created by WF | Mariana on 12/1/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit

class SettingsViewController: BaseViewController {

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: - View setup
    override func setupViews() {
        super.setupViews()
        
        addMenuButton()
        title = "Settings"
    }
}
