//
//  EmojiCollectionViewCell.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 12/4/2565 BE.
//

import Foundation
import UIKit

protocol EmojiCollectionViewCellDelegate {
    func didTapEmojiButton(emoji: Emoji)
}

class EmojiCollectionViewCell: UICollectionViewCell {
    @IBOutlet private weak var emojiButton: UIButton!
    
    private var emoji: Emoji?
    var delegate: EmojiCollectionViewCellDelegate?
    
    func updateUI(emoji: Emoji) {
        self.emoji = emoji
        emojiButton.setTitle(emoji.rawValue, for: .normal)
    }
    
    @IBAction private func didTapEmojiButton() {
        guard let emoji = emoji else { return }
        switch emoji {
        case .heart:
            delegate?.didTapEmojiButton(emoji: .heart)
        case .crap:
            delegate?.didTapEmojiButton(emoji: .crap)
        case .hand:
            delegate?.didTapEmojiButton(emoji: .hand)
        case .fire:
            delegate?.didTapEmojiButton(emoji: .fire)
        case .sad:
            delegate?.didTapEmojiButton(emoji: .sad)
        case .love:
            delegate?.didTapEmojiButton(emoji: .love)
        case .wow:
            delegate?.didTapEmojiButton(emoji: .wow)
        case .laugh:
            delegate?.didTapEmojiButton(emoji: .laugh)
        }
    }
}
