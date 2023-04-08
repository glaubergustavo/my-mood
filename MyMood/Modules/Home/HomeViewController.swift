//
//  HomeViewController.swift
//  RickAndMortyApp
//
//  Created by Glauber Gustavo on 11/03/23.
//

import UIKit

class HomeViewController: UIViewController,
                          HomePresenterDelegate {
    
    
    @IBOutlet weak var imgEmojis: UIImageView!
    @IBOutlet weak var cvMoodsCollection: UICollectionView!
    
    var presenter: HomePresenter!
    var centerYConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadUI()
        presenter.presentLastMood()
        showAnimation()
    }
    
    private func loadUI() {
        presenter.loadData()
    }
    
    private func configUI() {

        cvMoodsCollection.register(UINib(nibName: Constants.cellIdentifier.MoodCell, bundle: Bundle.main), forCellWithReuseIdentifier: Constants.cellIdentifier.MoodCell)
    }
    
    private func showAnimation() {
        
        if self.centerYConstraint != nil {
            self.view.removeConstraint(self.centerYConstraint!)
        }
        
        UIView.animate(withDuration: 0.7) {
            
            self.centerYConstraint = NSLayoutConstraint(item: self.imgEmojis as Any,
                                                        attribute: .centerY,
                                                        relatedBy: .equal,
                                                        toItem: self.view,
                                                        attribute: .centerY,
                                                        multiplier: 1,
                                                        constant: 0)
            
            self.view.addConstraint(self.centerYConstraint!)
            
            self.view.layoutIfNeeded()
            self.view.layoutSubviews()
        }
    }
    
    // MARK: - HomePresenterDelegate
    
    func dataLoaded(row: Int) {
        let indexPath = IndexPath(row: row, section: 0)
        
        self.cvMoodsCollection.reloadData()
        self.cvMoodsCollection.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func showCollectionView(_ show: Bool) {
        
        if show {
            UIView.animate(withDuration: 1.0) {
                self.cvMoodsCollection.alpha = 1
            }
        }else {
            UIView.animate(withDuration: 1.0) {
                self.cvMoodsCollection.alpha = 0
            }
        }
    }
    
    func showLoading(_ loading: Bool) {}
    
    func showNotFoundMessage() {}
    
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier.MoodCell, for: indexPath) as! MoodCell
        
        cell.loadUI(presenter.moods[indexPath.row])
        
        return cell
    }
    
    // UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mood = indexPath.row + 1
        
        presenter.showMyMood(nav: self.navigationController!, mood: presenter.moods[indexPath.row])
        presenter.moodSelected = mood
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
