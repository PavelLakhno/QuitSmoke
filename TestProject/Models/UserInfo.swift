//
//  UserInfo.swift
//  LoginApp
//
//  Created by Павел Лахно on 05.10.2022.
//

import Foundation

struct User {
    let logIn: String
    let password: String
    var person: Person
    
    static func getUserInfo() -> User {
        User(
            logIn: "User",
             password: "Password",
             person: .getPersonInfo()
        )
    }
}

struct Person {

    
    var priceBoxCigaretts: Int
    var amountCigarettsDay: Int
    var amountCigarettsBox: Int
    var timeForSmoke: Int
    var dateQuitSmoke: Date
    
    static func getPersonInfo() -> Person {

        Person(
            priceBoxCigaretts: 150,
            amountCigarettsDay: 15,
            amountCigarettsBox: 20,
            timeForSmoke: 4,
            dateQuitSmoke: defaultSettings()
        )

    }
    
    static func defaultSettings() -> Date {
        var component = DateComponents()
        component.year = 2021
        component.month = 6
        component.day = 20
        component.hour = 12
        component.minute = 25
        component.second = 54

        return Calendar.current.date(from: component) ?? Date()
    }

}
