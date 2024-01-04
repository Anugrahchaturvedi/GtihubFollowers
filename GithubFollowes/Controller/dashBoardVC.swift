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
    var page = 1
    var hasMoreFollower = true
    var followerList: [Follower] = []
    var filterFollowers: [Follower] = []
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Follower>!
    var isSearching = false
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: titleName!, page: page)
        configureDataSource()
    }
    
    func configureCollectionView(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureSearchController()
//        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.isNavigationBarHidden = false
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
    
    func updateData(on followers: [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,animatingDifferences: true)
        }
     
    }
    
    func configureSearchController(){
        let searchBar = UISearchController()
        searchBar.searchResultsUpdater = self
        searchBar.searchBar.delegate = self
        searchBar.searchBar.placeholder = "Search Username"
        navigationItem.searchController = searchBar
    }
    
    func getFollowers(username: String, page: Int){
        showLoadingView()
        
        NetworkManager.shared.getfollowers(for: titleName!, page: page) { [weak self] reponse in
            //handling memory leak
            guard let _self = self else { return }
            _self.dismissLoadingView()
            switch reponse {
            case .success(let followers):
                if followers.count < 100 {
                    _self.hasMoreFollower = false
                }
                _self.followerList.append(contentsOf: followers)
                
                if _self.followerList.isEmpty {
                    DispatchQueue.main.async {
                    _self.emptyStateView(with: "This User doesnt have Any Followers Go Follow the Person", in: _self.view)
                    }
                    return
                }
                _self.updateData(on: _self.followerList)
            case .failure(let error):
                _self.presentAlertOnMainThread(title: "Network Error", message: error.rawValue, buttontitle: "Ok")
            }
        }
    }
}
extension dashBoardVC: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let contentOffSet = scrollView.contentOffset.y
        let scrollHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if contentOffSet > scrollHeight - height{
            if hasMoreFollower == true {
                page += 1
                getFollowers(username: titleName!, page: page)
                
            }
            else {
                return
            }
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let activeArray = isSearching ? filterFollowers : followerList
        let follower = activeArray[indexPath.item]
        let userInfovc = UserInfoVC()
        userInfovc.userName = follower.login
        let navController = UINavigationController(rootViewController: userInfovc)
        let destinationVC = navController
        present(destinationVC,animated: true)
    }
}

extension dashBoardVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {return}
        isSearching = true
        filterFollowers = followerList.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filterFollowers)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followerList)
    }
    
}
