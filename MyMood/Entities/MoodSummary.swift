//
//  ListMoodSummary.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 09/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import Foundation

struct MoodSummary {
    var date: String
    var activities: Array<MoodSummaryActivity>
    
    enum CodingKeys: String, CodingKey {
        case date = "data"
        case activities = "atividades"
    }
}
