//
//  SettingsProfileViewController.swift
//  QuitSmoke
//
//  Created by user on 02.12.2022.
//

import UIKit

protocol SettingsProfileViewControllerDelegate {
    func reloadData()
}

class SettingsProfileViewController: UIViewController {
    
    
    @IBOutlet weak var dateTextFeild: UITextField!
    @IBOutlet weak var priceCiggaretsTextField: UITextField!
    @IBOutlet weak var cigaInDay: UIStepper!
    @IBOutlet weak var cigsOfBox: UIStepper!
    @IBOutlet weak var timeForSmokeSlider: UISlider!
        
    @IBOutlet weak var cigsInDayLabel: UILabel!
    @IBOutlet weak var cigsInBoxLabel: UILabel!
    @IBOutlet weak var timeForSmokeLabel: UILabel!
    
    var datePicker: UIDatePicker!
    let toolbar = UIToolbar()
    
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        cigaInDay.setDecrementImage(cigaInDay.decrementImage(for: .normal), for: .normal)
        cigaInDay.setIncrementImage(cigaInDay.incrementImage(for: .normal), for: .normal)
        cigaInDay.tintColor = .systemOrange
        
        cigsOfBox.setDecrementImage(cigsOfBox.decrementImage(for: .normal), for: .normal)
        cigsOfBox.setIncrementImage(cigsOfBox.incrementImage(for: .normal), for: .normal)
        cigsOfBox.tintColor = .systemOrange

        datePicker = createDatePicker()
        dateTextFeild.inputView = datePicker
        
        dateTextFeild.inputAccessoryView = toolbar
        priceCiggaretsTextField.inputAccessoryView = toolbar
        
        loadDataUser(user: user)
        setupCorrectLabels()
                
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        toolbar.barTintColor = .darkGray
        
        toolbar.sizeToFit()
        toolbar.items = [doneButton]
        toolbar.tintColor = .systemGreen
        
    }
    
    @objc func doneButtonPressed(sender: Any) {
        view.endEditing(true)
    }
    
    @IBAction func didTappedStepper(_ sender: Any) {
        
        if let stepper = sender as? UIStepper {
            switch stepper {
            case cigaInDay: cigsInDayLabel.text = "\(Int(stepper.value))"
            default:
                cigsInBoxLabel.text = "\(Int(stepper.value))"
            }
        } else if let slider = sender as? UISlider {
            timeForSmokeLabel.text = "\(Int(slider.value))"
        }
    }
    
    @IBAction func didTappedAction() {
        saveDataForUser()
        print("pressed button")
        navigationController?.popViewController(animated: true)
    }
    
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let profileVC = segue.destination as? ProfileViewController {
            profileVC.delegate = self
        }
    }*/
        
    private func saveDataForUser() {
        user = User.init(
            priceBoxCigaretts: Int(priceCiggaretsTextField.text ?? "") ?? 0,
            amountCigarettsDay: Int(cigaInDay.value),
            amountCigarettsBox: Int(cigsOfBox.value),
            timeForSmoke: Int(timeForSmokeLabel.text ?? "") ?? 0,
            dateQuitSmoke: datePicker.date
        )
        
        if let encoded = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(encoded, forKey: "UserData")
        }

    }

    private func loadDataUser(user: User) {
        priceCiggaretsTextField.text = String(describing: user.priceBoxCigaretts)
        timeForSmokeSlider.value = Float(user.timeForSmoke)
        cigsOfBox.value = Double(user.amountCigarettsBox)
        cigaInDay.value = Double(user.amountCigarettsDay)
    }
    
    private func setupCorrectLabels() {
        dateTextFeild.text = formatDate(date: user.dateQuitSmoke)
        cigsInBoxLabel.text = String(describing: user.amountCigarettsBox)
        cigsInDayLabel.text = String(describing: user.amountCigarettsDay)
        timeForSmokeLabel.text = String(describing: user.timeForSmoke)
    }
}

extension SettingsProfileViewController {
    
    @objc func dateChange(datePicker: UIDatePicker) {
        dateTextFeild.text = formatDate(date: datePicker.date)
    }
    
    private func createDatePicker() -> UIDatePicker {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .dateAndTime
        datePicker.addTarget(
            self,
            action: #selector(dateChange(datePicker:)),
            for: UIControl.Event.valueChanged
        )
        datePicker.tintColor = .white
        datePicker.backgroundColor = .darkGray
        datePicker.overrideUserInterfaceStyle = .dark
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.date = user.dateQuitSmoke
        datePicker.maximumDate = Date()
        return datePicker
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
}



