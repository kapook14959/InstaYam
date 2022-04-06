//
//  SearchViewController.swift
//  InstaYam

import UIKit

protocol SearchViewControllerOutput: AnyObject {
}

final class SearchViewController: UIViewController {
    var interactor: SearchInteractorOutput!
    var router: SearchRouterInput!

    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        let router = SearchRouter()
        router.viewController = self

        let presenter = SearchPresenter()
        presenter.viewController = self

        let interactor = SearchInteractor()
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
        let unSelected = UIImage(named: "search")
        let selected = UIImage(named: "search_selected")
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

extension SearchViewController: SearchViewControllerOutput {
    
}

// MARK: - Start Any Extensions
