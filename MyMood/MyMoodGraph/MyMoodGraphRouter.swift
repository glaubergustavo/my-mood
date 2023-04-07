//
//  MyMoodGraphRouter.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 03/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import UIKit

class MyMoodGraphRouter: NSObject {
    
    var viewController: UIViewController!
    var storyboard: UIStoryboard!
    
    override init() {
        
        storyboard = UIStoryboard(name: "MyMoodGraphView", bundle: nil)
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "MyMoodGraphView") as? MyMoodGraphViewController {
            
            let presenter = MyMoodGraphPresenter(delegate: controller as? MyMoodGraphPresenterDelegate)
            
            controller.presenter = presenter
            
            self.viewController = controller
        }
        
    }
    
    @objc func show(nav: UINavigationController) {
        nav.pushViewController(self.viewController, animated: true)
    }
    
    func showMyMood(nav:UINavigationController, mood: Mood) {
        MyMoodRouter().show(nav: nav, mood: mood)
    }
}
