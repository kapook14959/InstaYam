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
        case feed([Feed])
    }
}
