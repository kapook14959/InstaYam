//
//  HomeRouter.swift
//  InstaYam

import UIKit

protocol HomeRouterInput: AnyObject {
    func createVC() -> UIViewController
}

final class HomeRouter: HomeRouterInput {
    weak var viewController: HomeViewController!

    // MARK: - Navigation

    func createVC() -> UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")
        return vc
    }
}
