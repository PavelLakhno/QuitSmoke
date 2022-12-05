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
        
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray.cgColor
        layer.cornerRadius = 15
    }

}
