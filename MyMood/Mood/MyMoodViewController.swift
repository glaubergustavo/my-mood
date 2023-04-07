//
//  MyMoodViewController.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 24/02/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import UIKit

@objc class MyMoodViewController: UIViewController,
                                  UITextViewDelegate,
                                  MyMoodPresenterDelegate {
    
    // MARK: -@IBOutlet View Thanks
    @IBOutlet weak var lblThanks: UILabel!
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var vwPopupThanks: UIView!
    @IBOutlet weak var btnExit: UIButton!
    @IBOutlet weak var btnSeeMoodData: UIButton!
    @IBOutlet weak var centerConstraint: NSLayoutConstraint!
    var centerYConstraint: NSLayoutConstraint?
    
    // MARK: -@IBOutlet ScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: -@IBOutlet Labels Text
    @IBOutlet weak var lblStatusMoodQuestion: UILabel!
    @IBOutlet weak var lblChooseMotives: UILabel!
    @IBOutlet weak var lblTextCount: UILabel!

    // MARK: -@IBOutlet Motives Views
    @IBOutlet weak var vwTransportation: UIView!
    @IBOutlet weak var vwSecurity: UIView!
    @IBOutlet weak var vwRelationship: UIView!
    @IBOutlet weak var vwFinance: UIView!
    @IBOutlet weak var vwStudies: UIView!
    @IBOutlet weak var vwHealth: UIView!
    @IBOutlet weak var vwPhysique: UIView!
    @IBOutlet weak var vwLeisure: UIView!
    @IBOutlet weak var vwPsychological: UIView!
    
    // MARK: -@IBOutlet Motives Labels
    @IBOutlet weak var lblTransportation: UILabel!
    @IBOutlet weak var lblSecurity: UILabel!
    @IBOutlet weak var lblRelationship: UILabel!
    @IBOutlet weak var lblFinance: UILabel!
    @IBOutlet weak var lblStudies: UILabel!
    @IBOutlet weak var lblHealth: UILabel!
    @IBOutlet weak var lblPhysique: UILabel!
    @IBOutlet weak var lblLeisure: UILabel!
    @IBOutlet weak var lblPsychological: UILabel!
    
    // MARK: -@IBOutlet Mood status Views
    @IBOutlet weak var imgMood: UIImageView!
    @IBOutlet weak var lblMood: UILabel!
    @IBOutlet weak var textViewComments: UITextView!
    
    // MARK: Variables
    var checkboxImage: UIImageView!
    
    var presenter: MyMoodPresenter!
    var selectedMotives: [Int] = []
    
    //-----------------------------------------------------------------------
    //  MARK: - Life Cycle
    //-----------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadUI()
    }
    //-----------------------------------------------------------------------
    //  MARK: - Custom Methods
    //-----------------------------------------------------------------------
    private func loadUI() {
        
        self.imgMood.image = UIImage(named: presenter.mood?.moodImg ?? "ic_triste")
        self.lblMood.text = presenter.mood?.moodName ?? Constants.Messages.Sad
    }
    
    private func configUI() {
        
        self.hideAnimationVwThanks()
        
        self.configNavBar()
        
        self.configLabels()
        
        self.configTextView()
        
        self.configMotifsViews()
    }
    
    private func hideAnimationVwThanks() {
        if self.centerYConstraint != nil {
            view.removeConstraint(self.centerYConstraint!)
        }

        self.centerYConstraint = NSLayoutConstraint(item: self.vwPopupThanks as Any,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 0)
        
        view.addConstraint(self.centerYConstraint!)

        self.vwBackground.alpha = 0
        self.vwPopupThanks.alpha = 0

        view.layoutIfNeeded()
    }
    
    private func showAnimationVwThanks() {
        
        if self.centerYConstraint != nil {
            self.view.removeConstraint(self.centerYConstraint!)
        }
        
        UIView.animate(withDuration: 0.5) {

            self.centerYConstraint = NSLayoutConstraint(item: self.vwPopupThanks as Any,
                                                        attribute: .centerY,
                                                        relatedBy: .equal,
                                                        toItem: self.view,
                                                        attribute: .centerY,
                                                        multiplier: 1,
                                                        constant: -100)

            self.view.addConstraint(self.centerYConstraint!)
            
            self.vwPopupThanks.alpha = 1
            self.vwBackground.alpha = 0.7
            
            self.view.layoutIfNeeded()
            self.view.layoutSubviews()
        }
    }
    
    private func configNavBar() {
        
        self.navigationItem.title = Constants.Messages.MyMood
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.blueColor()]
        
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        backBtn.setImage(UIImage(named: "left207"), for: .normal)
        backBtn.imageView?.image = backBtn.imageView?.image?.withTintColor(UIColor.blueColor())

        backBtn.addTarget(self, action: #selector(self.dismissView), for: .touchUpInside)
        backBtn.widthAnchor.constraint(equalToConstant: 25).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        let backBarBtn = UIBarButtonItem(customView: backBtn)
        
        self.navigationItem.leftBarButtonItem = backBarBtn
    }
    
    private func configTextView() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        self.textViewComments.delegate = self
        self.textViewComments.layer.cornerRadius = 12
        self.textViewComments.text = Constants.Messages.TellMore
    }
    
    private func configMotifsViews() {
        
        //View Transportation
        vwTransportation.tag = 1
        vwTransportation.layer.cornerRadius = 12
        vwTransportation.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        vwTransportation.layer.shadowOpacity = 1
        vwTransportation.layer.shadowOffset = CGSize(width: 0, height: 2)
        vwTransportation.layer.shadowRadius = 4
        
        //View Security
        vwSecurity.tag = 2
        vwSecurity.layer.cornerRadius = 12
        vwSecurity.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        vwSecurity.layer.shadowOpacity = 1
        vwSecurity.layer.shadowOffset = CGSize(width: 0, height: 2)
        vwSecurity.layer.shadowRadius = 4
        
        //View Relationship
        vwRelationship.tag = 3
        vwRelationship.layer.cornerRadius = 12
        vwRelationship.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        vwRelationship.layer.shadowOpacity = 1
        vwRelationship.layer.shadowOffset = CGSize(width: 0, height: 2)
        vwRelationship.layer.shadowRadius = 4
        
        //View Finance
        vwFinance.tag = 4
        vwFinance.layer.cornerRadius = 12
        vwFinance.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        vwFinance.layer.shadowOpacity = 1
        vwFinance.layer.shadowOffset = CGSize(width: 0, height: 2)
        vwFinance.layer.shadowRadius = 4
        
        //View Studies
        vwStudies.tag = 5
        vwStudies.layer.cornerRadius = 12
        vwStudies.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        vwStudies.layer.shadowOpacity = 1
        vwStudies.layer.shadowOffset = CGSize(width: 0, height: 2)
        vwStudies.layer.shadowRadius = 4
        
        //View Health
        vwHealth.tag = 6
        vwHealth.layer.cornerRadius = 12
        vwHealth.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        vwHealth.layer.shadowOpacity = 1
        vwHealth.layer.shadowOffset = CGSize(width: 0, height: 2)
        vwHealth.layer.shadowRadius = 4
        
        //View Physique
        vwPhysique.tag = 7
        vwPhysique.layer.cornerRadius = 12
        vwPhysique.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        vwPhysique.layer.shadowOpacity = 1
        vwPhysique.layer.shadowOffset = CGSize(width: 0, height: 2)
        vwPhysique.layer.shadowRadius = 4
        
        //View Leisure
        vwLeisure.tag = 8
        vwLeisure.layer.cornerRadius = 12
        vwLeisure.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        vwLeisure.layer.shadowOpacity = 1
        vwLeisure.layer.shadowOffset = CGSize(width: 0, height: 2)
        vwLeisure.layer.shadowRadius = 4
        
        //View Psychological
        vwPsychological.tag = 9
        vwPsychological.layer.cornerRadius = 12
        vwPsychological.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        vwPsychological.layer.shadowOpacity = 1
        vwPsychological.layer.shadowOffset = CGSize(width: 0, height: 2)
        vwPsychological.layer.shadowRadius = 4
        
        let arrayOfViews = [vwHealth, vwFinance, vwLeisure, vwStudies, vwSecurity, vwPhysique, vwPsychological, vwRelationship, vwTransportation]
        
        for view in arrayOfViews {
            self.checkboxImage = UIImageView(image: UIImage(named: "icon_check_green"))
            self.checkboxImage.frame = CGRect(x: 74, y: 6, width: 12, height: 12)
            self.checkboxImage.isHidden = true
            self.checkboxImage.tag = 1
            view?.addSubview(self.checkboxImage)

            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
            view?.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    private func configLabels() {
        
        // Labels View Thanks
        self.lblThanks.text = Constants.Messages.Thanks
        self.btnSeeMoodData.setTitle(Constants.Messages.SeeDataMood, for: .normal)
        self.btnExit.setTitle(Constants.Messages.Exit, for: .normal)
        
        // Labels Text
        self.lblStatusMoodQuestion.text = Constants.Messages.FeelingToday
        self.lblChooseMotives.text = Constants.Messages.ChooseMotives
        self.lblTextCount.text = Constants.Messages.AvailableCharacters
        
        // Motives Labels
        self.lblTransportation.text = Constants.Messages.Transportation
        self.lblSecurity.text = Constants.Messages.Security
        self.lblRelationship.text = Constants.Messages.Relationship
        self.lblFinance.text = Constants.Messages.Finance
        self.lblStudies.text = Constants.Messages.Studies
        self.lblHealth.text = Constants.Messages.Health
        self.lblPhysique.text = Constants.Messages.Physique
        self.lblLeisure.text = Constants.Messages.Leisure
        self.lblPsychological.text = Constants.Messages.Psychological
    }
    
    @objc func viewTapped(sender: UITapGestureRecognizer) {
        if let view = sender.view {
            self.configSelectedMotifs(view: view)
            for subview in view.subviews {
                if let imageView = subview as? UIImageView {
                    if imageView.tag == 1 {
                        imageView.isHidden = !imageView.isHidden
                        
                        if imageView.isHidden {
                            
                            if let index = selectedMotives.firstIndex(of: view.tag) {
                                selectedMotives.remove(at: index)
                            }
                            
                            UIView.animate(withDuration: 0.3, animations: {
                                view.transform = CGAffineTransform.identity
                                
                            })
                        }else {
                            
                            self.selectedMotives.append(view.tag)
                            
                            UIView.animate(withDuration: 0.3, animations: {
                                view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                                view.layer.shadowOpacity = 1
                                view.layer.shadowOffset = CGSize(width: 0, height: 2)
                                view.layer.shadowRadius = 4
                            })
                        }
                    }
                }
            }
        }
    }
    
    private func configSelectedMotifs(view: UIView) {
        
        switch view {
            case self.vwTransportation:
                self.presenter.transportSelected = !self.presenter.transportSelected
            case self.vwSecurity:
                self.presenter.securitySelected = !self.presenter.securitySelected
            case self.vwRelationship:
                self.presenter.realationshipsSelected = !self.presenter.realationshipsSelected
            case self.vwFinance:
                self.presenter.financeSelected = !self.presenter.financeSelected
            case self.vwStudies:
                self.presenter.studiesSelected = !self.presenter.studiesSelected
            case self.vwHealth:
                self.presenter.healthSelected = !self.presenter.healthSelected
            case self.vwPhysique:
                self.presenter.physiqueSelected = !self.presenter.physiqueSelected
            case self.vwLeisure:
                self.presenter.leisureSelected = !self.presenter.leisureSelected
            case self.vwPsychological:
                self.presenter.psychologicalSelected = !self.presenter.psychologicalSelected
            default:
                break
        }
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func dismissView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    //-----------------------------------------------------------------------
    // MARK: MyMoodPresenterDelegate
    //-----------------------------------------------------------------------
    
    func showCongratulations() {
        self.showAnimationVwThanks()
    }
    
    func showError(_ strError: String) {}
    
    //-----------------------------------------------------------------------
    // MARK: UITextView Delegate
    //-----------------------------------------------------------------------
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == Constants.Messages.TellMore {
            self.textViewComments.text = ""
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let total = textView.text.count - range.length + text.count
            
            if total > 160 {
                return false
            }
        
            let availables = 160 - total
        self.lblTextCount.text = String(format: "%@ %i %@.", Constants.Messages.Available, availables, Constants.Messages.Characters)
        
        return true
    }
    
    //-----------------------------------------------------------------------
    // MARK: -@IBAction Advance to next screen
    //-----------------------------------------------------------------------

    @IBAction func saveMood(_ sender: Any) {
        presenter.saveMood()
    }
    
    @IBAction func seeMoodData(_ sender: Any) {
        presenter.showMyMoodGraph(nav: self.navigationController!)
    }
    
    @IBAction func exit(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
}
