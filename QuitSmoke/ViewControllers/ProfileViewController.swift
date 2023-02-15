//
//  ProfileViewController.swift
//  QuitSmoke
//
//  Created by Павел on 28.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var economyTime: UILabel!
    @IBOutlet weak var economyMoney: UILabel!
    @IBOutlet weak var passCigaretts: UILabel!
    @IBOutlet weak var daysLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var progressBar: CircleProgressBar!
    @IBOutlet weak var adviceView: CircleProgressBar!
    @IBOutlet weak var containerView: UIStackView!
    
    var user: User!
    
    var timer = Timer()
    var count = 0
    var timerCounting = true
    
    private let daysProgress = Progress.getFacts()
    private let totalProgress = Progress.getProgressList()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user = getModelUserDefaults()

        startStopTimer(timerCounting)
        count = getTimeIntervalFrom(date: user.dateQuitSmoke)
        
        let days = count / 86400
        var total = 0
        for advice in totalProgress {
            if count / advice.time >= 1 {
                total += 1
            }
        }
        
        //containerView.layer.addSublayer(progressBar.backgroundLayer)
        //containerView.layer.addSublayer(adviceView.backgroundLayer)
        
        //setLayerFor(subViews: adviceView, container: containerView)
        //setLayerFor(subViews: adviceView)
        //setLayerFor(subView: adviceView, completedCounter: (days, daysProgress.count), container: containerView)
        //setLayerFor(subView: progressBar, completedCounter: (total, totalProgress.count), container: containerView)

    }
    func setLayerFor(subViews: CircleProgressBar...) {
        
        for subView in subViews {
            containerView.layer.addSublayer(subView.backgroundLayer)
        }

    }
 
    private func setLayerFor(subView: UIView, completedCounter: (Int, Int), container: UIStackView) {
        
        let backgroundLayer = CAShapeLayer()
        let fillLayer = CAShapeLayer()
        
        let center = subView.center

        let circularPath = UIBezierPath(
            arcCenter: center,
            radius: subView.frame.size.width / 2.0,
            startAngle: (2 * CGFloat.pi) / 3.0,
            endAngle: CGFloat.pi / 3.0,
            clockwise: true
        )
        
        backgroundLayer.path = circularPath.cgPath
        backgroundLayer.strokeColor = UIColor.gray.cgColor
        backgroundLayer.lineWidth = 5
        backgroundLayer.fillColor = UIColor.clear.cgColor
        backgroundLayer.lineCap = CAShapeLayerLineCap.round
        backgroundLayer.shadowColor = UIColor.black.cgColor
        backgroundLayer.shadowOpacity = 1
        backgroundLayer.shadowOffset = .zero
        backgroundLayer.shadowRadius = 10

        fillLayer.path = circularPath.cgPath
        fillLayer.strokeColor = UIColor.systemGreen.cgColor
        fillLayer.lineWidth = 5
        fillLayer.fillColor = UIColor.clear.cgColor
        fillLayer.lineCap = CAShapeLayerLineCap.round
        fillLayer.strokeEnd = CGFloat(completedCounter.0) / CGFloat(completedCounter.1)
        
        let labelCompleted = UILabel(frame: CGRect(x: 0, y: 0, width: 100, height: 20))
        labelCompleted.center = subView.center
        labelCompleted.text = "\(completedCounter.0)/\(completedCounter.1)"
        labelCompleted.textAlignment = .center
        labelCompleted.textColor = .yellow
        backgroundLayer.addSublayer(fillLayer)
        
        container.layer.addSublayer(backgroundLayer)
        container.addSubview(labelCompleted)

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
    
    override func viewDidAppear(_ animated: Bool) {
        setLayerFor(subViews: progressBar, adviceView)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier  == "settingsVC" {
            let settingVC = segue.destination as! SettingsViewController
            settingVC.user = user
            settingVC.delegate = self
        }
    }
    
    @objc func showSettingsVC() {
        performSegue(withIdentifier: "settingsVC", sender: nil)
    }

}

// MARK: SettingsViewControllerDelegate
extension ProfileViewController: SettingsViewControllerDelegate {
    func setNewValues(for user: User) {
        self.user = user
        count = getTimeIntervalFrom(date: user.dateQuitSmoke)
    }
}

// MARK: Help Methods
extension ProfileViewController {
    
    private func getModelUserDefaults() -> User {
        let user = User(priceBoxCigaretts: 0, amountCigarettsDay: 0, amountCigarettsBox: 0, timeForSmoke: 0, dateQuitSmoke: Date())
        guard let data = UserDefaults.standard.object(forKey: "UserData") as? Data else {
            return user
        }
        guard let userData = try? JSONDecoder().decode(User.self, from: data) else {
            return user
        }
        return userData
    }
    
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
        
        return "\((count) / (user.timeForSmoke * 60) / 60) мин"
    }

    private func getEconomyMoney() -> String {
        let priceOneCigar = user.priceBoxCigaretts / user.amountCigarettsBox
        let spendMoneyOneDay = priceOneCigar * user.amountCigarettsDay
        let totalEconomyMoney = "\(count / 86400 * spendMoneyOneDay) руб"
        return totalEconomyMoney
    }
    
    private func getCountNoSmokeCig() -> String{
        "\(count / 86400 * user.amountCigarettsDay) шт"
    }
}

