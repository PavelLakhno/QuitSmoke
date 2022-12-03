//
//  SettingsProfileViewController.swift
//  QuitSmoke
//
//  Created by user on 02.12.2022.
//

import UIKit

class SettingsProfileViewController: UIViewController {

    
    @IBOutlet weak var dateTextFeild: UITextField!
    @IBOutlet weak var priceCiggaretsTextField: UITextField!
    
    @IBOutlet weak var cigaInDay: UIStepper!
    @IBOutlet weak var cigsOfBox: UIStepper!
    
    var datePicker: UIDatePicker!
    let pricePicker = UIPickerView()
    let toolbar = UIToolbar()
    
    let priceList = Array(1...500)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let label = UILabel.init(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        label.text = "25"
        cigaInDay.setDecrementImage(cigaInDay.decrementImage(for: .normal), for: .normal)
        cigaInDay.setIncrementImage(cigaInDay.incrementImage(for: .normal), for: .normal)
        cigaInDay.tintColor = .systemGreen
        
        cigsOfBox.setDecrementImage(cigsOfBox.decrementImage(for: .normal), for: .normal)
        cigsOfBox.setIncrementImage(cigsOfBox.incrementImage(for: .normal), for: .normal)
        cigsOfBox.tintColor = .systemGreen
        
        pricePicker.delegate = self
        pricePicker.dataSource = self
        pricePicker.backgroundColor = .darkGray
        pricePicker.setValue(UIColor.white, forKeyPath: "textColor")

        
        priceCiggaretsTextField.inputView = pricePicker
        datePicker = createDatePicker()
        dateTextFeild.inputView = datePicker
        dateTextFeild.layer.cornerRadius = dateTextFeild.frame.height/2
        priceCiggaretsTextField.layer.cornerRadius = priceCiggaretsTextField.frame.height/2
        
        dateTextFeild.inputAccessoryView = toolbar
        priceCiggaretsTextField.inputAccessoryView = toolbar
        
        
        
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        toolbar.barTintColor = .darkGray
        
        toolbar.sizeToFit()
        toolbar.items = [doneButton]
        toolbar.tintColor = .systemGreen
        
    }
    
    @objc func doneButtonPressed(sender: Any) {
        view.endEditing(true)
    }
    
}



extension SettingsProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        priceList.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(priceList[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        priceCiggaretsTextField.text = String("\(priceList[row])  rub")
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



