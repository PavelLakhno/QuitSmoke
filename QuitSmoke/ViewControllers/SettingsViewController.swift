//
//  SettingsViewController.swift
//  QuitSmoke
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
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    var user: User!
    var delegate: SettingsViewControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.date = user.person.dateQuitSmoke
        datePicker.maximumDate = Date()
        loadDataUser(user: user)
        setupCorrectLabels()
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
    
    @IBAction func didTappedAction() {
        saveDataForUser()
        delegate.setupSettingsTo(user: user)
        dismiss(animated: true)
    }
    
    private func saveDataForUser() {
        user.person.priceBoxCigaretts = Int(priceBoxSlider.value)
        user.person.timeForSmoke = Int(timeForSmokeSlider.value)
        user.person.amountCigarettsBox = Int(amountInBoxSlider.value)
        user.person.amountCigarettsDay = Int(amountCigarettsDaySlider.value)
        user.person.dateQuitSmoke = datePicker.date
    }

    private func loadDataUser(user: User) {
        priceBoxSlider.value = Float(user.person.priceBoxCigaretts)
        timeForSmokeSlider.value = Float(user.person.timeForSmoke)
        amountInBoxSlider.value = Float(user.person.amountCigarettsBox)
        amountCigarettsDaySlider.value = Float(user.person.amountCigarettsDay)
    }
    
    private func setupCorrectLabels() {
        priceBoxCigaretts.text = "\(user.person.priceBoxCigaretts) руб"
        amountCigarettsBox.text = "\(user.person.amountCigarettsBox) шт"
        amountCigarettsDay.text = "\(user.person.amountCigarettsDay) шт"
        timeForSmoke.text = "\(user.person.timeForSmoke) мин"
    }
}
