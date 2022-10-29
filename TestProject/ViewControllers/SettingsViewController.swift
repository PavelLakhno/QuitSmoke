//
//  SettingsViewController.swift
//  TestProject
//
//  Created by Павел on 28.10.2022.
//

import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var priceBoxCigaretts: UILabel!
    @IBOutlet weak var amountCigarettsDay: UILabel!
    @IBOutlet weak var amountCigarettsBox: UILabel!
    @IBOutlet weak var timeForSmoke: UILabel!

    @IBOutlet weak var priceBoxSlider: UISlider!
    @IBOutlet weak var amountInBoxSlider: UISlider!
    @IBOutlet weak var amountCigarettsDaySlider: UISlider!
    @IBOutlet weak var timeForSmokeSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func setupSettings(_ sender: UISlider) {
        
        switch sender {
        case priceBoxSlider:
            priceBoxCigaretts.text = "\(Int(sender.value)) руб"
        case amountInBoxSlider:
            amountCigarettsBox.text = "\(Int(sender.value)) шт"
        case amountCigarettsDaySlider:
            amountCigarettsDay.text = "\(Int(sender.value)) шт"
        default:
            timeForSmoke.text = "\(Int(sender.value)) мин"
        }
        
    }
    
    @IBAction func dismissView() {
        dismiss(animated: true)
    }

}
