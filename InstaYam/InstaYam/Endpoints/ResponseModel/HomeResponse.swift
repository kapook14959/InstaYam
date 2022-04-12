//
//  HomeResponse.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 6/4/2565 BE.
//

import Foundation

// MARK: - HomeResponse
struct HomeResponse: Codable {
    let stories: [Story]
    let feed: [Feed]
}

// MARK: - Feed
struct Feed: Codable {
    let image: String
    let name, location: String
    let photos: [String]?
    let videos: String?
    let amountLikes, captions: String
    let comments: [Comment]?
    
    enum CodingKeys: String, CodingKey {
        case image, name, location, photos, videos
        case amountLikes = "amount_likes"
        case captions, comments
    }
}

// MARK: - Comment
struct Comment: Codable {
    let name, text: String
    var likes: Bool
}

// MARK: - Story
struct Story: Codable {
    let image: String
    let name: String
    let read: Bool
    let sortOrder: Int
}
