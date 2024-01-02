//
//  dashBoardVC.swift
//  GithubFollowes
//
//  Created by user on 02/01/24.
//

import UIKit

class dashBoardVC: UIViewController {
    var titleName: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
