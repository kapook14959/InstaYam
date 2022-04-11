//
//  FeedTableViewCell.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 6/4/2565 BE.
//

import Foundation
import UIKit

class FeedTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var tableView: UITableView!
    
    private var feed: [FeedData] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let nib = UINib(nibName: "FeedContentTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "FeedContentTableViewCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func updateUI(feed: [FeedData]) {
        self.feed = feed
    }
}

extension FeedTableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feed.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FeedContentTableViewCell", for: indexPath) as? FeedContentTableViewCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.updateUI(feed: feed[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

extension FeedTableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension FeedTableViewCell: FeedContentTableViewCellDelegate {
    func didTapLikeButton(index: Int, isLike: Bool) {
        feed[index].isLike = isLike
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
}
