//
//  DescriptionTableViewCell.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 11/4/2565 BE.
//

import Foundation
import UIKit

class DescriptionTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var capttionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(feed: FeedData) {
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        let url = URL(string: feed.image)
        profileImage.downloadImage(from: url!)
        let string: NSMutableAttributedString = {
            let mutableString = NSMutableAttributedString(string: "\(feed.name) \(feed.captions)")

            mutableString.addAttribute(NSAttributedString.Key.font, value:UIFont.boldSystemFont(ofSize: 15), range: NSRange(location: 0, length: feed.name.count))
            return mutableString
        }()
        capttionLabel.attributedText = string
    }
}
