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
        
    }
    
    func setupConstraints() {
        
    }
}
