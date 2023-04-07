//
//  MoodCollectionPresenter.swift
//  MyMood
//
//  Created by Glauber Gustavo on 07/04/23.
//

import Foundation

protocol MoodCollectionPresenterDelegate {
    func dataLoaded()
}
class MoodCollectionPresenter {
    
    var delegate: MoodCollectionPresenterDelegate?
    
    func loadMoods() {
        
    }
}
