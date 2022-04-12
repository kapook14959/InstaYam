//
//  CommentsInteractor.swift
//  InstaYam

import UIKit

protocol CommentsInteractorOutput: AnyObject {
    var comments: [Comment]! {get set}
    var index: Int! {get set}
    var feed: FeedData! {get set}
}

final class CommentsInteractor: CommentsInteractorOutput {
    var comments: [Comment]!
    var index: Int!
    var feed: FeedData!
    
    var presenter: CommentsPresenterOutput!
    // MARK: - Business logic

}
