//
//  SearchVC.swift
//  GithubFollowes
//
//  Created by user on 02/01/24.
//

import UIKit

class SearchVC: UIViewController {

    let logoImage = UIImageView()
    let userNameField = GithubTextfield()
    let getFollowerBtn = GithubButton(backgroundColor: .systemGreen, title: "Get Followers")
    var isUserNameEntered: Bool {
        return !userNameField.text!.isEmpty
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureLogoImage()
        configureTextField()
        configureButton()
        createDismissKeybaordTapGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func createDismissKeybaordTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    
    func configureLogoImage(){
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        logoImage.image = UIImage(named: "gh-logo")
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.heightAnchor.constraint(equalToConstant: 200),
            logoImage.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    
    func configureTextField(){
        view.addSubview(userNameField)
        userNameField.delegate = self
        NSLayoutConstraint.activate([
            userNameField.topAnchor.constraint(equalTo: logoImage.bottomAnchor,constant: 49),
            userNameField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            userNameField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            userNameField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    func configureButton(){
        view.addSubview(getFollowerBtn)
        getFollowerBtn.addTarget(self, action: #selector(didTapFollowersBtn), for: .touchUpInside)
        NSLayoutConstraint.activate([
            getFollowerBtn.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            getFollowerBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            getFollowerBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            getFollowerBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    @objc func didTapFollowersBtn(){
        guard isUserNameEntered else {
           presentAlertOnMainThread(title: "Empty Username", message: "We need to know Github username to get the info of the User", buttontitle: "OK")
            return
        }
        let vc = dashBoardVC()
        vc.title = userNameField.text
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("did Tap Return")
        return true
    }
}
