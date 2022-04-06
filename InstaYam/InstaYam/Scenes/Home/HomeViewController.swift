//
//  HomeViewController.swift
//  InstaYam

import UIKit

protocol HomeViewControllerOutput: AnyObject {
    func displayHome(viewModel: HomeModels.GetHome.ViewModel)
}

final class HomeViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    
    var interactor: HomeInteractorOutput!
    var router: HomeRouterInput!
    
    private var data: [HomeModels.HomeResponseTypes]?
    private let refreshControl = UIRefreshControl()

    // MARK: - Object lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        let router = HomeRouter()
        router.viewController = self

        let presenter = HomePresenter()
        presenter.viewController = self

        let interactor = HomeInteractor()
        interactor.presenter = presenter

        self.interactor = interactor
        self.router = router
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
        setupTableView()
        setupRefreshControl()
        interactor.getHome(request: HomeModels.GetHome.Request())
    }
    
    // MARK: - SetupViews
    
    private func setupTabBar() {
        let unSelected = UIImage(named: "home")
        let selected = UIImage(named: "home_selected")
        tabBarItem = UITabBarItem(title: nil,
                                  image: unSelected,
                                  selectedImage: selected)
        tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        tabBarController?.selectedIndex = 0
    }
    
    private func setupTableView() {
        let storyNib = UINib(nibName: "StoryTableViewCell", bundle: nil)
        let feedNib = UINib(nibName: "FeedTableViewCell", bundle: nil)
        tableView.register(storyNib, forCellReuseIdentifier: "StoryCell")
        tableView.register(feedNib, forCellReuseIdentifier: "FeedCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupRefreshControl() {
        refreshControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
        tableView.addSubview(refreshControl)
    }

    // MARK: - Event handling
    
    @objc private func didPullToRefresh() {
        interactor.getHome(request: HomeModels.GetHome.Request())
    }
    
    // MARK: - Actions
    
    @IBAction private func didTapInstagramButton() {
        
    }
    
    // MARK: - Private func
}

// MARK: - Display logic

extension HomeViewController: HomeViewControllerOutput {
    func displayHome(viewModel: HomeModels.GetHome.ViewModel) {
        refreshControl.endRefreshing()
        tableView.setContentOffset(.zero, animated: true)
        switch viewModel.result {
        case .success(let homeResponse):
            data = homeResponse
            tableView.reloadData()
        case .failure(let error):
            if let errorModel = error as? ErrorModel {
                presentAlert(title: errorModel.title, description: errorModel.description, buttonName: "OK")
            }
        }
    }
}

// MARK: - Start Any Extensions

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let data = data?[indexPath.row] else { return UITableViewCell() }
        
        switch data {
        case .story:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "StoryCell", for: indexPath) as? StoryTableViewCell else { return UITableViewCell() }
            return cell
        case .feed:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedCell", for: indexPath) as? FeedTableViewCell else { return UITableViewCell() }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let data = data?[indexPath.row] else { return 0 }
        
        switch data {
        case .story:
            return 100
        case .feed:
            return 1000
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
