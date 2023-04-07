//
//  MyMoodGraphViewController.swift
//  Victory Health
//
//  Created by Glauber Gustavo on 03/03/23.
//  Copyright © 2023 MadeinWeb. All rights reserved.
//

import UIKit

class MyMoodGraphViewController: UIViewController,
                                 UITableViewDelegate,
                                 UITableViewDataSource,
                                 MoodCollectionDelegate,
                                 MoodChartCellDelegate,
                                 MyMoodGraphPresenterDelegate {
    
    // MARK: -@IBOutlet Mood Line View
    @IBOutlet weak var vwMoodLine: UIView!
    @IBOutlet weak var lblMoodLine: UILabel!
    @IBOutlet weak var vwHeaderMoodLine: UIView!
    @IBOutlet weak var lblMonthYearMoodLine: UILabel!
    @IBOutlet weak var btnLeftArrowMoodLine: UIButton!
    @IBOutlet weak var btnRighArrowMoodLine: UIButton!
    @IBOutlet weak var vwGraphMood: UIView!
    @IBOutlet weak var tableViewMoodGraph: UITableView!
    
    // MARK: -@IBOutlet Mood Summary View
    @IBOutlet weak var vwMoodSummary: UIView!
    @IBOutlet weak var llblMoodSummary: UILabel!
    @IBOutlet weak var vwHeaderMoodSumary: UIView!
    @IBOutlet weak var lblDateMoodSummary: UILabel!
    @IBOutlet weak var btnLeftArrowMoodSummary: UIButton!
    @IBOutlet weak var btnRighArrowMoodSummary: UIButton!
    @IBOutlet weak var vwSummary: UIView!
    @IBOutlet weak var tableViewMoodSummary: UITableView!
    
    // MARK: -@IBOutlet View Popup Graph
    @IBOutlet weak var vwBackground: UIView!
    @IBOutlet weak var vwPopupGraph: UIView!
    @IBOutlet weak var vwPopupHeader: UIView!
    @IBOutlet weak var lblPopupDate: UILabel!
    @IBOutlet weak var imgPopupMood: UIImageView!
    @IBOutlet weak var lblPopupMood: UILabel!
    @IBOutlet weak var lblPopupHour: UILabel!
    @IBOutlet weak var lblPopupDescription: UILabel!
    @IBOutlet weak var btnClose: UIButton!
    var centerYConstraint: NSLayoutConstraint?
    
    // MARK: -@IBOutlet View Emojis
    @IBOutlet weak var lblFeelingQuestion: UILabel!
    @IBOutlet weak var vwEmojis: UIView!
    
    // MARK: -@IBOutlet ScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    var presenter: MyMoodGraphPresenter!
    var delegate: MoodCollectionDelegate!
    var indexMoodSummary: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadUI()
    }
    
    private func loadUI() {
        
        presenter.loadData()
    }
    
    private func configUI() {
        
        configNavBar()
        configSummaryView()
        configMoodLineView()
        configGraphHeaderView()
        configMoodGraph()
        configMoodSummaryView()
        configCollectionViewEmojis()
        configMoodSummaryHeaderView()
        configPopupGraph()
    }
    
    private func configNavBar() {
        
        self.navigationItem.title = Constants.Messages.MyMood
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = UIColor.blueColor()
        self.navigationController?.navigationBar.barTintColor = UIColor.blueColor()
        
        let backBtn = UIButton()
        backBtn.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        backBtn.setImage(UIImage(named: "left207"), for: .normal)
        backBtn.addTarget(self, action: #selector(self.dismissView), for: .touchUpInside)
        backBtn.widthAnchor.constraint(equalToConstant: 25).isActive = true
        backBtn.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        let backBarBtn = UIBarButtonItem(customView: backBtn)
        
        self.navigationItem.leftBarButtonItem = backBarBtn
    }
    
    private func configCollectionViewEmojis() {
        
        let moodVC = MoodCollectionViewController(nibName: "MoodCollectionView", bundle: Bundle.main)
        moodVC.delegate = self
        vwEmojis.addSubview(moodVC.view)
        self.addChild(moodVC)
        
    }
    
    private func configMoodLineView() {
        
        vwMoodLine.layer.cornerRadius = 12
        vwMoodLine.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        vwMoodLine.clipsToBounds = true
    }
    
    private func configMoodSummaryView() {
        
        vwMoodSummary.layer.cornerRadius = 12
        vwMoodSummary.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        vwMoodSummary.clipsToBounds = true
    }
    
    private func configGraphHeaderView() {
        
        lblMonthYearMoodLine.textColor = UIColor(red: 0.383, green: 0.216, blue: 0.216, alpha: 1)
        lblMonthYearMoodLine.font = UIFont(name: "Roboto-Bold", size: 16)
        
        btnLeftArrowMoodLine.setImage(UIImage(named: "arrow_circle_left"), for: .normal)
        btnLeftArrowMoodLine.setTitle("", for: .normal)
        btnLeftArrowMoodLine.addTarget(self, action: #selector(didTapLeftArrowMoodGraph), for: .touchUpInside)
        
        btnRighArrowMoodLine.setImage(UIImage(named: "arrow_circle_right"), for: .normal)
        btnRighArrowMoodLine.setTitle("", for: .normal)
        btnRighArrowMoodLine.addTarget(self, action: #selector(didTapRightArrowMoodGraph), for: .touchUpInside)
    }
    
    private func configMoodSummaryHeaderView() {
        
        lblDateMoodSummary.textColor = UIColor(red: 0.383, green: 0.216, blue: 0.216, alpha: 1)
        lblDateMoodSummary.font = UIFont(name: "Roboto-Bold", size: 16)
        
        btnLeftArrowMoodSummary.setImage(UIImage(named: "arrow_circle_left"), for: .normal)
        btnLeftArrowMoodSummary.setTitle("", for: .normal)
        btnLeftArrowMoodSummary.addTarget(self, action: #selector(didTapLeftArrowMoodSummary), for: .touchUpInside)
        
        btnRighArrowMoodSummary.setImage(UIImage(named: "arrow_circle_right"), for: .normal)
        btnRighArrowMoodSummary.setTitle("", for: .normal)
        btnRighArrowMoodSummary.addTarget(self, action: #selector(didTapRightArrowMoodSummary), for: .touchUpInside)
    }
    
    private func configMoodGraph() {
        
        tableViewMoodGraph.register(UINib(nibName: "MoodGraphCell", bundle: Bundle.main), forCellReuseIdentifier: "MoodGraphCell")
        tableViewMoodGraph.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 12)
        tableViewMoodGraph.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableViewMoodGraph.separatorStyle = .none
    }
    
    private func configSummaryView() {
        
        self.vwSummary.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 12)
        
        tableViewMoodSummary.register(UINib(nibName: "MoodSummaryCell", bundle: Bundle.main), forCellReuseIdentifier: "MoodSummaryCell")
        tableViewMoodSummary.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 12)
        tableViewMoodSummary.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableViewMoodSummary.separatorStyle = .none
    }
    
    private func configPopupGraph() {
        
        vwPopupHeader.layer.cornerRadius = 12
        vwPopupHeader.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        vwPopupHeader.clipsToBounds = true
    }
    
    private func hideAnimationPopupGraph() {
        
        if centerYConstraint != nil {
            view.removeConstraint(centerYConstraint!)
        }
        
        centerYConstraint = NSLayoutConstraint(item: vwPopupGraph as Any,
                                               attribute: .top,
                                               relatedBy: .equal,
                                               toItem: view,
                                               attribute: .bottom,
                                               multiplier: 1,
                                               constant: 0)
        
        view.addConstraint(centerYConstraint!)
        
        vwBackground.alpha = 0
        vwPopupGraph.alpha = 0
        
        view.layoutIfNeeded()
    }
    
    internal func showAnimationPopupGraph(_ chartItem: ChartItem) {
        
        self.loadPopupGraph(chartItem)
        
        if centerYConstraint != nil {
            self.view.removeConstraint(centerYConstraint!)
        }
        
        UIView.animate(withDuration: 0.3) {
            
            self.centerYConstraint = NSLayoutConstraint(item: self.vwPopupGraph as Any,
                                                        attribute: .centerY,
                                                        relatedBy: .equal,
                                                        toItem: self.view,
                                                        attribute: .centerY,
                                                        multiplier: 1,
                                                        constant: -100)
            
            self.view.addConstraint(self.centerYConstraint!)
            
            self.vwPopupGraph.alpha = 1
            self.vwBackground.alpha = 0.7
            
            self.view.layoutIfNeeded()
        }
    }
    
    private func loadPopupGraph(_ chartItem: ChartItem) {
        
        lblPopupDate.text = chartItem.dateRegister.convertStringToDate(chartItem.dateRegister)
        lblPopupMood.text = setTitleMoodGraph(chartItem)
        imgPopupMood.image = setImageMoodGraph(chartItem)
        lblPopupHour.text = chartItem.dateRegister.convertStringToHour()
        lblPopupDescription.text = "teste mudança"
    }
    
    private func setTitleMoodGraph(_ chart: ChartItem) -> String? {

        switch chart.codHumor {
        case 1:
            return Constants.Messages.Lovesick
        case 4:
            return Constants.Messages.Happy
        case 7:
            return Constants.Messages.Sad
        case 5:
            return Constants.Messages.Amazed
        case 8:
            return Constants.Messages.Angry
        case 6:
            return Constants.Messages.Tired
        case 3:
            return Constants.Messages.Funny
        case 10:
            return Constants.Messages.Sick
        case 9:
            return Constants.Messages.Frustrated
        case 2:
            return Constants.Messages.Sleepy
        default:
            break
        }

        return nil
    }
    
    
    private func setImageMoodGraph(_ chart: ChartItem) -> UIImage? {
        
        switch chart.codHumor {
        case 1:
            return UIImage(named: "ic_apaixonado")?.resized(to: CGSize(width: 30, height: 30))
        case 4:
            return UIImage(named: "ic_feliz")?.resized(to: CGSize(width: 30, height: 30))
        case 7:
            return UIImage(named: "ic_triste")?.resized(to: CGSize(width: 30, height: 30))
        case 5:
            return UIImage(named: "ic_espantado")?.resized(to: CGSize(width: 30, height: 30))
        case 8:
            return UIImage(named: "ic_raiva")?.resized(to: CGSize(width: 30, height: 30))
        case 6:
            return UIImage(named: "ic_entediado")?.resized(to: CGSize(width: 30, height: 30))
        case 3:
            return UIImage(named: "ic_engracado")?.resized(to: CGSize(width: 30, height: 30))
        case 10:
            return UIImage(named: "ic_doente")?.resized(to: CGSize(width: 30, height: 30))
        case 9:
            return UIImage(named: "ic_frustrado")?.resized(to: CGSize(width: 30, height: 30))
        case 2:
            return UIImage(named: "ic_sono")?.resized(to: CGSize(width: 30, height: 30))
        default:
            break
        }
        return nil
    }
    
    @objc func didTapLeftArrowMoodGraph(_ sender: UIButton) {
        //        if indexMoodGraph != 0 {
        //            indexMoodGraph -= 1
        //            if indexMoodGraph < presenter.listMoodGraph.count && indexMoodGraph >= 0 {
        //                tableViewMoodGraph.reloadData()
        //            }
        //        }
    }
    
    @objc func didTapRightArrowMoodGraph() {
        
//        if presenter.chart.dateRegister.convertStringToDay() =! presenter.chart. {
            
            
            //        if indexMoodGraph != presenter.listMoodGraph.count - 1 {
            //            indexMoodGraph += 1
            //            if indexMoodGraph < presenter.listMoodGraph.count {
            //                tableViewMoodGraph.reloadData()
            //            }
            //        }
//        }
        
    }
    
    @objc func didTapLeftArrowMoodSummary(_ sender: UIButton) {
        //        if indexMoodSummary != 0 {
        //            indexMoodSummary -= 1
        //            if indexMoodSummary < presenter.listMoodSummary.count && indexMoodSummary >= 0 {
        //                tableViewMoodSummary.reloadData()
        //            }
        //        }
    }
    
    @objc func didTapRightArrowMoodSummary() {
        //        if indexMoodSummary != presenter.listMoodSummary.count - 1 {
        //            indexMoodSummary += 1
        //            if indexMoodSummary < presenter.listMoodSummary.count {
        //                tableViewMoodSummary.reloadData()
        //            }
        //        }
    }
    
    @objc func dismissView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func closePopup(_ sender: Any) {
        hideAnimationPopupGraph()
    }
    
    //-----------------------------------------------------------------------
    // MARK: MoodCollection Delegate
    //-----------------------------------------------------------------------
    
    func showMoodDetail(_ mood: Mood) {
        presenter.showMyMood(nav: self.navigationController!, mood: mood)
    }
    
    //-----------------------------------------------------------------------
    // MARK: UITableView Delegate
    //-----------------------------------------------------------------------
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if tableView == tableViewMoodGraph {
            return 356
        }else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == tableViewMoodSummary {
            presenter.moodSummary = presenter.listMoodSummary[indexMoodSummary]
            return presenter.moodSummary.activities.count
        }else {
            return presenter.chartList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewMoodSummary {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoodSummaryCell", for: indexPath) as? MoodSummaryCell
            
            presenter.moodSummary = presenter.listMoodSummary[indexMoodSummary]
            let activity = presenter.moodSummary!.activities[indexPath.row]
            
            lblDateMoodSummary.text = presenter.moodSummary.date
            
            cell?.loadUI(activity)
            
            return cell ?? UITableViewCell()
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "MoodGraphCell", for: indexPath) as? MoodGraphCell
            
            let chart = presenter.chartList
            presenter.chart = chart[indexPath.row]
            
            //            if let dateRegister = presenter?.chartList {
            //                lblMonthYearMoodLine.text = dateRegister
            //            } else {
            // handle the case where presenter, chart, or dateRegister is nil
            //            }
            
            cell?.delegate = self
            cell?.loadUI(chart)
            
            return cell ?? UITableViewCell()
        }
    }
    
    //-----------------------------------------------------------------------
    //MARK: PresenterDelegate
    //-----------------------------------------------------------------------
    
    func dataLoaded() {
        self.tableViewMoodGraph.reloadData()
    }
    
    func showError(_ strError: String) {
    }
    
}
