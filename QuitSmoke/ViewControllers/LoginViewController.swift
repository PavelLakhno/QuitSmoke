//
//  LoginViewController.swift
//  QuitSmoke
//
//  Created by Павел on 28.10.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let user = User.getUserInfo()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationVC = segue.destination as? UINavigationController {
            if let tabBarController = navigationVC.topViewController as? UITabBarController {
                guard let viewControllers = tabBarController.viewControllers else { return }
                for viewController in viewControllers {
                    if let profileVC = viewController as? ProfileViewController {
                        profileVC.user = user
                    }
                }       
            }
        }
    }

    @IBAction func logInPressed() {
        guard userNameTextField.text == user.logIn, passwordTextField.text == user.password else {
            showAlert(
                title: "Invalid login or password",
                message: "Please, enter correct login and password",
                textField: passwordTextField
            )
            return
        }
        performSegue(withIdentifier: "profileVC", sender: nil)
    }
    
    @IBAction func forgotPressed(_ sender: UIButton) {
        sender.tag == 0
        ? showAlert(title: "Ooops!", message: "Your name is \(user.logIn) 😇")
        : showAlert(title: "Ooops!", message: "Your password is \(user.password) 🙃")
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
}

// MARK: - UIAlertController

extension LoginViewController {
    private func showAlert(title: String, message: String, textField: UITextField? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        let okAlert = UIAlertAction(title: "OK", style: .default) {_ in
            textField?.text = ""
        }
        alert.addAction(okAlert)
        present(alert, animated: true)
    }
}

