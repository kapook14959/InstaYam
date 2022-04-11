//
//  LoadingView.swift
//  InstagramDemo
//
//  Created by Paremai on 4/4/2565 BE.
//

import UIKit

class LoadingView: UIView {
    @IBOutlet private weak var activityLoading: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadXib()
        startLoading()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadXib()
        startLoading()
    }
    
    private func startLoading() {
        activityLoading.startAnimating()
    }
}
