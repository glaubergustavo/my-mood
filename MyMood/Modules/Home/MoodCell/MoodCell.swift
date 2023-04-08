//
//  MoodCell.swift
//  Victory Health
//
//  Created by Chrystian Salgado on 31/10/22.
//  Copyright © 2022 MadeinWeb. All rights reserved.
//

import Foundation
import UIKit

final class MoodCell: UICollectionViewCell {
    
    @IBOutlet weak var moodImg: UIImageView!
    @IBOutlet weak var moodImgBg: UIView!
    @IBOutlet weak var moodBoorder: UIView!
    @IBOutlet weak var moodBottomBoorder: UIView!
    @IBOutlet weak var moodLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        moodImgBg.layer.borderColor = UIColor.yellowColor().cgColor
    }
    
    func loadUI(_ mood: Mood) {
        moodImg.image = UIImage(named: mood.moodImg)
        moodLbl.text = mood.moodName
        
        contentView.alpha = 0.5
        moodBoorder.layer.borderWidth = 3.0
        moodBoorder.layer.borderColor = UIColor.clear.cgColor
        moodBoorder.backgroundColor = .clear
        
        moodBottomBoorder.alpha = 0
        
        if mood.selected {
            moodBoorder.layer.borderColor = UIColor.yellowColor().cgColor
            moodBoorder.backgroundColor = .white
            moodImgBg.layer.cornerRadius = moodImgBg.frame.height / 2
            contentView.alpha = 1
        } else {
            moodImgBg.layer.cornerRadius = 0
            moodImgBg.layer.borderWidth = 0
            moodLbl.textColor = .darkGray
            contentView.alpha = 0.5
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.0) {
            self.layoutIfNeeded()
        }
    }
}
