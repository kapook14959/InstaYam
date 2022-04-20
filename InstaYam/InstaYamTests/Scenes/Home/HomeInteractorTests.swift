//
//  HomeInteractorTests.swift
//  InstaYamTests
//
//  Created by Supakorn Siripisitwong on 17/4/2565 BE.
//

import XCTest
@testable import InstaYam

class HomeInteractorTests: XCTestCase {
    private var interactor: HomeInteractor!
    private var presenterSpy: HomePresenterSpy!
    private var workerSpy: InstaYamWorkerSpy!

    override func setUp() {
        super.setUp()
        setupHomeInteractorTests()
    }
    
    override func tearDown() {
        super.tearDown()
        tearDownHomeInteractorTests()
    }
    
    private func setupHomeInteractorTests() {
        interactor = HomeInteractor()
        presenterSpy = HomePresenterSpy()
        interactor.presenter = presenterSpy
        workerSpy = InstaYamWorkerSpy(store: InstaYamStoreMock())
        interactor.worker = workerSpy
    }
    
    private func tearDownHomeInteractorTests() {
        interactor = nil
        presenterSpy = nil
        workerSpy = nil
    }
    
    // MARK: - Spy
    
    final class HomePresenterSpy: HomePresenterOutput {
        var presentHomeCalled = false
        var presentHomeResponse: HomeModels.GetHome.Response?
        
        func presentHome(response: HomeModels.GetHome.Response) {
            presentHomeCalled = true
            presentHomeResponse = response
        }
    }
    
    final class InstaYamWorkerSpy: InstaYamWorker {
        var getHomeCalled = false
        var forceError = false
        
        let errorModel = ErrorModel(title: "Error", description: "Error")
        
        override func getHome(_ completion: @escaping (Result<HomeResponse, ErrorModel>) -> Void) {
            getHomeCalled = true
            if forceError {
                completion(.failure(errorModel))
            } else {
                super.getHome(completion)
            }
        }
    }
    
    final class InstaYamStoreMock: InstaYamStoreProtocol {
        func getHome(_ completion: @escaping (Result<HomeResponse, ErrorModel>) -> Void) {
            let feed = Feed(image: "imagePath", name: "name", location: "location", photos: nil, videos: nil, amountLikes: "100,000 Likes", captions: "captions", comments: nil)
            let feeds = [feed, feed]
            let story = Story(image: "imagePath", name: "name", read: false, sortOrder: 1)
            let stories = [story, story]
            let homeResponse = HomeResponse(stories: stories, feed: feeds)
            completion(.success(homeResponse))
        }
    }
    
    // MARK: - Tests
    
    func testGetHomeSuccess() {
        // Given
        let request = HomeModels.GetHome.Request()
        
        // When
        interactor.getHome(request: request)
        
        // Then
        XCTAssertTrue(presenterSpy.presentHomeCalled, "presentHome isn't called")
        XCTAssertTrue(workerSpy.getHomeCalled, "getHome isn't called")
        if let result = presenterSpy.presentHomeResponse?.result {
            switch result {
            case .success(let homeResponse):
                XCTAssertEqual(homeResponse.stories.first?.image ?? "", "imagePath")
            default:
                XCTFail("Your response is failed")
            }
        } else {
            XCTFail("Result is nil")
        }
    }
    
    func testGetHomeFailed() {
        // Given
        let request = HomeModels.GetHome.Request()
        workerSpy.forceError = true
        
        // When
        interactor.getHome(request: request)
        
        // Then
        XCTAssertTrue(presenterSpy.presentHomeCalled, "presentHome isn't called")
        XCTAssertTrue(workerSpy.getHomeCalled, "getHome isn't called")
        if let result = presenterSpy.presentHomeResponse?.result {
            switch result {
            case .failure(let error):
                if let errorModel = error as? ErrorModel {
                    XCTAssertEqual(errorModel.title, workerSpy.errorModel.title)
                    XCTAssertEqual(errorModel.description, workerSpy.errorModel.description)
                } else {
                    XCTFail("errorModel is not ErrorModel")
                }
            default:
                XCTFail("Your response is success")
            }
        } else {
            XCTFail("Result is nil")
        }
    }
}
