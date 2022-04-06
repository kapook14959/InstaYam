//
//  HomePresenter.swift
//  InstaYam

import UIKit

protocol HomePresenterOutput: AnyObject {
    func presentHome(response: HomeModels.GetHome.Response)
}

final class HomePresenter: HomePresenterOutput {
    weak var viewController: HomeViewControllerOutput?

    // MARK: - Presentation logic

    func presentHome(response: HomeModels.GetHome.Response) {
        switch response.result {
        case .success(let homeResponse):
            let story = HomeModels.HomeResponseTypes.story(homeResponse.stories)
            let feed = HomeModels.HomeResponseTypes.feed(homeResponse.feed)
            let homeTypes = [story, feed]
            let viewModel = HomeModels.GetHome.ViewModel(result: .success(homeTypes))
            viewController?.displayHome(viewModel: viewModel)
        case .failure(let error):
            viewController?.displayHome(viewModel: .init(result: .failure(error)))
        }
    }
}
