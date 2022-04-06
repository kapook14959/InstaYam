//
//  ReelsViewController.swift
//  InstaYam

import UIKit

protocol ReelsViewControllerOutput: AnyObject {
}

final class ReelsViewController: UIViewController {
    var interactor: ReelsInteractorOutput!
    var router: ReelsRouterInput!

    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        let router = ReelsRouter()
        router.viewController = self

        let presenter = ReelsPresenter()
        presenter.viewController = self

        let interactor = ReelsInteractor()
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
        let unSelected = UIImage(named: "reels")
        let selected = UIImage(named: "reels_selected")
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

extension ReelsViewController: ReelsViewControllerOutput {
    
}

// MARK: - Start Any Extensions
