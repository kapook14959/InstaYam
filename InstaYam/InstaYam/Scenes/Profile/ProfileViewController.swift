//
//  ProfileViewController.swift
//  InstaYam

import UIKit

protocol ProfileViewControllerOutput: AnyObject {
}

final class ProfileViewController: UIViewController {
    var interactor: ProfileInteractorOutput!
    var router: ProfileRouterInput!

    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        let router = ProfileRouter()
        router.viewController = self

        let presenter = ProfilePresenter()
        presenter.viewController = self

        let interactor = ProfileInteractor()
        interactor.presenter = presenter

        self.interactor = interactor
        self.router = router
        setupTabBar()
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - SetupViews
    private func setupTabBar() {
        let unSelected = UIImage(named: "profile")
        let selected = UIImage(named: "profile_selected")
        tabBarItem = UITabBarItem(title: nil,
                                  image: unSelected,
                                  selectedImage: selected)
        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
    }
    // MARK: - Event handling

    // MARK: - Actions
    
    // MARK: - Private func
}

// MARK: - Display logic

extension ProfileViewController: ProfileViewControllerOutput {
    
}

// MARK: - Start Any Extensions
