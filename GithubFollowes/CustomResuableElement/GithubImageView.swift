//
//  GithubImageView.swift
//  GithubFollowes
//
//  Created by user on 03/01/24.
//

import UIKit

class GithubImageView: UIImageView {
    let placeholderImage = UIImage(named: "avatar-placeholder")
    let cache = NetworkManager.shared.cache
    
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
    
    func downloadImage(url: String) {
        //if image is present in cache dont downlaod it
        //cache works like hashmap
        //key - Image URL, value - image
        
        let cachekey = NSString(string: url)
        if let image = cache.object(forKey: cachekey) {
            self.image = image
            return
        }
        let urlreq = URLRequest(url: URL(string:url)!)
        URLSession.shared.dataTask(with: urlreq) { [weak self] data, resp, error in
            guard let _self = self else {return}
            guard let data = data, error == nil else{
                return
            }
            guard let response = resp as? HTTPURLResponse, 200...299 ~= response.statusCode else {
                return
            }
            guard let image  = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                _self.image = image
            }
            _self.cache.setObject(image, forKey: cachekey)
        }.resume()
    }
}
