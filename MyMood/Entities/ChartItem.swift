//
//  ChartItem.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 20/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import Foundation

struct ChartItem {
    var codHumor: Int?
    var id: Int?
    var justify: String?
    var dateRegister: String!
    
    enum CodingKeys: String, CodingKey {
        
        case codHumor
        case id
        case justify = "justificativa"
        case dateRegister = "dataCadastro"
    }    
}
