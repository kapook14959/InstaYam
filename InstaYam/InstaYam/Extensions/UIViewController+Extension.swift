//
//  UIViewController+Extension.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 6/4/2565 BE.
//

import UIKit
extension UIViewController {
    func presentAlert(title: String, description: String, buttonName: String) {
        let alert = UIAlertController(title: title, message: description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonName, style: .default))
        present(alert, animated: true)
    }
}
