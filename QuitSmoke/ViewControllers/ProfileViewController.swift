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
    private var count = 0
    
    private let daysProgress = Progress.getFacts()
    private let totalProgress = Progress.getProgressList()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user = getModelUserDefaults()
        count = getTimeInterval()
        startTimer()
    }
    
    func setLayerFor(subViews: CircleProgressBar...) {
        for subView in subViews {
            containerView.layer.addSublayer(subView.backgroundLayer)
        }
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
        navigationController?.navigationBar.topItem?.title = "Профиль"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setLayerFor(subViews: adviceView, progressBar)

        let day = Double(getProgressInDays()) / Double(daysProgress.count)
        let dayTotal = Double(getTotalProgress()) / Double(totalProgress.count)
        
        economyTime.layer.animation(forKey: "text")
        
        adviceView.setValue(value: day)
        progressBar.setValue(value: dayTotal)
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
        count = getTimeInterval()
    }
}

// MARK: Help Methods
extension ProfileViewController {
    
    private func getModelUserDefaults() -> User {
        let user = User(
            priceBoxCigaretts: 0,
            amountCigarettsDay: 0,
            amountCigarettsBox: 0,
            timeForSmoke: 0,
            dateQuitSmoke: Date()
        )
        guard let data = UserDefaults.standard.object(forKey: "UserData") as? Data else {
            return user
        }
        guard let userData = try? JSONDecoder().decode(User.self, from: data) else {
            return user
        }
        return userData
    }
    
    private func startTimer() {
        Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(timerCounter),
            userInfo: nil,
            repeats: true
        )
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
    
//    private func animation(val: CGFloat) {
//        let anim = CABasicAnimation(keyPath: "text")
//
//        anim.fromValue = "0"
//        anim.toValue = val.formatted
//        anim.autoreverses = false
//        anim.timingFunction = CAMediaTimingFunction(name: .easeOut)
//        anim.duration = 2
//        anim.isRemovedOnCompletion = false
//        anim.fillMode = .forwards
//
//        economyTime.addAnimations(anim)
//    }

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
    
    private func getProgressInDays() -> Int {
        count / 86400
    }
    
    private func getTotalProgress() -> Int {
        var total = 0
        for advice in totalProgress {
            if count / advice.time >= 1 {
                total += 1
            }
        }
        return total
    }
    
    private func getTimeInterval() -> Int {
        Int(Date().timeIntervalSinceReferenceDate - user.dateQuitSmoke.timeIntervalSinceReferenceDate)
    }
    
    private func getEconomyTime() -> String {
        "\((count) / (user.timeForSmoke * 60) / 60) мин"
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

