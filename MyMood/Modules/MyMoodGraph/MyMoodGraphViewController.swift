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
    
    // MARK: -@IBOutlet ScrollView
    @IBOutlet weak var scrollView: UIScrollView!
    
    var presenter: MyMoodGraphPresenter!
    var indexMoodSummary: Int = 0
    var indexMoodGraph: Int = 0

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
        configMoodSummaryHeaderView()
        configPopupGraph()
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
        lblMonthYearMoodLine.font = UIFont(name: Constants.Fonts.RobotoBold, size: 16)
        
        btnLeftArrowMoodLine.setImage(UIImage(named: Constants.Images.arrowCircleLeft), for: .normal)
        btnLeftArrowMoodLine.setTitle(Constants.Messages.Empty, for: .normal)
        btnLeftArrowMoodLine.addTarget(self, action: #selector(didTapLeftArrowMoodGraph), for: .touchUpInside)
        
        btnRighArrowMoodLine.setImage(UIImage(named: Constants.Images.arrowCircleRight), for: .normal)
        btnRighArrowMoodLine.setTitle(Constants.Messages.Empty, for: .normal)
        btnRighArrowMoodLine.addTarget(self, action: #selector(didTapRightArrowMoodGraph), for: .touchUpInside)
    }
    
    private func configMoodSummaryHeaderView() {
        
        lblDateMoodSummary.textColor = UIColor(red: 0.383, green: 0.216, blue: 0.216, alpha: 1)
        lblDateMoodSummary.font = UIFont(name: Constants.Fonts.RobotoBold, size: 16)
        
        btnLeftArrowMoodSummary.setImage(UIImage(named: Constants.Images.arrowCircleLeft), for: .normal)
        btnLeftArrowMoodSummary.setTitle(Constants.Messages.Empty, for: .normal)
        btnLeftArrowMoodSummary.addTarget(self, action: #selector(didTapLeftArrowMoodSummary), for: .touchUpInside)
        
        btnRighArrowMoodSummary.setImage(UIImage(named: Constants.Images.arrowCircleRight), for: .normal)
        btnRighArrowMoodSummary.setTitle(Constants.Messages.Empty, for: .normal)
        btnRighArrowMoodSummary.addTarget(self, action: #selector(didTapRightArrowMoodSummary), for: .touchUpInside)
    }
    
    private func configMoodGraph() {
        
        tableViewMoodGraph.register(UINib(nibName: Constants.Cells.MoodGraphCell, bundle: Bundle.main), forCellReuseIdentifier: Constants.Cells.MoodGraphCell)
        tableViewMoodGraph.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 12)
        tableViewMoodGraph.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 20, right: 0)
        tableViewMoodGraph.separatorStyle = .none
    }
    
    private func configSummaryView() {
        
        self.vwSummary.roundCorners([.layerMaxXMaxYCorner, .layerMinXMaxYCorner], radius: 12)
        
        tableViewMoodSummary.register(UINib(nibName: Constants.Cells.MoodSummaryCell, bundle: Bundle.main), forCellReuseIdentifier: Constants.Cells.MoodSummaryCell)
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
        
        UIView.animate(withDuration: 0.3) {
            self.navigationController?.navigationBar.alpha = 1
            self.vwBackground.alpha = 0
            self.vwPopupGraph.alpha = 0
            
            self.view.layoutIfNeeded()
        }
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
            
            self.navigationController?.navigationBar.alpha = 0
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
        lblPopupDescription.text = Constants.Messages.popupDescriptionTextMock
    }
    
    private func setTitleMoodGraph(_ chart: ChartItem) -> String? {

        switch chart.codHumor {
            case 1:
                return Constants.Messages.Lovesick
            case 2:
                return Constants.Messages.Sleepy
            case 3:
                return Constants.Messages.Funny
            case 4:
                return Constants.Messages.Happy
            case 5:
                return Constants.Messages.Amazed
            case 6:
                return Constants.Messages.Tired
            case 7:
                return Constants.Messages.Sad
            case 8:
                return Constants.Messages.Angry
            case 9:
                return Constants.Messages.Frustrated
            case 10:
                return Constants.Messages.Hungry
            case 11:
                return Constants.Messages.Sick
            case 12:
                return Constants.Messages.Worried
            default:
                break
        }

        return nil
    }
    
    
    func setImageMoodGraph(_ chart: ChartItem) -> UIImage? {
        
        switch chart.codHumor {
            case 1:
                return UIImage(named: Constants.Images.LovesickImage)?.resized(to: CGSize(width: 30, height: 30))
            case 2:
                return UIImage(named: Constants.Images.SleepyImage)?.resized(to: CGSize(width: 30, height: 30))
            case 3:
                return UIImage(named: Constants.Images.FunnyImage)?.resized(to: CGSize(width: 30, height: 30))
            case 4:
                return UIImage(named: Constants.Images.HappyImage)?.resized(to: CGSize(width: 30, height: 30))
            case 5:
                return UIImage(named: Constants.Images.AmazedImage)?.resized(to: CGSize(width: 30, height: 30))
            case 6:
                return UIImage(named: Constants.Images.TiredImage)?.resized(to: CGSize(width: 30, height: 30))
            case 7:
                return UIImage(named: Constants.Images.SadImage)?.resized(to: CGSize(width: 30, height: 30))
            case 8:
                return UIImage(named: Constants.Images.AngryImage)?.resized(to: CGSize(width: 30, height: 30))
            case 9:
                return UIImage(named: Constants.Images.FrustratedImage)?.resized(to: CGSize(width: 30, height: 30))
            case 10:
                return UIImage(named: Constants.Images.HungryImage)?.resized(to: CGSize(width: 30, height: 30))
            case 11:
                return UIImage(named: Constants.Images.SickImage)?.resized(to: CGSize(width: 30, height: 30))
            case 12:
                return UIImage(named: Constants.Images.WorriedImage)?.resized(to: CGSize(width: 30, height: 30))
            default:
                break
        }
        return nil
    }
    
    @objc func didTapLeftArrowMoodGraph(_ sender: UIButton) {
        if indexMoodGraph != 0 {
            indexMoodGraph -= 1
            if indexMoodGraph < presenter.listMoodGraph.count && indexMoodGraph >= 0 {
                tableViewMoodGraph.reloadData()
            }
        }
    }
    
    @objc func didTapRightArrowMoodGraph() {
        if indexMoodGraph != presenter.listMoodGraph.count - 1 {
            indexMoodGraph += 1
            if indexMoodGraph < presenter.listMoodGraph.count {
                tableViewMoodGraph.reloadData()
            }
        }
    }
    
    @objc func didTapLeftArrowMoodSummary(_ sender: UIButton) {
        if indexMoodSummary != 0 {
            indexMoodSummary -= 1
            if indexMoodSummary < presenter.listMoodSummary.count && indexMoodSummary >= 0 {
                tableViewMoodSummary.reloadData()
            }
        }
    }
    
    @objc func didTapRightArrowMoodSummary() {
        if indexMoodSummary != presenter.listMoodSummary.count - 1 {
            indexMoodSummary += 1
            if indexMoodSummary < presenter.listMoodSummary.count {
                tableViewMoodSummary.reloadData()
            }
        }
    }
    
    @objc func dismissView() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func closePopup(_ sender: Any) {
        hideAnimationPopupGraph()
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
            presenter.moodGraph = presenter.listMoodGraph[indexMoodGraph]
            return presenter.moodGraph.chart.count

        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tableViewMoodSummary {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.MoodSummaryCell, for: indexPath) as? MoodSummaryCell
            
            presenter.moodSummary = presenter.listMoodSummary[indexMoodSummary]
            let activity = presenter.moodSummary!.activities[indexPath.row]
            
            lblDateMoodSummary.text = presenter.moodSummary.date
            
            cell?.loadUI(activity)
            
            return cell ?? UITableViewCell()
        }else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Cells.MoodGraphCell, for: indexPath) as? MoodGraphCell
            
            presenter.moodGraph = presenter.listMoodGraph[indexMoodGraph]
            let chart = presenter.moodGraph.chart
            
            if let dateRegister = presenter.moodGraph.date {
                lblMonthYearMoodLine.text = dateRegister
            }
            
            cell?.delegate = self
            cell?.loadUI(chart)
            
            return cell ?? UITableViewCell()
        }
    }
    
    //-----------------------------------------------------------------------
    //MARK: PresenterDelegate
    //-----------------------------------------------------------------------
    
    func dataLoaded() {}
    
    func showError(_ strError: String) {
    }
    
}
