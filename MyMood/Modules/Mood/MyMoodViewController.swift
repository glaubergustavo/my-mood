//
//  MyMoodViewController.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 24/02/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import UIKit
import Lottie

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
    @IBOutlet weak var actLoading: UIActivityIndicatorView!
    
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
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadUI()
    }
    //-----------------------------------------------------------------------
    //  MARK: - Custom Methods
    //-----------------------------------------------------------------------
    private func loadUI() {
        
        imgMood.image = UIImage(named: presenter.mood?.moodImg ?? Constants.Images.SadImage)
        lblMood.text = presenter.mood?.moodName ?? Constants.Messages.Sad
    }
    
    private func configUI() {
        
        hideAnimationVwThanks()
        configNavBar()
        configLabels()
        configTextView()
        configMotifsViews()
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
        
        configAnimationPopupThanks()
        
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
            
            self.navigationController?.navigationBar.alpha = 0
            self.vwPopupThanks.alpha = 1
            self.vwBackground.alpha = 0.7
            
            self.view.layoutIfNeeded()
            self.view.layoutSubviews()
        }
    }
    
    private func configAnimationPopupThanks() {
        
        var animationViewThanks = LottieAnimationView()
        animationViewThanks = LottieAnimationView(name: Constants.Animations.CongratulationsAnimation)
        animationViewThanks.loopMode = .loop
        animationViewThanks.contentMode = .scaleAspectFill
        animationViewThanks.animationSpeed = 1.0
        animationViewThanks.play()
        vwPopupThanks.addSubview(animationViewThanks)
        
        animationViewThanks.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationViewThanks.topAnchor.constraint(equalTo: vwPopupThanks.topAnchor, constant: 30),
            animationViewThanks.leadingAnchor.constraint(equalTo: vwPopupThanks.leadingAnchor, constant: 30),
            animationViewThanks.trailingAnchor.constraint(equalTo: vwPopupThanks.trailingAnchor, constant: -30),
            animationViewThanks.bottomAnchor.constraint(equalTo: btnSeeMoodData.topAnchor, constant: -10)
            ])
    }
    
    private func configNavBar() {
        
        self.navigationController?.navigationBar.alpha = 1
        self.navigationItem.title = Constants.Messages.MyMood
        self.navigationController?.navigationBar.titleTextAttributes =
        [NSAttributedString.Key.foregroundColor: UIColor.yellowColor()]
        
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        backBtn.setImage(UIImage(named: Constants.Images.LeftButton), for: .normal)
        backBtn.imageView?.image = backBtn.imageView?.image?.withTintColor(UIColor.yellowColor())
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
        
        vwTransportation.configViewAppearance(with: 1)
        vwSecurity.configViewAppearance(with: 2)
        vwRelationship.configViewAppearance(with: 3)
        vwFinance.configViewAppearance(with: 4)
        vwStudies.configViewAppearance(with: 5)
        vwHealth.configViewAppearance(with: 6)
        vwPhysique.configViewAppearance(with: 7)
        vwLeisure.configViewAppearance(with: 8)
        vwPsychological.configViewAppearance(with: 9)
        
        configAnimationsMotifs()
        configCheckboxImage()
    }
    
    private func configCheckboxImage() {
        
        let arrayOfViews = [vwHealth, vwFinance, vwLeisure, vwStudies, vwSecurity, vwPhysique, vwPsychological, vwRelationship, vwTransportation]
        
        for view in arrayOfViews {
            self.checkboxImage = UIImageView(image: UIImage(named: Constants.Images.iconCheckGreen))
            self.checkboxImage.frame = CGRect(x: 74, y: 6, width: 12, height: 12)
            self.checkboxImage.isHidden = true
            self.checkboxImage.tag = 1
            view?.addSubview(self.checkboxImage)

            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
            view?.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    
    private func configAnimationsMotifs() {
        
        showLoading(true)
        
        DispatchQueue.main.async {
            
            let animations: [(name: String, view: UIView, frame: CGRect)] = [
                            (name: Constants.Animations.TransportationAnimation, view: self.vwTransportation, frame: CGRect(x: 0, y: 0, width: 90, height: 90)),
                            (name: Constants.Animations.SecurityAnimation, view: self.vwSecurity, frame: CGRect(x: -5, y: -5, width: 100, height: 100)),
                            (name: Constants.Animations.RelationshipAnimation, view: self.vwRelationship, frame: CGRect(x: 0, y: 0, width: 90, height: 90)),
                            (name: Constants.Animations.FinanceAnimation, view: self.vwFinance, frame: CGRect(x: 0, y: 0, width: 90, height: 90)),
                            (name: Constants.Animations.StudiesAnimation, view: self.vwStudies, frame: CGRect(x: 10, y: 5, width: 70, height: 70)),
                            (name: Constants.Animations.HealthAnimation, view: self.vwHealth, frame: CGRect(x: 10, y: 5, width: 75, height: 75)),
                            (name: Constants.Animations.PhysiqueAnimation, view: self.vwPhysique, frame: CGRect(x: 0, y: -5, width: 90, height: 90)),
                            (name: Constants.Animations.LeisureAnimation, view: self.vwLeisure, frame: CGRect(x: 10, y: -5, width: 80, height: 80)),
                            (name: Constants.Animations.PsychologicalAnimation, view: self.vwPsychological, frame: CGRect(x: 10, y: 0, width: 80, height: 80))
            ] as [(name: String, view: UIView, frame: CGRect)]
            
            for animation in animations {
                LottieAnimationView.setup(withName: animation.name, frame: animation.frame, addToView: animation.view)
            }
            
            self.showLoading(false)
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
        guard let view = sender.view else { return }
        
        self.configSelectedMotifs(view: view)
        
        for subview in view.subviews {
            
            if let imageView = subview as? UIImageView,
               imageView.tag == 1 {
                
                self.configAnimationsMotifs(view: view, imageView: imageView)
            }
        }
    }
    
    private func configAnimationsMotifs(view: UIView, imageView: UIImageView) {
        
        imageView.isHidden = !imageView.isHidden
        
        if imageView.isHidden {
            
            if let index = selectedMotives.firstIndex(of: view.tag) {
                selectedMotives.remove(at: index)
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                view.transform = CGAffineTransform.identity
                view.layer.shadowOpacity = 1
                view.layer.shadowOffset = CGSize(width: 0, height: 2)
                view.layer.shadowRadius = 4
            })
        }else {
            
            self.selectedMotives.append(view.tag)
            
            UIView.animate(withDuration: 0.3, animations: {
                view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                view.layer.shadowOpacity = 1
                view.layer.shadowOffset = CGSize(width: 0, height: -5)
                view.layer.shadowRadius = 4
            })
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
    
    private func showLoading(_ loading: Bool) {
        
        if loading {
            actLoading.startAnimating()
        }else {
            actLoading.stopAnimating()
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
            self.textViewComments.text = Constants.Messages.Empty
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let total = textView.text.count - range.length + text.count
            
            if total > 160 {
                return false
            }
        
            let availables = 160 - total
        self.lblTextCount.text = String(format: Constants.Messages.textConcatenation, Constants.Messages.Available, availables, Constants.Messages.Characters)
        
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
