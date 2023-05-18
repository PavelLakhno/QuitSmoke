//
//  AdviceTableViewCell.swift
//  QuitSmoke
//
//  Created by user on 03.11.2022.
//

import UIKit

class AdviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UIView!
    
    @IBOutlet weak var headerView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberOfDay: UILabel!
    @IBOutlet weak var isPassedDay: UILabel!
    @IBOutlet weak var factLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = .clear
        //layer.borderWidth = 2
        //layer.borderColor = UIColor.darkGray.cgColor
        
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOpacity = 1
//        contentView.layer.shadowOffset = .zero
//        contentView.layer.shadowRadius = 5
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowColor = UIColor.black.cgColor
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        headerView.isHidden = selected && headerView.isHidden ? false : true
        layoutIfNeeded()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 5))
        contentView.layer.cornerRadius = 15
        contentView.backgroundColor = UIColor.darkGray
        
    }
}

