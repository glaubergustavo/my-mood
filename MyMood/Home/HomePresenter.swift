//
//  HomePresenter.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import Foundation
import UIKit

protocol HomePresenterDelegate: AnyObject {
    func dataLoaded()
    func showLoading(_ loading: Bool)
    func showNotFoundMessage()
    func showCollectionView(_ show: Bool)
}

class HomePresenter {
    
    var page: Int = 1
    var total: Int = 0
    
    var numberOfRows: Int {
        return 1
    }
    
    var delegate: HomePresenterDelegate?
    
    func showMyMood(nav:UINavigationController, mood: Mood) {
        HomeRouter().showMyMood(nav: nav, mood: mood)
    }
}
