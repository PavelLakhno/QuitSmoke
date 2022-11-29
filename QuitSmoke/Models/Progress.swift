//
//  Achievement.swift
//  QuitSmoke
//
//  Created by Павел Лахно on 29.10.2022.
//

import Foundation

struct Progress {
    let iconName: String
    let timeTitle: String
    let description: String
    
//    let iconSuccess: String
//    let progressStatus: Float
    
    static func getProgressList() -> [Progress] {
        
        let dataStore = DataStore.shared
        var progresses: [Progress] = []
        
        let iconNames = dataStore.icons
        let timeTitles = dataStore.titles
        let descriptions = dataStore.descriptons
        
        let minValue = min(
            iconNames.count,
            timeTitles.count,
            descriptions.count
        )
        
        for index in 0..<minValue {
            let progress = Progress(
                iconName: iconNames[index],
                timeTitle: timeTitles[index],
                description: descriptions[index]
            )
            progresses.append(progress)
        }
        
        return progresses
    }
}
