//
//  AdviceTableViewCell.swift
//  QuitSmoke
//
//  Created by user on 03.11.2022.
//

import UIKit

class AdviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UIView! {
        didSet {
            layer.cornerRadius = 5
        }
    }
    
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfDay: UILabel!
    @IBOutlet weak var isPassedDay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .darkGray
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        headerView.isHidden = selected && headerView.isHidden ? false : true
    }
    

}

