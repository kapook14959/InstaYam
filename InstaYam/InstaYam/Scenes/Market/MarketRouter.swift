//
//  MarketRouter.swift
//  InstaYam

import UIKit

protocol MarketRouterInput: AnyObject {
    func createVC() -> UIViewController
}

final class MarketRouter: MarketRouterInput {
    weak var viewController: MarketViewController!

    // MARK: - Navigation

    func createVC() -> UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Market", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "MarketViewController")
        return vc
    }
}
