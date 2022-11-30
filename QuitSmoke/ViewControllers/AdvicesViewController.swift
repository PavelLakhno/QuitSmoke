//
//  AdvicesViewController.swift
//  QuitSmoke
//
//  Created by Павел Лахно on 29.10.2022.
//

import UIKit

class AdvicesViewController: UITableViewController {
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        cell.nameLabel.text = "\(indexPath.row)"

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

}


