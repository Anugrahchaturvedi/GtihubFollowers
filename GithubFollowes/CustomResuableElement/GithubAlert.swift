//
//  GithubAlert.swift
//  GithubFollowes
//
//  Created by user on 03/01/24.
//

import UIKit

class GithubAlert: UIViewController {

    let containerView = UIView()
    let titleLabel = GithubLabel(textAligment: .center, fontSize: 25)
    let bodyLabel = GithubBodylabel(textAligment: .center)
    let actionButton = GithubButton(backgroundColor: .red, title: "Ok")
    var alertTitle : String?
    var message: String?
    var buttonTitle: String?
    let padding: CGFloat  = 20
    init(alertTitle: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContainer()
        configureTitleLable()
        configureButton()
        configureBodyLabel()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    }
    
    private func configureContainer(){
        view.addSubview(containerView)
        containerView.layer.cornerRadius = 15
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.layer.borderWidth = 2
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = .systemBackground
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 210),
        ])
    }
    
    private func configureTitleLable(){
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle ?? "Something Went Wrong"
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
    }
    
    private func configureButton(){
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureBodyLabel(){
        containerView.addSubview(bodyLabel)
        bodyLabel.text = message
        bodyLabel.numberOfLines = 4
        NSLayoutConstraint.activate([
            bodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: padding),
            bodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,constant: -padding),
            bodyLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor,constant: -12),
            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8)
        ])
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
