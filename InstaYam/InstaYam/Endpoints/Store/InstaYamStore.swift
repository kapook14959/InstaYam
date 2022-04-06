//
//  InstaYamStore.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 6/4/2565 BE.
//

import Foundation
class InstaYamStore: InstaYamStoreProtocol {
    enum Endpoints: String {
        case home = "/home"
    }
    
    var baseUrl = "https://instagram-mock-hosting.herokuapp.com"
    
    func getHome(_ completion: @escaping (Result<HomeResponse, ErrorModel>) -> Void) {
        let homeUrl = "\(baseUrl)\(Endpoints.home.rawValue)"
        let url = URL(string: homeUrl)
        let request = URLRequest(url: url!)
        let errorModel = ErrorModel(title: "Error", description: "Our service is down, please try again later.")
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let dataValid = data {
                do {
                    let json = try JSONDecoder().decode(HomeResponse.self, from: dataValid)
                    DispatchQueue.main.async {
                        completion(.success(json))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(errorModel))
                    }
                }
            } else {
                DispatchQueue.main.async {
                    completion(.failure(errorModel))
                }
            }
        }.resume()
    }
}
