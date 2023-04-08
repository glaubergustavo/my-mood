//
//  MyMoodRouterSwift.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 25/02/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import UIKit

@objc class MyMoodRouter: NSObject {
    
    var viewController: UIViewController!
    var storyboard: UIStoryboard!
    
    override init() {

        storyboard = UIStoryboard(name: "MyMood", bundle: nil)

        if let controller = storyboard?.instantiateViewController(withIdentifier: "MyMoodView") as? MyMoodViewController {
            
            let presenter = MyMoodPresenter(delegate: controller)
            
            controller.presenter = presenter
            
            self.viewController = controller
        }
    }
    
    @objc func show(nav: UINavigationController, mood: Mood) {
       (self.viewController as? MyMoodViewController)?.presenter.mood = mood
       nav.pushViewController(self.viewController, animated: true)
    }
    
    @objc func showMyMoodGraph(nav: UINavigationController) {
        MyMoodGraphRouter().show(nav: nav)
    }
}
