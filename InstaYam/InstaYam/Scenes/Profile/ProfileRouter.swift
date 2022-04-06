//
//  ProfileRouter.swift
//  InstaYam

import UIKit

protocol ProfileRouterInput: AnyObject {
    func createVC() -> UIViewController
}

final class ProfileRouter: ProfileRouterInput {
    weak var viewController: ProfileViewController!

    // MARK: - Navigation

    func createVC() -> UIViewController {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController")
        return vc
    }
}
