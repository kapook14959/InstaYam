//
//  UITextField+Extension.swift
//  InstaYam
//
//  Created by Supakorn Siripisitwong on 12/4/2565 BE.
//

import Foundation
import UIKit

extension UITextField {
    func setPaddingLeft(space: CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: frame.height))
        leftViewMode = .always
        layer.masksToBounds = true
        leftView = paddingView
        rightViewMode = .always
    }
}
