//
//  ProfileViewController.swift
//  TestProject
//
//  Created by Павел on 28.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    //@IBOutlet weak var dayCounter: UILabel!
    
    @IBOutlet weak var economyTime: UILabel!
    @IBOutlet weak var economyMoney: UILabel!
    @IBOutlet weak var passCigaretts: UILabel!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startStopButton: UIButton!
    
    var user: User!
    
    var timer = Timer()
    var count = 0
    var timerCounting = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startStopButton.setTitleColor(UIColor.green, for: .normal)

        count = Int(Date().timeIntervalSince1970) - user.person.timeForSmoke
        print(Int(Date().timeIntervalSince1970))
        if timerCounting { timer = Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(timerCounter),
            userInfo: nil,
            repeats: true
        ) }
        
    }

    @IBAction func resetTapped(_ sender: UIButton) {
        let alert = UIAlertController(
            title: "Reset Timer?",
            message: "Are you sure you would like to reset the Timer?",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel))

        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in
            self.count = 0
            self.timer.invalidate()
            self.timerLabel.text = self.makeTimeString(hours: 0, minutes: 0, seconds: 0)
            self.startStopButton.setTitle("START", for: .normal)
            self.startStopButton.setTitleColor(UIColor.green, for: .normal)
        }))

        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func startStopTapped(_ sender: UIButton) {
        if(timerCounting) {
            timerCounting = false
            timer.invalidate()
            startStopButton.setTitle("START", for: .normal)
            startStopButton.setTitleColor(UIColor.green, for: .normal)
            economyTime.text = "0 руб"
            economyMoney.text = "0 руб"
            passCigaretts.text = "0 шт"
        } else {
            timerCounting = true
            user.person.timeForSmoke = Int(Date().timeIntervalSince1970)
            startStopButton.setTitle("STOP", for: .normal)
            startStopButton.setTitleColor(UIColor.red, for: .normal)
            timer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(timerCounter),
                userInfo: nil,
                repeats: true
            )
        }
    }
    
    @objc func timerCounter() {
        count += 1
        let time = secondsToHoursMinutesSeconds(seconds: count)
        let timeString = makeTimeString(hours: time.0, minutes: time.1, seconds: time.2)
        timerLabel.text = timeString
    }
    
    func secondsToHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int) {
        return ((seconds / 3600), ((seconds % 3600) / 60),((seconds % 3600) % 60))
    }
    
    func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    func makeDateString(day: Int, month: Int, year: Int) -> String {
        var dateString = ""
        dateString += "\(day)"
        dateString += " / "
        dateString += "\(month)"
        dateString += " / "
        dateString += "\(year)"
        return dateString
    }
    
    func getCurrentDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        let component = calendar.dateComponents([.year, .month, .day], from: date)
        
        let stringDate = makeDateString(
            day: component.day ?? 0,
            month: component.month ?? 0,
            year: component.year ?? 0
        )
        
        
        return stringDate
    }
    

}
