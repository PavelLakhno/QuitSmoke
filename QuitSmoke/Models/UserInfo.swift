//
//  UserInfo.swift
//  QuitSmoke
//
//  Created by Павел Лахно on 05.10.2022.
//

import Foundation

struct User: Codable {
    
    var priceBoxCigaretts: Int
    var amountCigarettsDay: Int
    var amountCigarettsBox: Int
    var timeForSmoke: Int
    var dateQuitSmoke: Date
}
