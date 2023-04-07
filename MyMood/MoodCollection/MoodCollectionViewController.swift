//
//  MoodCollectionViewController.swift
//  MyMood
//
//  Created by Glauber Gustavo on 29/03/23.
//

import UIKit

protocol MoodCollectionDelegate: AnyObject {
    func showMoodDetail(_ mood: Mood)
}

class MoodCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: MoodCollectionDelegate?
    private var moods: [Mood] = []
    private let reuseIdentifier = "MoodCell"
    private var moodSelected = 0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let superview = view.superview {
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: superview.topAnchor).isActive = true
            view.leftAnchor.constraint(equalTo: superview.leftAnchor).isActive = true
            view.rightAnchor.constraint(equalTo: superview.rightAnchor).isActive = true
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor).isActive = true
        }
        
        collectionView.register(UINib(nibName: reuseIdentifier, bundle: Bundle.main), forCellWithReuseIdentifier: reuseIdentifier)
        
        if let data = UtilFacade.getMoods() {
            if let savedMoods = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [Mood] {
                self.moods = savedMoods
            }
        }
        
        if moodSelected == 0 {
            moods = [
                Mood(moodImg: "ic_apaixonado", moodName: Constants.Messages.Lovesick, moodCod: 1),
                Mood(moodImg: "ic_sono", moodName: Constants.Messages.Sleepy, moodCod: 2),
                Mood(moodImg: "ic_engracado", moodName: Constants.Messages.Funny, moodCod: 3),
                Mood(moodImg: "ic_feliz", moodName: Constants.Messages.Happy, moodCod: 4),
                Mood(moodImg: "ic_espantado", moodName: Constants.Messages.Amazed, moodCod: 5),
                Mood(moodImg: "ic_entediado", moodName: Constants.Messages.Tired, moodCod: 6),
                Mood(moodImg: "ic_triste", moodName: Constants.Messages.Sad, moodCod: 7),
                Mood(moodImg: "ic_raiva", moodName: Constants.Messages.Angry, moodCod: 8),
                Mood(moodImg: "ic_frustrado", moodName: Constants.Messages.Frustrated, moodCod: 9),
                Mood(moodImg: "ic_fome", moodName: Constants.Messages.Hungry, moodCod:10),
                Mood(moodImg: "ic_doente", moodName: Constants.Messages.Sick, moodCod: 12),
                Mood(moodImg: "ic_preocupado", moodName: Constants.Messages.Worried, moodCod: 13)
            ]
            if let data = try? NSKeyedArchiver.archivedData(withRootObject: moods, requiringSecureCoding: false) {
                UtilFacade.setMoods(data)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func selecteMood(cod: Int) {
        if cod < 0 || moods.isEmpty { return }
        moodSelected = cod
        var indexPath = IndexPath(row: 0, section: 0)
        for i in 0..<moods.count {
            moods[i].selected = false
            if moods[i].moodCod == moodSelected {
                moods[i].selected = true
                indexPath = IndexPath(row: i, section: 0)
            }
        }
        
        if let data = try? NSKeyedArchiver.archivedData(withRootObject: moods, requiringSecureCoding: false) {
            UtilFacade.setMoods(data)
        }
        self.collectionView.reloadData()
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func error(_ errorMsg: String) {}
}

extension MoodCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
              
    // UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.moods.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MoodCell
        
        cell.loadUI(self.moods[indexPath.row])
        
        return cell
    }
    
    // UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mood = indexPath.row + 1
        
        self.delegate?.showMoodDetail(self.moods[indexPath.row])
        moodSelected = mood
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
