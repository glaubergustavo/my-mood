//
//  MoodSummaryActivity.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 09/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import Foundation

enum MoodSummaryActivitiesType: Int {
    case mood = 1
    case missions = 2
    case certificate = 3
}

struct MoodSummaryActivity {
    var id: Int
    var type: MoodSummaryActivitiesType
    var title: String
    var subtitle: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case type = "tipo"
        case title = "titulo"
        case subtitle = "subtitulo"
    }
}
