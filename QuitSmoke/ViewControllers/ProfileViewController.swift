//
//  ProfileViewController.swift
//  QuitSmoke
//
//  Created by Павел on 28.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet var backgroundViews: [UIView]! {
        didSet {
            for backView in backgroundViews {
                backView.layer.cornerRadius = 10
                backView.layer.masksToBounds = false
                backView.layer.shadowOpacity = 0.5
                backView.layer.shadowRadius = 10
                backView.layer.shadowOffset = CGSize(width: 0, height: 0)
                backView.layer.shadowColor = UIColor.black.cgColor
            }
        }
    }
    @IBOutlet weak var economyTime: CountingLabel!
    @IBOutlet weak var economyMoney: CountingLabel!
    @IBOutlet weak var passCigaretts: CountingLabel!
    @IBOutlet weak var daysLabel: CountingLabel!
    @IBOutlet weak var hoursLabel: CountingLabel!
    @IBOutlet weak var weekLabel: CountingLabel!
    @IBOutlet weak var yearsLabel: CountingLabel!
        
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
        
        setupLabels()
        
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
    
    private func setupLabels() {
        
        let seconds = getValuesFromSeconds()
        
        economyTime.endValue = getEconomyTime()
        economyTime.abbreviation = .labelMoney
        economyTime.startCounting()
        
        economyMoney.endValue = getEconomyMoney()
        economyMoney.abbreviation = .labelMoney
        economyMoney.startCounting()
        
        passCigaretts.endValue = getCountNoSmokeCig()
        passCigaretts.abbreviation = .labelCount
        passCigaretts.startCounting()
        
        daysLabel.endValue = seconds.days
        //daysLabel.abbreviation = .labelDay
        daysLabel.startCounting()
        
        hoursLabel.endValue = seconds.hours
        //hoursLabel.abbreviation = .labelHour
        hoursLabel.startCounting()
        
        weekLabel.endValue = seconds.weeks
        //weekLabel.abbreviation = .labelWeek
        weekLabel.startCounting()
        
        yearsLabel.endValue = seconds.years
        //yearsLabel.abbreviation = .labelYear
        yearsLabel.startCounting()
    }

    private func getValuesFromSeconds() -> (years: Int, weeks: Int, days: Int, hours: Int) {
        let oneHour = 3600
        let oneDay = 24 * oneHour
        let oneWeek = 7 * oneDay
        let oneYear = 365 * oneDay
        
        let year = count / oneYear
        let week = (count % oneYear) / oneWeek
        let day = ((count % oneYear) % oneWeek) / oneDay
        let hour = (((count % oneYear) % oneWeek) % oneDay) / oneHour
        
        return (year, week, day, hour)
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
    
    private func getProgressInHours() -> Int {
        (count % 86400) / 3600
    }
    
    private func getProgressInWeek() -> Int {
        getProgressInDays() / 7
    }
    
    private func getProgressInYear() -> Int {
        getProgressInDays() / 365
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
    
    private func getEconomyTime() -> Int {
        count / (user.timeForSmoke * 60) / 60
    }

    private func getEconomyMoney() -> Int {
        let priceOneCigar = user.priceBoxCigaretts / user.amountCigarettsBox
        let spendMoneyOneDay = priceOneCigar * user.amountCigarettsDay
        let totalEconomyMoney = count / 86400 * spendMoneyOneDay
        return totalEconomyMoney
    }
    
    private func getCountNoSmokeCig() -> Int {
        count / 86400 * user.amountCigarettsDay
    }
}

