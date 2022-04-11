//
//  FeedContentTableViewCell.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 11/4/2565 BE.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

protocol FeedContentTableViewCellDelegate: AnyObject {
    func didTapLikeButton(index: Int, isLike: Bool)
}

class FeedContentTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var feedImage: UIImageView!
    @IBOutlet private weak var circularView: CircularView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var locationLabel: UILabel!
    @IBOutlet private weak var videoView: UIView!
    @IBOutlet private weak var contentImage: UIImageView!
    @IBOutlet private weak var likeLabel: UILabel!
    @IBOutlet private weak var captionLabel: UILabel!
    @IBOutlet private weak var commentLabel: UILabel!
    @IBOutlet private weak var likeButton: UIButton!
        
    private let likeImage = UIImage(named: "heart_red")
    private let unlikeImage = UIImage(named: "heart")
    private var feed: FeedData!
    weak var delegate: FeedContentTableViewCellDelegate?
    
    func updateUI(feed: FeedData) {
        self.feed = feed
        feedImage.layer.cornerRadius = feedImage.frame.height / 2
        circularView.progressAnimation()
        let url = URL(string: feed.image)
        
        feedImage.downloadImage(from: url!)
        nameLabel.text = feed.name
        locationLabel.text = feed.location
        if feed.location.isEmpty {
            locationLabel.isHidden = true
        } else {
            locationLabel.isHidden = false
        }
        
        if let photos = feed.photos {
            videoView.isHidden = true
            contentImage.isHidden = false
            let urlContentImage = URL(string: photos[0])
            contentImage.downloadImage(from: urlContentImage!)
        }
        
        if let video = feed.videos {
            videoView.isHidden = false
            contentImage.isHidden = true
            let videoURL = URL(string: video)
            let player = AVPlayer(url: videoURL!)
            let playerViewController = AVPlayerViewController()
            playerViewController.view.frame = videoView.frame
            playerViewController.player = player
            videoView.addSubview(playerViewController.view)
            playerViewController.player?.play()
        }
        
        if feed.isLike {
            likeButton.setImage(likeImage, for: .normal)
        } else {
            likeButton.setImage(unlikeImage, for: .normal)
        }
        
        likeLabel.text = feed.amountLikes
        captionLabel.text = feed.captions
        if let comments = feed.comments {
            commentLabel.isHidden = false
            commentLabel.text = "View all \(comments.count) comments"
        } else {
            commentLabel.isHidden = true
        }
    }
    
    @IBAction private func didTapLikeButton() {
        likeButton.clickedAnimate()
        if let indexPath = getIndexPath() {
            if feed.isLike {
                likeButton.setImage(unlikeImage, for: .normal)
                delegate?.didTapLikeButton(index: indexPath.row, isLike: false)
            } else {
                likeButton.setImage(likeImage, for: .normal)
                delegate?.didTapLikeButton(index: indexPath.row, isLike: true)
            }
        }
    }
    
    func getIndexPath() -> IndexPath? {
        guard let superView = self.superview as? UITableView else {
            print("superview is not a UITableView - getIndexPath")
            return nil
        }
        return superView.indexPath(for: self)
    }
}
