//
//  GithubEmptyStateView.swift
//  GithubFollowes
//
//  Created by user on 04/01/24.
//

import UIKit

class GithubEmptyStateView: UIView {
    
    let messageLbl = GithubLabel(textAligment: .center, fontSize: 18)
    let emptyimage = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(meassge: String) {
        super.init(frame: .zero)
        messageLbl.text = meassge
        configure()
    }
    
    func configure() {
        addSubview(messageLbl)
        addSubview(emptyimage)
        messageLbl.textColor = .secondaryLabel
        messageLbl.numberOfLines = 2
        emptyimage.image = UIImage(named: "empty-state-logo")
        emptyimage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            messageLbl.centerYAnchor.constraint(equalTo: self.centerYAnchor,constant: -150),
            messageLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 40),
            messageLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -40),
            messageLbl.heightAnchor.constraint(equalToConstant: 40),
            emptyimage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyimage.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyimage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170),
            emptyimage.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: 40)
            
        ])
    }
}
