//
//  CountingLabel.swift
//  QuitSmoke
//
//  Created by user on 19.02.2023.
//

import UIKit

class CountingLabel: UILabel {

    let startValue: Double = 0
    var endValue: Double = 1000
    let animationDuration: Double = 3.5
    var animationStarts = Date()
    
    var countStartValue : Double = 0
    var countEndValue : Double = 0
    
    func startCounting() {
        animationStarts = Date()
        countStartValue = startValue
        countEndValue = endValue
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleCounting))
        displayLink.add(to: .main, forMode: .default)
    }
    
    @objc public func handleCounting() {
        
        let elapsed = Date().timeIntervalSince(animationStarts)
       
        if elapsed > animationDuration {
            self.text = "\(endValue)"
        } else {
            let percent = elapsed/animationDuration
            let value = countStartValue + percent * (countEndValue - countStartValue)
            self.text = String(format:"%.2f", value)
        }
    }
}
