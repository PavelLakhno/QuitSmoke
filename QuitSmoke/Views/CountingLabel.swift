//
//  CountingLabel.swift
//  QuitSmoke
//
//  Created by user on 19.02.2023.
//

import UIKit

class CountingLabel: UILabel {
    
    var endValue = 1000
    var abbreviation: String = ""
    var animationDuration: Double = 1.5 //In secounds
    var animationStarts = Date()
    
    private var startValue = 0
    private var countStartValue : Double = 0
    private var countEndValue : Double = 0
    
    public func startCounting(){
        animationStarts = Date()
        countStartValue = Double(startValue)
        countEndValue = Double(endValue)
        
        let displayLink = CADisplayLink(target: self, selector: #selector(handleCounting))
        displayLink.add(to: .main, forMode: .default)
    }
    
    @objc public func handleCounting() {
        
        let elapsed = Date().timeIntervalSince(animationStarts)
        
        if elapsed > animationDuration {
            self.text = "\(endValue) \(abbreviation)"
        } else {
            let percent = elapsed/animationDuration
            let value = countStartValue + percent * (countEndValue - countStartValue)
            self.text = String(format:"%.f \(abbreviation)", value)
        }
    }
}
