//
//  ProgressTableViewCell.swift
//  QuitSmoke
//
//  Created by Павел Лахно on 29.10.2022.
//

import UIKit

class ProgressTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var successLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // add shadow on cell
            backgroundColor = .clear // very important
            layer.masksToBounds = false
            layer.shadowOpacity = 0.5
            layer.shadowRadius = 5
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowColor = UIColor.black.cgColor

            // add corner radius on `contentView`
            contentView.backgroundColor = .white
            contentView.layer.cornerRadius = 15
        //contentView.layer.borderWidth = 2
        //contentView.layer.borderColor = UIColor.darkGray.cgColor
//        contentView.layer.shadowColor = UIColor.black.cgColor
//        contentView.layer.shadowOpacity = 1
//        contentView.layer.shadowOffset = .zero
//        contentView.layer.shadowRadius = 15
//        contentView.layer.cornerRadius = 15
        
        
        contentView.backgroundColor = UIColor.darkGray



    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        
    }

}
