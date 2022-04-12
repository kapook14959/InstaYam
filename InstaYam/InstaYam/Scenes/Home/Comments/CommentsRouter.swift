//
//  CommentsRouter.swift
//  InstaYam

import UIKit

protocol CommentsRouterInput: AnyObject {
    func createVC() -> UIViewController
}

final class CommentsRouter: CommentsRouterInput {
    weak var viewController: CommentsViewController!

    // MARK: - Navigation

    func createVC() -> UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Comments", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "CommentsViewController")
        return vc
    }
}
