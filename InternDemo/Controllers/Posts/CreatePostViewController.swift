//
//  CreatePostViewController.swift
//  InternDemo
//
//  Created by WF | Mariana on 12/1/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

class CreatePostViewController: BaseViewController {

    private let imagePreview = UIImageView()
    private let titleBox = UITextView()
    private let uploadButton = UIButton()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addCloseButton()
        setupImagePicker()
    }

    //MARK: View setup
    override func setupViews() {
        super.setupViews()
        
        title = "Create post"
        
        imagePreview.backgroundColor = UIColor(colorLiteralRed: 236/255, green: 240/255, blue: 241/255, alpha: 1)
        
        titleBox.backgroundColor = UIColor(colorLiteralRed: 236/255, green: 240/255, blue: 241/255, alpha: 1)
        titleBox.layer.cornerRadius = 10
        titleBox.clipsToBounds = true
        titleBox.layer.borderColor = UIColor.gray.cgColor
        titleBox.layer.borderWidth = 0.5
        titleBox.font = UIFont.gothicRegularFontOfSize(size: 20)
        
        uploadButton.layer.cornerRadius = 20
        uploadButton.clipsToBounds = true
        uploadButton.backgroundColor = UIColor(colorLiteralRed: 66/255, green: 165/255, blue: 245/255, alpha: 1)
        uploadButton.setTitle("Upload image", for: .normal)
        
        view.addSubview(imagePreview)
        view.addSubview(titleBox)
        view.addSubview(uploadButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        imagePreview.snp.makeConstraints { (make) in
            make.width.height.equalTo(view.snp.width).multipliedBy(0.8)
            make.top.equalTo(view).offset(20)
            make.centerX.equalTo(view)
        }
        
        uploadButton.snp.makeConstraints { (make) in
            make.width.equalTo(view.snp.width).multipliedBy(0.6)
            make.centerX.equalTo(view)
            make.height.equalTo(40)
            make.bottom.equalTo(view).offset(-20)
        }
        
        titleBox.snp.makeConstraints { (make) in
            make.width.centerX.equalTo(imagePreview)
            make.top.equalTo(imagePreview.snp.bottom).offset(20)
            make.bottom.equalTo(uploadButton.snp.top).offset(-20)
        }
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
    
    //MARK: - Rx Setup
    func setupImagePicker() {
        
        uploadButton.rx.tap
            .flatMapLatest { [weak self] _ in
                return UIImagePickerController.rx.createWithParent(self) { picker in
                    picker.sourceType = .photoLibrary
                    picker.allowsEditing = false
                    }
                    .flatMap {
                        $0.rx.didFinishPickingMediaWithInfo
                    }
                    .take(1)
            }
            .map { info in
                return info[UIImagePickerControllerOriginalImage] as? UIImage
            }
            .bindTo(imagePreview.rx.image)
            .addDisposableTo(disposeBag)
    }
}
