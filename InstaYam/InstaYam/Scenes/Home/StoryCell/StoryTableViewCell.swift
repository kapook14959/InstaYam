//
//  StoryTableViewCell.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 6/4/2565 BE.
//

import Foundation
import UIKit

class StoryTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    private var stories: [Story] = []
         
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "StoryCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "StoryCell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func updateUI(stories: [Story]) {
        self.stories = stories
    }
}

extension StoryTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCell", for: indexPath) as? StoryCollectionViewCell else { return UICollectionViewCell() }
        cell.updateUI(story: stories[indexPath.row])
        return cell
    }
}

extension StoryTableViewCell: UICollectionViewDelegate {
    
}

extension StoryTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 60, height: 93)
    }
}
