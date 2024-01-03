//
//  FollowerCell.swift
//  GithubFollowes
//
//  Created by user on 03/01/24.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let identifier = "FollowerCell"
    let avatarImage = GithubImageView(frame: .zero)
    let userlabel = GithubLabel(textAligment: .center, fontSize: 18)
    let padding: CGFloat  = 8
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setData(follower: Follower){
        userlabel.text = follower.login
        avatarImage.downloadImage(url: follower.avatarUrl ?? "")
    }

    private func configure(){
        addSubview(avatarImage)
        addSubview(userlabel)
        NSLayoutConstraint.activate([
            avatarImage.topAnchor.constraint(equalTo: topAnchor,constant: padding),
            avatarImage.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding),
            avatarImage.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding),
            avatarImage.heightAnchor.constraint(equalTo: avatarImage.widthAnchor),
            
            userlabel.topAnchor.constraint(equalTo: avatarImage.bottomAnchor,constant: 12),
            userlabel.leadingAnchor.constraint(equalTo: leadingAnchor,constant: padding),
            userlabel.trailingAnchor.constraint(equalTo: trailingAnchor,constant: -padding),
            userlabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
