//
//  MarketViewController.swift
//  InstaYam

import UIKit

protocol MarketViewControllerOutput: AnyObject {
}

final class MarketViewController: UIViewController {
    var interactor: MarketInteractorOutput!
    var router: MarketRouterInput!

    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        let router = MarketRouter()
        router.viewController = self

        let presenter = MarketPresenter()
        presenter.viewController = self

        let interactor = MarketInteractor()
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
        let unSelected = UIImage(named: "shop")
        let selected = UIImage(named: "shop_selected")
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

extension MarketViewController: MarketViewControllerOutput {
    
}

// MARK: - Start Any Extensions
