//
//  UIViewController+Extension.swift
//  GithubFollowes
//
//  Created by user on 03/01/24.
//

import UIKit

fileprivate var containerview: UIView!
extension UIViewController {
    
    func presentAlertOnMainThread(title: String, message: String, buttontitle: String){
        DispatchQueue.main.async {
            let alertVC = GithubAlert(alertTitle: title,message: message, buttonTitle: buttontitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    //activity indicator
    func showLoadingView(){
        containerview = UIView(frame: view.bounds)
        containerview.backgroundColor = .systemBackground
        containerview.alpha =  0
        UIView.animate(withDuration: 0.25) {
            containerview.alpha = 0.8
        }
        view.addSubview(containerview)
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerview.addSubview(activityIndicator)
        containerview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        DispatchQueue.main.async {
            containerview.removeFromSuperview()
            containerview = nil
        }
    }
    
    func emptyStateView(with message: String, in view: UIView){
        let emptyStateView = GithubEmptyStateView(meassge: message)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
}
