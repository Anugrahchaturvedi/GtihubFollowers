//
//  UserInfoVC.swift
//  GithubFollowes
//
//  Created by user on 04/01/24.
//

import UIKit

class UserInfoVC: UIViewController {

    var userName: String!
    override func viewDidLoad() {
        super.viewDidLoad()
        let doneBtn = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDoneBtn))
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = doneBtn
    }
    @objc func didTapDoneBtn(){
        dismiss(animated: true)
    }
}
