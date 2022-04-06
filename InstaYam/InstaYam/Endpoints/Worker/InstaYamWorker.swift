//
//  InstaYamWorker.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 6/4/2565 BE.
//

import Foundation

protocol InstaYamStoreProtocol {
    func getHome(_ completion: @escaping (Result<HomeResponse, ErrorModel>) -> Void)
}

class InstaYamWorker {
    let store: InstaYamStoreProtocol
    init(store: InstaYamStoreProtocol) {
        self.store = store
    }
    
    func getHome(_ completion: @escaping (Result<HomeResponse, ErrorModel>) -> Void) {
        store.getHome(completion)
    }
}
