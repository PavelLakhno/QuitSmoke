//
//  AdvicesViewController.swift
//  TestProject
//
//  Created by Павел Лахно on 29.10.2022.
//

import UIKit

class AdvicesViewController: UITableViewController {
    

    var selectedIndex = -1
    var isCoolapse = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 332
        tableView.rowHeight = UITableView.noIntrinsicMetric
     }

    // MARK: - TableViewDataSource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! AdviceTableViewCell
        cell.nameLabel.text = "\(indexPath.row)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if selectedIndex == indexPath.row {
            isCoolapse = !isCoolapse ? true : false
        } else {
            isCoolapse = true
        }
        
        selectedIndex = indexPath.row
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        selectedIndex == indexPath.row && isCoolapse ? 332 : 70
    }
}


