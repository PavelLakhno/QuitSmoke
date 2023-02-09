//
//  GreetingThirdViewController.swift
//  QuitSmoke
//
//  Created by user on 09.02.2023.
//

import UIKit

class GreetingThirdViewController: UIViewController {
    
    @IBOutlet weak var priceCiggaretsTextField: UITextField!
    @IBOutlet weak var cigaInDay: UIStepper!
    @IBOutlet weak var cigsOfBox: UIStepper!
    @IBOutlet weak var timeForSmokeSlider: UISlider!
        
    @IBOutlet weak var cigsInDayLabel: UILabel!
    @IBOutlet weak var cigsInBoxLabel: UILabel!
    @IBOutlet weak var timeForSmokeLabel: UILabel!
    
    var date: Date!
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()

        
        cigaInDay.setDecrementImage(cigaInDay.decrementImage(for: .normal), for: .normal)
        cigaInDay.setIncrementImage(cigaInDay.incrementImage(for: .normal), for: .normal)
        cigaInDay.tintColor = .systemOrange
        
        cigsOfBox.setDecrementImage(cigsOfBox.decrementImage(for: .normal), for: .normal)
        cigsOfBox.setIncrementImage(cigsOfBox.incrementImage(for: .normal), for: .normal)
        cigsOfBox.tintColor = .systemOrange

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
        print(user)
        dismiss(animated: true)
    }
        
    private func saveDataForUser() {
        user = User.init(logIn: "User", password: "Password", person: Person.init(
            priceBoxCigaretts: Int(priceCiggaretsTextField.text ?? "") ?? 0,
            amountCigarettsDay: Int(cigaInDay.value),
            amountCigarettsBox: Int(cigsOfBox.value),
            timeForSmoke: Int(timeForSmokeLabel.text ?? "") ?? 0,
            dateQuitSmoke: date
        ))
    }
    
}
