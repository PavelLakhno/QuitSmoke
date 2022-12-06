//
//  AdvicesViewController.swift
//  QuitSmoke
//
//  Created by Павел Лахно on 29.10.2022.
//

import UIKit

class AdvicesViewController: UITableViewController {
   
    var user: User!
    private var progressTime: Float {
        Float(getTimeIntervalFrom(date: user.person.dateQuitSmoke))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "21 days"
        navigationController?.navigationBar.topItem?.rightBarButtonItem = nil
    }

    // MARK: - TableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "AdviceTableViewCell",
            for: indexPath
        ) as! AdviceTableViewCell
        
        cell.isUserInteractionEnabled = Int(progressTime / 86400) >= indexPath.row
        cell.titleLabel.text = "Information"
        cell.numberOfDay.text = "\(indexPath.row + 1)"
        
        if cell.isUserInteractionEnabled {
            cell.isPassedDay.text = "☑︎"
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
    
    //MARK: Private Methods
    
    private func getTimeIntervalFrom(date: Date) -> Int {
        Int(Date().timeIntervalSinceReferenceDate - date.timeIntervalSinceReferenceDate)
    }

}


