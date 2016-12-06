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

class CreatePostViewController: BaseViewController, CreatePostsView {

    private let imagePreview = UIImageView()
    private let titleBox = UITextView()
    private let uploadButton = UIButton()
    private let chooseImageButton = UIButton()
    
    private var presenter: CreatePostsPresenter?
    private var hasImage = Variable<Bool>(false)
    
    private var titleText: Observable<String?> {
        return titleBox
            .rx
            .text
            .throttle(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
    }
    
    init(withPresenter presenter: CreatePostsPresenter) {
        super.init()
        self.presenter = presenter
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        presenter?.detachView(self)
    }
    
    // MARK: View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addCloseButton()
        setupImagePicker()
        setupUploadButton()
        
        presenter?.attachView(self)
    }

    //MARK: View setup
    override func setupViews() {
        super.setupViews()
        
        title = "Create post"
        
        imagePreview.backgroundColor = UIColor(colorLiteralRed: 236/255, green: 240/255, blue: 241/255, alpha: 1)
        imagePreview.isUserInteractionEnabled = false
        
        titleBox.backgroundColor = UIColor(colorLiteralRed: 236/255, green: 240/255, blue: 241/255, alpha: 1)
        titleBox.layer.cornerRadius = 10
        titleBox.clipsToBounds = true
        titleBox.layer.borderColor = UIColor.gray.cgColor
        titleBox.layer.borderWidth = 0.5
        titleBox.font = UIFont.gothicRegularFontOfSize(size: 20)
        
        chooseImageButton.layer.cornerRadius = 15
        chooseImageButton.clipsToBounds = true
        chooseImageButton.backgroundColor = UIColor(colorLiteralRed: 66/255, green: 165/255, blue: 245/255, alpha: 1)
        chooseImageButton.setTitle("+", for: .normal)
        
        uploadButton.layer.cornerRadius = 20
        uploadButton.clipsToBounds = true
        uploadButton.backgroundColor = UIColor(colorLiteralRed: 66/255, green: 165/255, blue: 245/255, alpha: 1)
        uploadButton.setTitle("Upload image", for: .normal)
        uploadButton.isEnabled = false
        
        view.addSubview(imagePreview)
        view.addSubview(titleBox)
        view.addSubview(uploadButton)
        view.addSubview(chooseImageButton)
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
        
        chooseImageButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(30)
            make.bottom.right.equalTo(imagePreview).offset(-10)
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
        chooseImageButton.rx.tap
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
            .do(onNext: { (image) in
                self.hasImage.value = image != nil
            }, onError: nil, onCompleted: nil, onSubscribe: nil, onDispose:nil)
            .bindTo(imagePreview.rx.image)
            .addDisposableTo(disposeBag)
    }
    
    func setupUploadButton() {
        _ = Observable.combineLatest(titleText, hasImage.asObservable(), resultSelector: { (text, image) -> (Bool) in
            return (text != nil && text!.characters.count > 0 && image)
        }).do(onNext: { (result) in
            self.uploadButton.alpha = result ? 1 : 0.5
        }).bindTo(self.uploadButton.rx.isEnabled)
        
        uploadButton.rx.tap.subscribe(onNext: { (_) in
            self.presenter?.uploadImage(self.imagePreview.image!)
        }).addDisposableTo(disposeBag)
    }
    
    // MARK: CreatePostView
    func close() {
        dismiss(animated: true, completion: nil)
    }
}
