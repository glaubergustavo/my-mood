//
//  MyMoodPresenter.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 26/02/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import UIKit

protocol MyMoodPresenterDelegate {
    func showCongratulations()
    func showError(_ strError: String)
}

class MyMoodPresenter: NSObject {
    
    var mood: Mood!
    var transportSelected = false
    var securitySelected = false
    var realationshipsSelected = false
    var financeSelected = false
    var studiesSelected = false
    var healthSelected = false
    var physiqueSelected = false
    var leisureSelected = false
    var psychologicalSelected = false
    
    var delegate: MyMoodPresenterDelegate?
    
    init (delegate: MyMoodPresenterDelegate?) {
        self.delegate = delegate
    }
    func saveMood() {
        UtilFacade.setLastMood(cod: mood.moodCod)
        self.delegate?.showCongratulations()
    }
    
    func showMyMoodGraph(nav: UINavigationController) {
        MyMoodRouter().showMyMoodGraph(nav: nav)
    }
}
