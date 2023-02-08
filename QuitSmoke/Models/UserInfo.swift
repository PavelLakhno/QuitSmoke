//
//  UserInfo.swift
//  QuitSmoke
//
//  Created by Павел Лахно on 05.10.2022.
//

import Foundation

struct User {
    let logIn: String
    let password: String
    var person: Person
    /*
    static func getUserInfo() -> User {
        User(
            logIn: "User",
             password: "Password",
             person: .getPersonInfo()
        )
    }
     */
}

class Person {
    
    var priceBoxCigaretts: Int
    var amountCigarettsDay: Int
    var amountCigarettsBox: Int
    var timeForSmoke: Int
    var dateQuitSmoke: Date
    
    init(priceBoxCigaretts: Int, amountCigarettsDay: Int, amountCigarettsBox: Int, timeForSmoke: Int, dateQuitSmoke: Date ) {
        self.priceBoxCigaretts = priceBoxCigaretts
        self.amountCigarettsDay = amountCigarettsDay
        self.amountCigarettsBox = amountCigarettsBox
        self.timeForSmoke = timeForSmoke
        self.dateQuitSmoke = dateQuitSmoke
    }
    /*
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
        component.year = 2022
        component.month = 11
        component.day = 30
        component.hour = 10
        component.minute = 0
        component.second = 0

        return Calendar.current.date(from: component) ?? Date()
    }
     */
}
