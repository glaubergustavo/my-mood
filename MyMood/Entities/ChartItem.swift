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
    
    init(dict: [String : Any]) {
        self.codHumor = dict["codHumor"] as? Int ?? 0
        self.id = dict["id"] as? Int ?? 0
        self.justify = dict["justificativa"] as? String
        self.dateRegister = (dict["dataCadastro"] as! String)
    }
}
