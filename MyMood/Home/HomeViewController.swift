//
//  HomeViewController.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import UIKit

class HomeViewController: UIViewController,
                          HomePresenterDelegate,
                          MoodCollectionDelegate {
    
    @IBOutlet weak var vwMoodContainer: UIView!
    
    var moodCollectionView: MoodCollectionViewController!
    var presenter: HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
        loadUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presentLastMood()
    }
    
    private func loadUI() {}
    
    private func configUI() {
                
        configMoodView()
    }
    
    private func configMoodView() {
        
        let moodVC = MoodCollectionViewController(nibName: "MoodCollection", bundle: Bundle.main)
        moodVC.delegate = self
        self.vwMoodContainer.addSubview(moodVC.view)
        self.addChild(moodVC)
        self.moodCollectionView = moodVC

    }
    
    private func presentLastMood() {
        if let cod = UtilFacade.getLastMood() {
            self.moodCollectionView.selecteMood(cod: cod)
        }
    }

    
    // MARK: - HomePresenterDelegate
    
    func dataLoaded() {}
    
    func showCollectionView(_ show: Bool) {
        
        if show {
            UIView.animate(withDuration: 2.0) {}
        }else {
            UIView.animate(withDuration: 2.0) {}
        }
    }
    
    func showLoading(_ loading: Bool) {
        
        if loading {} else {}
    }
    
    func showNotFoundMessage() {}
    
    //MARK: - MoodCollectionDelegate
    
    func showMoodDetail(_ mood: Mood) {
        presenter.showMyMood(nav: self.navigationController!, mood: mood)
    }
    
}
