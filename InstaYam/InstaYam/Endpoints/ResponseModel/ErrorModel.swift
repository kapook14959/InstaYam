//
//  ErrorModel.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 6/4/2565 BE.
//

import UIKit

struct ErrorModel: Error, Codable {
    let title: String
    let description: String
    
    init(title: String, description: String) {
        self.title = title
        self.description = description
    }
}
