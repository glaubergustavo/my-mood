//
//  MoodObject.swift
//  MyMood
//
//  Created by Glauber Gustavo on 29/03/23.
//

import Foundation

class Mood: NSObject, NSCoding {
    var moodImg: String
    var moodName: String
    var moodCod: Int
    var selected: Bool
    
    init(moodImg: String, moodName: String, moodCod: Int) {
        self.moodImg = moodImg
        self.moodName = moodName
        self.moodCod = moodCod
        self.selected = false
    }
    
    // MARK: - NSCoding
    func encode(with coder: NSCoder) {
        coder.encode(moodImg, forKey: Constants.NSCoding.KeyMoodImg)
        coder.encode(moodName, forKey: Constants.NSCoding.KeyMoodName)
        coder.encode(moodCod, forKey: Constants.NSCoding.KeyMoodCod)
        coder.encode(selected, forKey: Constants.NSCoding.KeySelected)
    }
    
    required init?(coder: NSCoder) {
        self.moodImg = coder.decodeObject(forKey: Constants.NSCoding.KeyMoodImg) as? String ?? Constants.Messages.Empty
        self.moodName = coder.decodeObject(forKey: Constants.NSCoding.KeyMoodName) as? String ?? Constants.Messages.Empty
        self.moodCod = coder.decodeInteger(forKey: Constants.NSCoding.KeyMoodCod)
        self.selected = coder.decodeBool(forKey: Constants.NSCoding.KeySelected)
    }
}


