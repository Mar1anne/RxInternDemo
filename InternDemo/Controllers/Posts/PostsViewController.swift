//
//  PostsViewController.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/22/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxSwift

class PostsViewController: BaseViewController, PostsView {

    private var collectionView: UICollectionView!
    
    private var presenter: PostsPresenter!
    private let disposeBag = DisposeBag()
    
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
        
        addMenuButton()
        
        view.backgroundColor = .white
        navigationController?.navigationBar.isTranslucent = false

        let layout = UICollectionViewFlowLayout()
        let itemWidth = (Constants.UI.screenWidth - 30)/2

        layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 50)
            
        collectionView = UICollectionView(frame: CGRect.zero,
                                          collectionViewLayout: layout)
        collectionView.register(PostCollectionViewCell.self,
                                forCellWithReuseIdentifier: PostCollectionViewCell.cellIdentifier)
        collectionView.backgroundColor = .white

        view.addSubview(collectionView)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
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
    
    // MARK: - PostsView method
    func bindPosts(_ posts: Observable<[Post]>?) {
        posts?.bindTo(collectionView.rx.items(cellIdentifier: PostCollectionViewCell.cellIdentifier,
                                              cellType: PostCollectionViewCell.self)) { (row, element, cell) in
            
        }.addDisposableTo(disposeBag)
    }
    
    func showLoading(_ show: Bool) {
        view.isLoading = show
    }
    
    func titleUpdated(_ title: String) {
        self.title = title
    }
}
