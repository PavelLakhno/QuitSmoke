//
//  AdvicesViewController.swift
//  QuitSmoke
//
//  Created by Павел Лахно on 29.10.2022.
//

import UIKit

class AdvicesViewController: UITableViewController {
   
    var user: User!
    
    private let smokeFacts = Progress.getFacts()
    
    private var progressTime: Float {
        Float(getTimeIntervalFrom(date: user.dateQuitSmoke))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        user = getModelUserDefaults()
        
     }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "21 день"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = nil        
    }
}

// MARK: - TableViewDataSource
extension AdvicesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return smokeFacts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "AdviceTableViewCell",
            for: indexPath
        ) as! AdviceTableViewCell
        
        cell.isUserInteractionEnabled = Int(progressTime / 86400) >= indexPath.row
        
        cell.titleLabel.text = "Fact #\(indexPath.row + 1)"
        cell.numberOfDay.text = "\(indexPath.row + 1)"
        cell.factLabel.text = smokeFacts[indexPath.row]
        
        if cell.isUserInteractionEnabled {
            cell.isPassedDay.text = "☑︎"
            cell.isPassedDay.textColor = .systemGreen
        } else {
            cell.isPassedDay.text = "☒"
            cell.isPassedDay.textColor = .gray
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3) {
            tableView.performBatchUpdates(nil)
        }

    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AdviceTableViewCell {
            cell.headerView.isHidden = true
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
}

//MARK: Private Methods
extension AdvicesViewController {
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





