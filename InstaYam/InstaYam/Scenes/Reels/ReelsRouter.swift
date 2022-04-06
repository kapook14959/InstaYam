//
//  ReelsRouter.swift
//  InstaYam

import UIKit

protocol ReelsRouterInput: AnyObject {
    func createVC() -> UIViewController
}

final class ReelsRouter: ReelsRouterInput {
    weak var viewController: ReelsViewController!

    // MARK: - Navigation

    func createVC() -> UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Reels", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ReelsViewController")
        return vc
    }
}
