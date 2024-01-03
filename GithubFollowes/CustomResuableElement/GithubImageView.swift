//
//  GithubImageView.swift
//  GithubFollowes
//
//  Created by user on 03/01/24.
//

import UIKit

class GithubImageView: UIImageView {
    let placeholderImage = UIImage(named: "avatar-placeholder")
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleAspectFill
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
