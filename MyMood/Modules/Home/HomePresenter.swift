//
//  HomePresenter.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import Foundation
import UIKit

protocol HomePresenterDelegate: AnyObject {
    func dataLoaded(row: Int)
    func showLoading(_ loading: Bool)
    func showNotFoundMessage()
    func showCollectionView(_ show: Bool)
}

class HomePresenter {
    
    var moods: [Mood] = []
    var moodSelected = 0
    
    var numberOfRows: Int {
        return moods.count
    }
    
    var delegate: HomePresenterDelegate?
    
    func loadData() {
        
        self.delegate?.showCollectionView(false)
        
        if let data = UtilFacade.getMoods() {
            if let savedMoods = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Mood] {
                self.moods = savedMoods
            }
        }
        
        if moodSelected == 0 {
            moods = [
                Mood(moodImg: Constants.Images.LovesickImage, moodName: Constants.Messages.Lovesick, moodCod: 1),
                Mood(moodImg: Constants.Images.SleepyImage, moodName: Constants.Messages.Sleepy, moodCod: 2),
                Mood(moodImg: Constants.Images.FunnyImage, moodName: Constants.Messages.Funny, moodCod: 3),
                Mood(moodImg: Constants.Images.HappyImage, moodName: Constants.Messages.Happy, moodCod: 4),
                Mood(moodImg: Constants.Images.AmazedImage, moodName: Constants.Messages.Amazed, moodCod: 5),
                Mood(moodImg: Constants.Images.TiredImage, moodName: Constants.Messages.Tired, moodCod: 6),
                Mood(moodImg: Constants.Images.SadImage, moodName: Constants.Messages.Sad, moodCod: 7),
                Mood(moodImg: Constants.Images.AngryImage, moodName: Constants.Messages.Angry, moodCod: 8),
                Mood(moodImg: Constants.Images.FrustratedImage, moodName: Constants.Messages.Frustrated, moodCod: 9),
                Mood(moodImg: Constants.Images.HungryImage, moodName: Constants.Messages.Hungry, moodCod:10),
                Mood(moodImg: Constants.Images.SickImage, moodName: Constants.Messages.Sick, moodCod: 11),
                Mood(moodImg: Constants.Images.WorriedImage, moodName: Constants.Messages.Worried, moodCod: 12)
            ]
        }
        
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: moods, requiringSecureCoding: false) {
            UtilFacade.setMoods(data)
        }
        
        self.delegate?.showCollectionView(true)

    }
    
    func presentLastMood() {
        
        guard let cod = UtilFacade.getLastMood(), cod >= 0, !moods.isEmpty else { return }
        
        moodSelected = cod
        
        for i in 0..<moods.count {
            moods[i].selected = false
            
            if moods[i].moodCod == moodSelected {
                moods[i].selected = true
                
                if let data = try? NSKeyedArchiver.archivedData(withRootObject: moods, requiringSecureCoding: false) {
                    UtilFacade.setMoods(data)
                }
                
                self.delegate?.dataLoaded(row: i)
            }
        }
    }
    
    func showMyMood(nav:UINavigationController, mood: Mood) {
        HomeRouter().showMyMood(nav: nav, mood: mood)
    }
}
