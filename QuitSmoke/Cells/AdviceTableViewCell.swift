//
//  AdviceTableViewCell.swift
//  QuitSmoke
//
//  Created by user on 03.11.2022.
//

import UIKit

class AdviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UIView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        headerView.isHidden = selected && headerView.isHidden ? false : true
    }
    

}

