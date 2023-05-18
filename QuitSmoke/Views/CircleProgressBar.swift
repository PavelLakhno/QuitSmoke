//
//  CircleProgressBar.swift
//  QuitSmoke
//
//  Created by user on 13.02.2023.
//

import UIKit

final class CircleProgressBar: UIView {

    var widthProgress: CGFloat = 5
    var startValue: CGFloat = 0.0
    var endValue: CGFloat = 1
            
    var backgroundLayer: CAShapeLayer! {
        didSet {
            backgroundLayer.backgroundColor = backgroundColor?.cgColor
            backgroundLayer.fillColor = UIColor.clear.cgColor
            backgroundLayer.lineCap = .round
            backgroundLayer.lineWidth = widthProgress
            backgroundLayer.strokeColor = UIColor.gray.cgColor
            backgroundLayer.shadowColor = UIColor.black.cgColor
            backgroundLayer.shadowOpacity = 1
            backgroundLayer.shadowOffset = .zero
            backgroundLayer.shadowRadius = 10
        }
    }
    
    private var fillLayer: CAShapeLayer! {
        didSet {
            fillLayer.strokeColor = UIColor.systemGreen.cgColor
            fillLayer.fillColor = nil
            fillLayer.lineCap = .round
            fillLayer.lineWidth = widthProgress
            fillLayer.strokeStart = startValue
            fillLayer.strokeEnd = endValue / 100
        }
    }
    
    private var labelLayer: CATextLayer! {
        didSet {
            labelLayer.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
            labelLayer.bounds = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height / 5)
            labelLayer.fontSize = 25.0
            labelLayer.alignmentMode = .center
            labelLayer.foregroundColor = UIColor.white.cgColor
        }
    }
    
    override func draw(_ rect: CGRect) {
        configureBackgroundLayer()
        confugureFillLayer()
        configureLabelLayer()
        //configureGradient()
    }
    
    private func configureBackgroundLayer() {
        backgroundLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: frame.size.width / 2.0,
            startAngle: (2 * CGFloat.pi) / 3.0,
            endAngle: CGFloat.pi / 3.0,
            clockwise: true
        )
        
        layer.masksToBounds = true
        backgroundLayer.path = circularPath.cgPath
        layer.addSublayer(backgroundLayer)
    }
    
    private func confugureFillLayer() {
        fillLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: frame.size.width / 2.0,
            startAngle: (2 * CGFloat.pi) / 3.0,
            endAngle: CGFloat.pi / 3.0,
            clockwise: true
        )
        
        fillLayer.path = circularPath.cgPath
        backgroundLayer.addSublayer(fillLayer)
    }
    
    private func configureLabelLayer() {
        labelLayer = CATextLayer()
        labelLayer.string = "0 %"
        layer.addSublayer(labelLayer)
    }
    
    
    private func animation(val: CGFloat) {
        let anim = CABasicAnimation(keyPath: "strokeEnd")
        
        anim.fromValue = startValue
        anim.toValue = val
        anim.autoreverses = false
        anim.timingFunction = CAMediaTimingFunction(name: .easeOut)
        anim.duration = 2
        anim.isRemovedOnCompletion = false
        anim.fillMode = .forwards
        
        fillLayer.add(anim, forKey: nil)
    }
    
    public func setValue(value: Double, completion: (() -> Void)? = nil) {
        let value = CGFloat(value)
        let precent = (value/endValue)
        animation(val: precent)
        labelLayer.string = precent > 1 ? "100 %" : "\(Int(precent * 100)) %"  
    }
     
}
