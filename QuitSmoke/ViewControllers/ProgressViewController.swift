//
//  AchievementViewController.swift
//  QuitSmoke
//
//  Created by Павел on 28.10.2022.
//

import UIKit

class ProgressViewController: UITableViewController {

    var user: User!
    
    private let achievements = Progress.getProgressList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.separatorStyle = .none
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "Прогресс"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
        user = getModelUserDefaults()
        tableView.reloadData()
    }
}

// MARK: UITableViewControllerDataSource
extension ProgressViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section:
    Int) -> Int {
        achievements.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "ProgressTableViewCell",
            for: indexPath
        ) as! ProgressTableViewCell
        
        let progressTime = Float(getTimeIntervalFrom(date: user.dateQuitSmoke)) / Float(achievements[indexPath.row].time)
        print(progressTime)

        cell.timeLabel.text = achievements[indexPath.row].timeTitle
        cell.descriptionLabel.text = achievements[indexPath.row].description
        cell.iconImageView.image = UIImage(named: achievements[indexPath.row].iconName)
        
        cell.successLabel.text = progressTime < 1 ? "\(Int(progressTime * 100))%" : "\u{2713}"
        
        UIView.animate(withDuration: 2.0) {
            cell.progressView.setProgress(progressTime, animated: false)
        }

        return cell
    }
}

// MARK: SettingsViewControllerDelegate
//extension ProgressViewController: SettingsViewControllerDelegate {
//    func setNewValues(for user: User) {
//        self.user = user
//        tableView.reloadData()
//    }
//}

//MARK: Private Methods
extension ProgressViewController {
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
    
    private func getTimeIntervalFrom(date: Date) -> Int {
        Int(Date().timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate)
    }
}


