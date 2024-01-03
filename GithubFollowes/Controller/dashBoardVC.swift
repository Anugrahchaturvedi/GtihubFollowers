//
//  dashBoardVC.swift
//  GithubFollowes
//
//  Created by user on 02/01/24.
//

import UIKit

class dashBoardVC: UIViewController {
    enum Section {
        case main
    }
    
    var titleName: String?
    var followerList: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureViewController(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding:CGFloat = 12
        let minimumitemspacing: CGFloat = 10
        let availbWidth  = width - (2*padding) - minimumitemspacing*2
        let itemWidth = availbWidth/3
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.identifier , for: indexPath) as? FollowerCell
            cell?.setData(follower: follower)
            return cell
        })
    }
    
    func updateDate(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followerList)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
     
    }
    
    func getFollowers(){
        NetworkManager.shared.getfollowers(for: titleName!, page: 1) { [weak self] reponse in
            //handling memory leak
            guard let _self = self else { return }
            switch reponse {
            case .success(let followers):
                _self.followerList = followers
                _self.updateDate()
            case .failure(let error):
                _self.presentAlertOnMainThread(title: "Network Error", message: error.rawValue, buttontitle: "Ok")
            }
        }
    }
}
