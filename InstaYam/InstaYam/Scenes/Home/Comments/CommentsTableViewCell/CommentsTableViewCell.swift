//
//  CommentsTableViewCell.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 11/4/2565 BE.
//

import Foundation
import UIKit
class CommentsTableViewCell: UITableViewCell {
    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
    
    private var comments: Comment!
    
    private let likeImage = UIImage(named: "heart_red")
    private let unlikeImage = UIImage(named: "heart")
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(comments: Comment, feed: FeedData) {
        self.comments = comments
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        let url = URL(string: feed.image)
        profileImage.downloadImage(from: url!)
        let string: NSMutableAttributedString = {
            let mutableString = NSMutableAttributedString(string: "\(comments.name) \(comments.text)")

            mutableString.addAttribute(NSAttributedString.Key.font, value:UIFont.boldSystemFont(ofSize: 15), range: NSRange(location: 0, length: comments.name.count))
            return mutableString
        }()
        commentLabel.attributedText = string
    }
    
    @IBAction private func didTapLikeButton() {
        likeButton.clickedAnimate()
        if comments.likes {
            likeButton.setImage(unlikeImage, for: .normal)
            comments.likes = false
        } else {
            likeButton.setImage(likeImage, for: .normal)
            comments.likes = true
        }
    }
}
