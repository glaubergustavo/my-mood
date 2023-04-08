//
//  MoodGraph.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 20/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import Foundation

struct MoodGraph {
    
    var date: String?
    var chart: Array<ChartItem>
    
    enum CodingKeys: String, CodingKey {
        case date = "data"
        case chart = "dados"
    }

}
