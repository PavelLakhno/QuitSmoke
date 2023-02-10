//
//  UserInfo.swift
//  QuitSmoke
//
//  Created by Павел Лахно on 05.10.2022.
//

import Foundation

//struct User {
//    let logIn: String
//    let password: String
//    var person: Person
//    /*
//    static func getUserInfo() -> User {
//        User(
//            logIn: "User",
//             password: "Password",
//             person: .getPersonInfo()
//        )
//    }
//     */
//}

class User: Codable {
    
    var priceBoxCigaretts: Int!
    var amountCigarettsDay: Int!
    var amountCigarettsBox: Int!
    var timeForSmoke: Int!
    var dateQuitSmoke: Date!
    
    init(priceBoxCigaretts: Int, amountCigarettsDay: Int, amountCigarettsBox: Int, timeForSmoke: Int, dateQuitSmoke: Date ) {
        self.priceBoxCigaretts = priceBoxCigaretts
        self.amountCigarettsDay = amountCigarettsDay
        self.amountCigarettsBox = amountCigarettsBox
        self.timeForSmoke = timeForSmoke
        self.dateQuitSmoke = dateQuitSmoke
    }

}
