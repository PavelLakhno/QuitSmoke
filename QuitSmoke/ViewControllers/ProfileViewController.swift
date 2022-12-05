//
//  ProfileViewController.swift
//  QuitSmoke
//
//  Created by Павел on 28.10.2022.
//

import UIKit

protocol SettingsViewControllerDelegate {
    func setupSettingsTo(user: User)
}

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var economyTime: UILabel!
    @IBOutlet weak var economyMoney: UILabel!
    @IBOutlet weak var passCigaretts: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var adviceView: UIView!
    @IBOutlet weak var containerView: UIStackView!
    
    var user: User!
    
    var timer = Timer()
    var count = 0
    var timerCounting = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        startStopTimer(timerCounting)
        count = getTimeIntervalFrom(date: user.person.dateQuitSmoke)
        
        setLayerFor(subView: adviceView)
        setLayerFor(subView: progressView)

    }
    
    private func setLayerFor(subView: UIView) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.shadowRadius = 15
        shapeLayer.shadowColor = UIColor.black.cgColor
        shapeLayer.opacity = 1
        shapeLayer.shadowOffset = .zero
        
        let center = subView.center
        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: subView.frame.size.width/2,
            startAngle: -CGFloat.pi,
            endAngle: 2*CGFloat.pi,
            clockwise: true
        )
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.systemGreen.cgColor
        shapeLayer.lineWidth = 5
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        shapeLayer.strokeEnd = 0.5

        
        containerView.layer.addSublayer(shapeLayer)
    }
    
  
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "gearshape.fill"),
            style: .done,
            target: self,
            action: #selector(showSettingsVC)
        )
        navigationController?.navigationBar.tintColor = .systemGreen
        navigationController?.navigationBar.topItem?.title = "Profile"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let settingsVC = segue.destination as? SettingsProfileViewController {
            settingsVC.user = user
            settingsVC.delegate = self
        }
    }
    
    // MARK: Private Methods
    private func startStopTimer(_ isValue: Bool) {
        if isValue {
            timer = Timer.scheduledTimer(
                timeInterval: 1,
                target: self,
                selector: #selector(timerCounter),
                userInfo: nil,
                repeats: true
            )
        } else {
            timer.invalidate()
        }
    }
        
    @objc func timerCounter() {
        count += 1
        let time = secondsToDaysHoursMinutesSeconds(seconds: count)
        let dayString = "\(time.0)"
        let timeString = makeTimeString(hours: time.1, minutes: time.2, seconds: time.3)
        daysLabel.text = dayString
        timerLabel.text = timeString
        economyTime.text = getEconomyTime()
        economyMoney.text = getEconomyMoney()
        passCigaretts.text = getCountNoSmokeCig()
    }
    
    @objc func showSettingsVC() {
        performSegue(withIdentifier: "settingsVC", sender: nil)
    }
    
    
    private func secondsToDaysHoursMinutesSeconds(seconds: Int) -> (Int, Int, Int, Int) {
        let restSeconds = seconds % 86400
        return ((seconds / 86400), (restSeconds / 3600), ((restSeconds % 3600) / 60), ((restSeconds % 3600) % 60))
    }
    
    
    private func makeTimeString(hours: Int, minutes: Int, seconds : Int) -> String {
        var timeString = ""
        timeString += String(format: "%02d", hours)
        timeString += " : "
        timeString += String(format: "%02d", minutes)
        timeString += " : "
        timeString += String(format: "%02d", seconds)
        return timeString
    }
    
    private func makeDayString(seconds: Int) -> String {
        "\((seconds / 86400))"
    }
    
    private func getTimeIntervalFrom(date: Date) -> Int {
        Int(Date().timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate)
    }
    
    private func getEconomyTime() -> String {
        
        return "\((count) / (user.person.timeForSmoke * 60) / 60) мин"
    }

    private func getEconomyMoney() -> String {
        let priceOneCigar = user.person.priceBoxCigaretts / user.person.amountCigarettsBox
        let spendMoneyOneDay = priceOneCigar * user.person.amountCigarettsDay
        let totalEconomyMoney = "\(count / 86400 * spendMoneyOneDay) руб"
        return totalEconomyMoney
    }
    
    private func getCountNoSmokeCig() -> String{
        "\(count / 86400 * user.person.amountCigarettsDay) шт"
    }
   
}


extension ProfileViewController : SettingsViewControllerDelegate {
    func setupSettingsTo(user: User) {
        self.user = user
        count = getTimeIntervalFrom(date: user.person.dateQuitSmoke)
    }
}
