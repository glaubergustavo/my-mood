//
//  MoodSummaryCell.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 09/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import UIKit

class MoodSummaryCell: UITableViewCell {
    
    @IBOutlet weak var imgMoodSummary: UIImageView?
    @IBOutlet weak var lblTitleMoodSummary: UILabel?
    @IBOutlet weak var lblSubtitleMoodSummary: UILabel?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    func loadUI(_ activities: MoodSummaryActivity) {
        
        switch activities.type {
            case .mood:
                self.imgMoodSummary?.image = setTitleMoodGraph(activities)
            case .missions:
            self.imgMoodSummary?.image = UIImage(named: Constants.Images.MissionsMoodSummary)
            case .certificate:
            self.imgMoodSummary?.image = UIImage(named: Constants.Images.CertificateMoodSummary)
        }
        
        lblTitleMoodSummary?.text = activities.title
        lblSubtitleMoodSummary?.text = activities.subtitle
    }
    
    private func setTitleMoodGraph(_ activities: MoodSummaryActivity) -> UIImage? {

        switch activities.title {
            case Constants.Messages.Lovesick:
                return UIImage(named: Constants.Images.LovesickImage)
            case Constants.Messages.Sleepy:
                return UIImage(named: Constants.Images.SleepyImage)
            case Constants.Messages.Funny:
                return UIImage(named: Constants.Images.FunnyImage)
            case Constants.Messages.Happy:
                return UIImage(named: Constants.Images.HappyImage)
            case Constants.Messages.Amazed:
                return  UIImage(named: Constants.Images.AmazedImage)
            case Constants.Messages.Tired:
                return UIImage(named: Constants.Images.TiredImage)
            case Constants.Messages.Sad:
                return UIImage(named: Constants.Images.SadImage)
            case Constants.Messages.Angry:
                return UIImage(named: Constants.Images.AngryImage)
            case Constants.Messages.Frustrated:
                return UIImage(named: Constants.Images.FrustratedImage)
            case Constants.Messages.Hungry:
                return UIImage(named: Constants.Images.HungryImage)
            case Constants.Messages.Sick:
                return UIImage(named: Constants.Images.SickImage)
            case Constants.Messages.Worried:
                return UIImage(named: Constants.Images.WorriedImage)
            default:
                break
        }

        return nil
    }
    
}
