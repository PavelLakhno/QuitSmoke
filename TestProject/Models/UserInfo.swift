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

    var dateQuitSmoke: Int
    var priceBoxCigaretts: Int
    var amountCigarettsDay: Int
    var amountCigarettsBox: Int
    var timeForSmoke: Int

    static func getPersonInfo() -> Person {

        Person(
            dateQuitSmoke: 32429935,
            priceBoxCigaretts: 0,
            amountCigarettsDay: 0,
            amountCigarettsBox: 0,
            timeForSmoke: 0
        )

    }

}
