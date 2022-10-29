//
//  AchievementViewController.swift
//  TestProject
//
//  Created by Павел on 28.10.2022.
//

import UIKit

class ProgressViewController: UITableViewController {

    var user: User!
    private let achievements = Progress.getProgressList()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
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
            withIdentifier: "progress",
            for: indexPath
        ) as! ProgressTableViewCell

        cell.timeLabel.text = achievements[indexPath.row].timeTitle
        cell.descriptionLabel.text = achievements[indexPath.row].description
        cell.iconImageView.image = UIImage(named: achievements[indexPath.row].iconName)
        cell.successImageView.image = UIImage(named: "Ok")

        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        150.0
    }
}


