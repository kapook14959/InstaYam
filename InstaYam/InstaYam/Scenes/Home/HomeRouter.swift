//
//  HomeRouter.swift
//  InstaYam

import UIKit

protocol HomeRouterInput: AnyObject {
    func createVC() -> UIViewController
    func navigateToComments(index: Int, comments: [Comment], feed: FeedData)
}

final class HomeRouter: HomeRouterInput {
    weak var viewController: HomeViewController!

    // MARK: - Navigation

    func createVC() -> UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "HomeViewController")
        return vc
    }
    
    func navigateToComments(index: Int, comments: [Comment], feed: FeedData) {
        guard let commentsVC = CommentsRouter().createVC() as? CommentsViewController else { return }
        commentsVC.interactor.comments = comments
        commentsVC.interactor.index = index
        commentsVC.interactor.feed = feed
        commentsVC.hidesBottomBarWhenPushed = true
        viewController.navigationController?.pushViewController(commentsVC, animated: true)
    }
}
