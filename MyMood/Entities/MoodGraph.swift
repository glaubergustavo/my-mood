//
//  MoodGraph.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 20/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import Foundation

struct MoodGraph {
    
    init(mood: Array<ChartItem>? = nil, returnRegister: Bool? = nil, status: Int? = nil) {
        self.mood = mood
        self.returnRegister = returnRegister
        self.status = status
    }
    
    
    var mood: Array<ChartItem>?
    var returnRegister: Bool?
    var status: Int?
    
    enum CodingKeys: String, CodingKey {
        case mood = "dadosHumor"
        case returnRegister = "retornaCadastro"
        case status
    }
}
