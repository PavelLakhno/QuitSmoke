//
//  TabBarController.swift
//  TestProject
//
//  Created by Павел on 28.10.2022.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        tabBar.tintColor = .red
        setupControllers()
    }
    
    private func setupControllers() {
//        if let controllers = viewControllers {
//            for controller in controllers {
//                if let personsVC = controller as? ProfileViewController {
//                    personsVC.persons = persons
//                } else if let contactsVC = controller as? AchievementViewController {
//                    contactsVC.persons = persons
//                } else if contactsVC = controller as? AdviceViewController {
//                    contactsVC.persons = persons
//            }
//        }
    }
}
