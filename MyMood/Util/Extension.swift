//
//  Extension.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 08/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import Foundation
import UIKit
import Charts

extension UIColor {
    static func yellowColor() -> UIColor {
        return UIColor.init(red: 255/255, green: 204/255, blue: 0/255, alpha: 1)
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
    
    func convertStringToPeriod() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            let hour = Calendar.current.component(.hour, from: date)
            switch Double(hour) {
            case 0.0..<6.0:
                return Constants.Messages.Dawn
            case 6.0..<12.0:
                return Constants.Messages.Morning
            case 12.0..<18.0:
                return Constants.Messages.Afternoon
            default:
                return Constants.Messages.Night
            }
        }
        return Constants.Messages.Empty
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

