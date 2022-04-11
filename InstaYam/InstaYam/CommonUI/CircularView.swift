//
//  CircularView.swift
//  InstagramDemo

import UIKit

public class CircularView: UIView {
    @IBInspectable var radius: CGFloat = 0 {
        didSet {
            createCircularPath()
        }
    }
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()

    public var color: UIColor = .orange

    public override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createCircularPath()
    }

    private func createCircularPath() {
        let circularPath = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: radius, startAngle: -.pi / 2, endAngle: 3 * .pi / 2, clockwise: true)
        circleLayer.path = circularPath.cgPath
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineCap = .round
        circleLayer.strokeColor = UIColor.clear.cgColor
        progressLayer.path = circularPath.cgPath
        progressLayer.fillColor = UIColor.clear.cgColor
        progressLayer.lineCap = .round
        progressLayer.lineWidth = 2.0
        progressLayer.strokeEnd = 0
        progressLayer.strokeColor = color.cgColor
        layer.addSublayer(circleLayer)
        layer.addSublayer(progressLayer)
    }

    public func progressAnimation() {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = 0
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }

    public func displayCircular() {
        progressLayer.isHidden = false
    }

    public func removeCircular() {
        progressLayer.isHidden = true
    }
}
