//
//  UIViewController+Extension.swift
//  GithubFollowes
//
//  Created by user on 03/01/24.
//

import UIKit
extension UIViewController {
    
    func presentAlertOnMainThread(title: String, message: String, buttontitle: String){
        DispatchQueue.main.async {
            let alertVC = GithubAlert(alertTitle: title,message: message, buttonTitle: buttontitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}
