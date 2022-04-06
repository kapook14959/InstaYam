//
//  TabBarsViewController.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 6/4/2565 BE.
//

import UIKit

class TabBarsViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.backgroundColor = .white
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.systemGray5.cgColor
        tabBar.unselectedItemTintColor = .black
        let vcs = [HomeRouter().createVC(),
                   SearchRouter().createVC(),
                   ReelsRouter().createVC(),
                   MarketRouter().createVC(),
                   ProfileRouter().createVC()]
        setViewControllers(vcs, animated: true)
    }
}
