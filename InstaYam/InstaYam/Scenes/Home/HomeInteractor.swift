//
//  HomeInteractor.swift
//  InstaYam

import UIKit

protocol HomeInteractorOutput: AnyObject {
    func getHome(request: HomeModels.GetHome.Request)
}

final class HomeInteractor: HomeInteractorOutput {
    var presenter: HomePresenterOutput!
    var worker = InstaYamWorker(store: InstaYamStore())
    
    // MARK: - Business logic
    
    func getHome(request: HomeModels.GetHome.Request) {
        worker.getHome { [weak self] result in
            switch result {
            case .success(let homeResponse):
                let response = HomeModels.GetHome.Response(result: .success(homeResponse))
                self?.presenter.presentHome(response: response)
            case .failure(let error):
                let response = HomeModels.GetHome.Response(result: .failure(error))
                self?.presenter.presentHome(response: response)
            }
        }
    }
}
