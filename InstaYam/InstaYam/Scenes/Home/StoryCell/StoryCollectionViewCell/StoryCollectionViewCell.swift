//
//  StoryCollectionViewCell.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 6/4/2565 BE.
//

import Foundation
import UIKit

class StoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var storyImage: UIImageView!
    @IBOutlet private weak var circularView: CircularView!
    
    func updateUI(story: Story) {
        storyImage.layer.cornerRadius = storyImage.frame.height / 2
        circularView.progressAnimation()
        nameLabel.text = story.name
        let url = URL(string: story.image)
        storyImage.downloadImage(from: url!)
    }
}
