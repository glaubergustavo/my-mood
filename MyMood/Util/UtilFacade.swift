//
//  UtilFacade.swift
//  MyMood
//
//  Created by Glauber Gustavo on 06/04/23.
//

import Foundation

class UtilFacade {
    
    class func getMoods() -> Data? {
        return UserDefaults.standard.object(forKey: "moods") as? Data
    }
    
    class func setMoods(_ moods: Data) {
        UserDefaults.standard.set(moods, forKey: "moods")
        UserDefaults.standard.synchronize()
    }
    
    class func getLastMood() -> Int? {
        return UserDefaults.standard.object(forKey: "lastMood") as? Int
    }

    class func setLastMood(cod: Int) {
        UserDefaults.standard.set(cod, forKey: "lastMood")
        UserDefaults.standard.synchronize()
    }

}
