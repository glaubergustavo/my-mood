//
//  MyMoodGraphManager.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 03/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import Foundation

class MyMoodGraphManager {
    
    var chartObjectList: [ChartItem] = []
    var dateNext: Double = 0
    
    func loadMoods(startDate: String,
                   endDate: String,
                   completion: @escaping ([ChartItem]?, (String?)) -> Void) {
        
//        RequestFacade.listaHumor(startDate, endDate: endDate) { [self] dicRet in
//            if let returned = dicRet as?  [String : Any] {
//                if let status = returned["status"] as? Int, status == 0 {
//                    let chartsList: Array = returned["dadosHumor"] as! Array<Dictionary<String, Any>>
//                    let sortedChartsList = chartsList.sorted(by: { (chart1, chart2) -> Bool in
//
//                        guard let date1String = chart1["dataCadastro"] as? String,
//                              let date1 = date1String.convertStringToDay(),
//                              let date2String = chart2["dataCadastro"] as? String,
//                              let date2 = date2String.convertStringToDay()
//                        else {
//                            return false
//                        }
//                        return date1 < date2
//
//                    })
//
//                    for chart in sortedChartsList {
//                        if let date: String = chart["dataCadastro"] as? String {
//                            if self.dateNext != date.convertStringToDay() {
//                                let chartItem = ChartItem(dict: chart)
//                                self.chartObjectList.append(chartItem)
//                                self.dateNext = date.convertStringToDay()!
//                            }
//                        }
//                    }
//                    completion(self.chartObjectList, nil)
//                }else{
//                    completion(nil, UtilFacade.languageSelectedString(forKey: "saveMoodError"))
//                }
//            }else{
//                completion(nil, UtilFacade.languageSelectedString(forKey: "unexpectedError"))
//            }
//        }
    }
}
