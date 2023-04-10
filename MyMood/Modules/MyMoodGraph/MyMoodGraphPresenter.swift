//
//  MyMoodGraphPresenter.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 03/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import UIKit

protocol MyMoodGraphPresenterDelegate {
    func dataLoaded()
    func showError(_ strError: String)
}

class MyMoodGraphPresenter: NSObject {
    
    var moods: [Mood] = []
    var moodSelected = 0
    
    var numberOfRows: Int {
        return moods.count
    }
    
    var moodGraph: MoodGraph!
    var listMoodGraph: [MoodGraph] = []
    var chartList: [ChartItem] = []
    var chart: ChartItem!
    
    var listMoodSummary: [MoodSummary]!
    var moodSummary: MoodSummary!
    
    var delegate: MyMoodGraphPresenterDelegate?
    
    init (delegate: MyMoodGraphPresenterDelegate?) {
        self.delegate = delegate
    }
    
    func loadData() {
        
        // Mood Graph Data
        let charts1: [ChartItem] = [
            ChartItem(codHumor: 1, id: 1, justify: "Teste", dateRegister: "2023-03-01 08:40:00"),
            ChartItem(codHumor: 4, id: 4, justify: "Teste", dateRegister: "2023-03-02 16:40:00"),
            ChartItem(codHumor: 7, id: 7, justify: "Teste", dateRegister: "2023-03-05 10:40:00"),
            ChartItem(codHumor: 2, id: 2, justify: "Teste", dateRegister: "2023-03-09 11:40:00"),
            ChartItem(codHumor: 5, id: 5, justify: "Teste", dateRegister: "2023-03-15 20:40:00"),
            ChartItem(codHumor: 8, id: 8, justify: "Teste", dateRegister: "2023-03-16 13:40:00"),
            ChartItem(codHumor: 2, id: 2, justify: "Teste", dateRegister: "2023-03-22 14:40:0"),
            ChartItem(codHumor: 5, id: 5, justify: "Teste", dateRegister: "2023-03-28 22:40:00"),
            ChartItem(codHumor: 8, id: 8, justify: "Teste", dateRegister: "2023-03-30 01:40:00")
            ]
        let data1 = MoodGraph(date: "Março/2023", chart: charts1)
        
        let charts2: [ChartItem] = [
            ChartItem(codHumor: 5, id: 5, justify: "Teste", dateRegister: "2023-04-01 08:40:00"),
            ChartItem(codHumor: 4, id: 4, justify: "Teste", dateRegister: "2023-04-02 09:40:00"),
            ChartItem(codHumor: 8, id: 8, justify: "Teste", dateRegister: "2023-04-03 10:40:00"),
            ChartItem(codHumor: 10, id: 10, justify: "Teste", dateRegister: "2023-04-04 11:40:00"),
            ChartItem(codHumor: 2, id: 2, justify: "Teste", dateRegister: "2023-04-05 12:40:00"),
            ChartItem(codHumor: 7, id: 7, justify: "Teste", dateRegister: "2023-04-06 13:40:00"),
            ChartItem(codHumor: 6, id: 6, justify: "Teste", dateRegister: "2023-04-07 14:40:00"),
            ChartItem(codHumor: 1, id: 1, justify: "Teste", dateRegister: "2023-04-08 15:40:00"),
            ChartItem(codHumor: 4, id: 4, justify: "Teste", dateRegister: "2023-04-09 16:40:00")
        ]
        
        let data2 = MoodGraph(date: "Abril/2023", chart: charts2)
        
        let charts3: [ChartItem] = [
            ChartItem(codHumor: 2, id: 2, justify: "Teste", dateRegister: "2023-05-01 02:40:00"),
            ChartItem(codHumor: 7, id: 7, justify: "Teste", dateRegister: "2023-05-02 09:40:00"),
            ChartItem(codHumor: 5, id: 5, justify: "Teste", dateRegister: "2023-05-08 10:40:00"),
            ChartItem(codHumor: 4, id: 4, justify: "Teste", dateRegister: "2023-05-09 01:40:00"),
            ChartItem(codHumor: 1, id: 1, justify: "Teste", dateRegister: "2023-05-15 12:40:00"),
            ChartItem(codHumor: 6, id: 6, justify: "Teste", dateRegister: "2023-05-19 23:40:00"),
            ChartItem(codHumor: 8, id: 8, justify: "Teste", dateRegister: "2023-05-23 19:40:00"),
            ChartItem(codHumor: 9, id: 9, justify: "Teste", dateRegister: "2023-05-28 05:40:00"),
            ChartItem(codHumor: 3, id: 3, justify: "Teste", dateRegister: "2023-05-30 16:40:00")
        ]
        
        let data3 = MoodGraph(date: "Maio/2023", chart: charts3)
        
        self.listMoodGraph = [data1, data2, data3]
        
        // Mood Summary Data
        let happymood1 = MoodSummaryActivity(id: 1, type: .mood, title: "Feliz", subtitle: "9h10")
        let mission1 = MoodSummaryActivity(id: 2, type: .missions, title: "7", subtitle: "Missões realizadas")
        let certificate1 = MoodSummaryActivity(id: 3, type: .certificate, title: "Atestado médico", subtitle: "11h15")
        let tiredMood1 = MoodSummaryActivity(id: 4, type: .mood, title: "Cansado", subtitle: "17h25")
        let activities1 = [happymood1, mission1, certificate1, tiredMood1]
        let list1 = MoodSummary(date: "12.05.2022", activities: activities1)
        
        let happymood2 = MoodSummaryActivity(id: 1, type: .mood, title: "Triste", subtitle: "11h10")
        let mission2 = MoodSummaryActivity(id: 2, type: .missions, title: "2", subtitle: "Missões realizadas")
        let tiredMood2 = MoodSummaryActivity(id: 4, type: .mood, title: "Espantado", subtitle: "18h25")
        let activities2 = [happymood2, mission2, tiredMood2]
        let list2 = MoodSummary(date: "13.05.2022", activities: activities2)
        
        let happymood3 = MoodSummaryActivity(id: 1, type: .mood, title: "Feliz", subtitle: "9h10")
        let mission3 = MoodSummaryActivity(id: 2, type: .missions, title: "7", subtitle: "Missões realizadas")
        let certificate3 = MoodSummaryActivity(id: 3, type: .certificate, title: "Atestado médico", subtitle: "11h15")
        let activities3 = [happymood3, mission3, certificate3]
        let list3 = MoodSummary(date: "14.05.2022", activities: activities3)
        
        self.listMoodSummary = [list1, list2, list3]
    }
    
}
