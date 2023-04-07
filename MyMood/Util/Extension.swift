//
//  Extension.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 08/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static func blueColor() -> UIColor {
        return UIColor.init(red: 50/255, green: 173/255, blue: 230/255, alpha: 1)
    }
}

extension UIImage {
    func resized(to size: CGSize) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}

extension UIView {
    func roundCorners(_ corners: CACornerMask, radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.maskedCorners = corners
    }
}

extension String {
    func convertStringToDay() -> Double? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            let dayOfMonth = Calendar.current.component(.day, from: date)
            return Double(dayOfMonth)
        }
        return nil
    }
    
    func convertStringToDayAndMonth() -> String? {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
           if let date = dateFormatter.date(from: self) {
               dateFormatter.dateFormat = "dd/MM"
               let dayAndMonth = dateFormatter.string(from: date)
               return dayAndMonth
           }
           return nil
       }
   
    
    func convertStringToHour() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            let hourFormatter = DateFormatter()
            hourFormatter.dateFormat = "HH:mm"
            let formattedHour = hourFormatter.string(from: date)
            return formattedHour
        }
        return nil
    }
    
    func convertStringToHourMood() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            let hourFormatter = DateFormatter()
            hourFormatter.dateFormat = "HH"
            let formattedHour = hourFormatter.string(from: date)
            return formattedHour
        }
        return "0"
    }
    
    func convertStringToPeriod() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            let hour = Calendar.current.component(.hour, from: date)
            switch hour {
            case 0..<6:
                return "Madrugada"
            case 6..<12:
                return "Manhã"
            case 12..<18:
                return "Tarde"
            default:
                return "Noite"
            }
        }
        return nil
    }

    func convertStringToDate(_ dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: dateString) {
            let outputFormatter = DateFormatter()
            outputFormatter.dateFormat = "EEEE, dd/MM/yyyy"
            return outputFormatter.string(from: date)
        }
        return nil
    }
}

