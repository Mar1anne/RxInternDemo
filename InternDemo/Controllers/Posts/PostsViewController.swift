//
//  PostsViewController.swift
//  InternDemo
//
//  Created by WF | Mariana on 11/22/16.
//  Copyright © 2016 WF | Mariana. All rights reserved.
//

import UIKit
import RxSwift
import ESPullToRefresh
import RxCocoa

class PostsViewController: BaseViewController, PostsView {

    private var collectionView: UICollectionView!
    private var newPostButton: UIButton!
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
        
        addMenuButton()
        
        newPostButton = UIButton()
        newPostButton.layer.cornerRadius = 40
        newPostButton.clipsToBounds = true
        newPostButton.setTitle("+", for: .normal)
        newPostButton.titleLabel?.font = UIFont.gothicBoldFontOfSize(size: 35)
        newPostButton.backgroundColor = UIColor(colorLiteralRed: 66/255, green: 165/255, blue: 245/255, alpha: 1)
        
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

        _ = collectionView.es_addPullToRefresh { [weak self] in
            self?.presenter.loadPosts()
        }
        
        _ = collectionView.es_addInfiniteScrolling { [weak self] in
             self?.presenter.loadMorePosts()
        }
        
        newPostButton.rx.tap
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe { [weak self] _ in
                self?.onNewPost()
            }
            .addDisposableTo(disposeBag)
        
        view.addSubview(collectionView)
        view.addSubview(newPostButton)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
        
        newPostButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(80)
            make.right.bottom.equalTo(view).offset(-35)
        }
    }
    
    //MARK: - Button Action
    func onNewPost() {
        let postController = CreatePostViewController(withPresenter: CreatePostsPresenterImpl())
        let navController = UINavigationController(rootViewController: postController)
        
        evo_drawerController?.present(navController, animated: true, completion: nil)
    }
    
    // MARK: - PostsView method
    func bindPosts(_ posts: Observable<[Post]>?) {
        posts?.bindTo(collectionView.rx.items(cellIdentifier: PostCollectionViewCell.cellIdentifier,
                                              cellType: PostCollectionViewCell.self)) { (row, element, cell) in
            cell.post = element
        }.addDisposableTo(disposeBag)
    }
    
    func showLoading(_ show: Bool) {
        view.isLoading = show
        collectionView.es_stopPullToRefresh(completion: true)
        collectionView.es_stopLoadingMore()
    }
    
    func titleUpdated(_ title: String) {
        self.title = title
    }
}
