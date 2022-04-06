//
//  SearchRouter.swift
//  InstaYam

import UIKit

protocol SearchRouterInput: AnyObject {
    func createVC() -> UIViewController
}

final class SearchRouter: SearchRouterInput {
    weak var viewController: SearchViewController!

    // MARK: - Navigation

    func createVC() -> UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Search", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "SearchViewController")
        return vc
    }
}
