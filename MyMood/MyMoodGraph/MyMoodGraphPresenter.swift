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
    
    var moodGraph: MoodGraph!
    var listMoodGraph: [MoodGraph] = []
    var chartList: [ChartItem] = []
    var chart: ChartItem!
    
    var listMoodSummary: [MoodSummary]!
    var moodSummary: MoodSummary!
    var delegate: MyMoodGraphPresenterDelegate?
//    private lazy var manager: MyMoodGraphManager = {
//        return MyMoodGraphManager()
//    }()
    
    init (delegate: MyMoodGraphPresenterDelegate?) {
        self.delegate = delegate
        
    }
    
    func loadData() {
        
        let calendar = Calendar.current
        let endDate = Date() // Data atual
        let startDate = calendar.date(byAdding: .day, value: -7, to: endDate)!
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        MyMoodGraphManager().loadMoods(startDate: startDateString,
                          endDate: endDateString) { [self] chartItems, error  in
            if let chartItems = chartItems {
                self.chartList = chartItems
                self.delegate?.dataLoaded()
            } else {
                self.delegate?.showError(error!)
            }
        }
        
        
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
    
    func showMyMood(nav:UINavigationController, mood:Mood) {
        MyMoodGraphRouter().showMyMood(nav:nav, mood:mood)
    }
}
