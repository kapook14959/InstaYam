//
//  UIView+Extension.swift
//  InstagramDemo

import UIKit

extension UIView {
    func clickedAnimate() {
        UIView.animate(withDuration: 0.1, animations: { [weak self] in
            self?.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            self?.flash(numberOfFlashes: 0.3)
        }, completion: { _ in
            UIView.animate(withDuration: 0.1) { [weak self] in
                self?.transform = CGAffineTransform.identity
            }
        })
    }
    
    private func flash(numberOfFlashes: Float) {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.2
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = numberOfFlashes
        layer.add(flash, forKey: nil)
    }
    
    func loadXib() {
        let view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
    }
    
    fileprivate func loadViewFromNib() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: getNibName(), bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil).first as? UIView {
            return view
        }
        return UIView()
    }
    
    fileprivate func getNibName() -> String {
        return type(of: self).description().components(separatedBy: ".").last ?? ""
    }
}
