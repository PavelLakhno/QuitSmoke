//
//  GreetingSecondViewController.swift
//  QuitSmoke
//
//  Created by user on 09.02.2023.
//

import UIKit

class GreetingSecondViewController: UIViewController {
    
    @IBOutlet weak var dateTextFeild: UITextField!
    @IBOutlet weak var nextButton: UIButton! {
        didSet {
            nextButton.isEnabled = false
        }
    }
    
    let toolbar = UIToolbar()
    var datePicker: UIDatePicker!

    override func viewDidLoad() {
        super.viewDidLoad()

        datePicker = createDatePicker()
        dateTextFeild.inputView = datePicker
        dateTextFeild.inputAccessoryView = toolbar
                
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        toolbar.barTintColor = .darkGray
        toolbar.sizeToFit()
        toolbar.items = [doneButton]
        toolbar.tintColor = .systemOrange
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let greetingThirdVC = segue.destination as? GreetingThirdViewController {
            greetingThirdVC.date = datePicker.date
        }
    }
}

extension GreetingSecondViewController {
    
    @objc func doneButtonPressed(sender: Any) {
        nextButton.isEnabled = true
        view.endEditing(true)
    }
    
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
        datePicker.maximumDate = Date()
        return datePicker
    }
    
    private func formatDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy"
        return formatter.string(from: date)
    }
}
