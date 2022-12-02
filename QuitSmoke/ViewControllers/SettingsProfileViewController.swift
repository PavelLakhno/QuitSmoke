//
//  SettingsProfileViewController.swift
//  QuitSmoke
//
//  Created by user on 02.12.2022.
//

import UIKit

class SettingsProfileViewController: UIViewController {

    
    @IBOutlet weak var dateTextFeild: UITextField!
    
    let iphonePicker = UIPickerView()
    let datePicker = UIDatePicker()
    let toolbar = UIToolbar()
    
    var phoneList = ["iphone 4s" ,"iphone 5s" , "iphone 6s" , "iphone 7 plus" , "iphone 8" , "iphone XR" , "iphone 11" , "iphone 11 pro"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        iphonePicker.delegate = self
        iphonePicker.dataSource = self
        //dateTextFeild.inputView = iphonePicker
        dateTextFeild.inputView = datePicker
        toolbar.sizeToFit()
        let donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        
        toolbar.items = [donebtn]
        dateTextFeild.inputAccessoryView = toolbar
    }
    @objc func doneButtonPressed() {
        
        let selectedPhone = phoneList[iphonePicker.selectedRow(inComponent: 0)]
        dateTextFeild.text = selectedPhone
        self.view.endEditing(true)
    }
    
}



extension SettingsProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        phoneList.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return phoneList[row]
    }
    
}

