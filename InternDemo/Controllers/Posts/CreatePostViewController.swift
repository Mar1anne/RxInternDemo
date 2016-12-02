//
//  CreatePostViewController.swift
//  InternDemo
//
//  Created by WF | Mariana on 12/1/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit

class CreatePostViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    //MARK: View setup
    override func setupViews() {
        super.setupViews()
        
        addCloseButton()
        
        title = "Create post"
    }
    
    private func addCloseButton() {
        let image = UIImage(named: "cm_close_white")
        let barButton = UIBarButtonItem(image: image,
                                        style: .plain,
                                        target: self,
                                        action: #selector(onClose(barButton:)))
        navigationItem.setRightBarButton(barButton, animated: false)
    }
    
    //MARK: - Button Action
    func onClose(barButton: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}
