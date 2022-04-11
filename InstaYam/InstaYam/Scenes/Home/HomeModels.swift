//
//  HomeModels.swift
//  InstaYam

import UIKit

struct HomeModels {
    struct GetHome {
        struct Request {
            
        }
        
        struct Response {
            let result: (Result<HomeResponse,Error>)
        }
        
        struct ViewModel {
            let result: (Result<[HomeResponseTypes],Error>)
        }
    }
    
    enum HomeResponseTypes {
        case story([Story])
        case feed([FeedData])
    }
}

struct FeedData: Codable {
    let image: String
    let name, location: String
    let photos: [String]?
    let videos: String?
    let amountLikes, captions: String
    let comments: [Comment]?
    var isLike: Bool
    
    init(image: String,
         name: String,
         location: String,
         photos: [String]?,
         videos: String?,
         amountLikes: String,
         captions: String,
         comments: [Comment]?,
         isLike: Bool) {
        self.image = image
        self.name = name
        self.location = location
        self.photos = photos
        self.videos = videos
        self.amountLikes = amountLikes
        self.captions = captions
        self.comments = comments
        self.isLike = isLike
    }
}
