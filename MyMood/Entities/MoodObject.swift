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
        coder.encode(moodImg, forKey: "moodImg")
        coder.encode(moodName, forKey: "moodName")
        coder.encode(moodCod, forKey: "moodCod")
        coder.encode(selected, forKey: "selected")
    }
    
    required init?(coder: NSCoder) {
        self.moodImg = coder.decodeObject(forKey: "moodImg") as? String ?? ""
        self.moodName = coder.decodeObject(forKey: "moodName") as? String ?? ""
        self.moodCod = coder.decodeInteger(forKey: "moodCod")
        self.selected = coder.decodeBool(forKey: "selected")
    }
}


