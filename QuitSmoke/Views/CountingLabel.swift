//
//  CountingLabel.swift
//  QuitSmoke
//
//  Created by user on 19.02.2023.
//

import UIKit

enum Abbrivation: String, CaseIterable {
    
    case labelMinute = "мин"
    case labelMoney = "руб"
    case labelCount = "шт"
    case labelDay = "день"
    case labelHour = "час"
    case labelWeek = "нед."
    case labelYear = "год"
    case labelNil = ""
    
}

class CountingLabel: UILabel {
    
    var endValue = 1000
    var abbreviation: Abbrivation = .labelNil
    var animationDuration: Double = 1.5
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
            self.text = "\(endValue) \(abbreviation.rawValue)"
        } else {
            let percent = elapsed/animationDuration
            let value = countStartValue + percent * (countEndValue - countStartValue)
            self.text = String(format:"%.f \(abbreviation.rawValue)", value)
        }
    }
}
