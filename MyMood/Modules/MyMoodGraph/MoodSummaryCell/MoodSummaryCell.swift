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
                switch activities.title {
                    case "Feliz":
                        self.imgMoodSummary?.image = UIImage(named: "ic_feliz")
                    case "Cansado":
                        self.imgMoodSummary?.image = UIImage(named: "ic_entediado")
                    case "Espantado":
                        self.imgMoodSummary?.image = UIImage(named: "ic_espantado")
                    case "Triste":
                        self.imgMoodSummary?.image = UIImage(named: "ic_triste")
                    default:
                        break
                    }
            case .missions:
                    self.imgMoodSummary?.image = UIImage(named: "missions_mood_summary")
            case .certificate:
                    self.imgMoodSummary?.image = UIImage(named: "certificate_mood_summary")
        }
        
        lblTitleMoodSummary?.text = activities.title
        lblSubtitleMoodSummary?.text = activities.subtitle
    }
    
}
