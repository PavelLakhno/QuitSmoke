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
    @IBOutlet weak var factLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .darkGray
        
        contentView.layer.shadowColor = UIColor.black.cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 5
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        headerView.isHidden = selected && headerView.isHidden ? false : true
        layoutIfNeeded()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        //contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5))
        
    }
}

