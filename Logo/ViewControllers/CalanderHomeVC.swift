//
//  CalanderHomeVC.swift
//  Logo
//
//  Created by Vishal on 05/04/24.
//

var isOnRouteBtnTapped = false

import UIKit
import FSCalendar
import PKHUD
class CalanderHomeVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource ,FSCalendarDelegateAppearance {
    
    fileprivate lazy var dateFormatter2: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM, yyyy"
        return formatter
    }()
    
    var datesWithEvent = [String]()
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        let dateString = dateFormatter2.string(from: date)
        if self.datesWithEvent.contains(dateString){
            return 1
        }
        return 0
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, eventDefaultColorsFor date: Date) -> [UIColor]? {
        
        let key = self.dateFormatter2.string(from: date)
        
        if self.datesWithEvent.contains(key){
            return [UIColor.red]
        }
        return nil
    }
    
    
    
    
    //   var theme: Theme?
    let colors: [UIColor] = [
        UIColor(r: 249, g: 221, b: 241),
        UIColor(r: 201, g: 235, b: 242),
        UIColor(r: 242, g: 243, b: 189),
        UIColor(r: 221, g: 249, b: 225),
        UIColor(r: 238, g: 234, b: 246),
        UIColor(r: 249, g: 249, b: 221),
        UIColor(r: 221, g: 249, b: 225),
        UIColor(r: 201, g: 235, b: 242),
        UIColor(r: 242, g: 243, b: 189),
        UIColor(r: 221, g: 249, b: 225),
        UIColor(r: 238, g: 234, b: 246),
        UIColor(r: 249, g: 221, b: 241),
    ]
    
    @IBOutlet weak var profileImgVw: UIImageView!
    @IBOutlet weak var logoutBtn: UIImageView!
    @IBOutlet weak var vwtop: UIView!
    @IBOutlet weak var constraint_ViewHeight: NSLayoutConstraint!
    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var monthNameLabel: UILabel!
    
    @IBOutlet weak var super_Vw: UIView!
    @IBOutlet weak var bgImgVw2: UIImageView!
    @IBOutlet weak var time_CollectionVW: UICollectionView!
    
    
    @IBOutlet weak var btn_Add: UIImageView!
    
    @IBOutlet weak var lbl_AllRequests: UILabel!
    
    @IBOutlet weak var bgImgVw: UIImageView!
    //MARK: - popUP Outlets
    
    @IBOutlet weak var btnAdd: UIImageView!
    @IBOutlet weak var btn_AllReq: UIButton!
    @IBOutlet weak var inspectionType: UILabel!
    @IBOutlet weak var noReqLbl: UILabel!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var refreshBtn: UIButton!
    
    @IBOutlet weak var notes: UITextView!
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var roundCornerView: UIView!
    
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var popContent_VW: UIView!
    @IBOutlet weak var popRemoveBtn: UIButton!
    @IBOutlet weak var popUserImage: LazyImageView!
    @IBOutlet weak var makeReportBtn: UIButton!
    
    @IBOutlet weak var lbl_WelCome: UILabel!
    @IBOutlet weak var lbl_Nm: UILabel!
    @IBOutlet weak var agreeStackVw: UIStackView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejecttBtn: UIButton!
    @IBOutlet weak var agree2Stack: UIStackView!
    @IBOutlet weak var onRoutebtn: UIButton!
    @IBOutlet weak var notification_Centerimg: UIImageView!
    @IBOutlet weak var switch_btn: UISwitchCustom!
    
    @IBOutlet weak var userTxtLabel_pop: PaddingLabel!
    @IBOutlet weak var numberTxtLabel_pop: PaddingLabel!
    @IBOutlet weak var locationTxtLabel_pop: PaddingLabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    var namedata : String?
    var AcceptIndex = 0
    var Acceptsection = 0
    var selectedIndex = 0
    var isOpenCalendarForVacation = true
    var StartDateStr : String?
    var EndDateStr : String?
    var StartDate : Date?
    var EndDate : Date?
    var selectedtime = String()
    var applyLeavesArray : [String] = []
    var leavesArray : [String] = []
    var previouslySelectedDate: Date?
    // var profileImg = UIImage()
    private var currentPage: Date?
    var groupedAppointments: [String: [Request]] = [:]
    var loginrequest = [Request]()
    var loginrequests = [Requestdata]()
    private var groupedRequests: [String: [Requestdata]] = [:]
    
    var isFromCalenderVC: Bool? = false
    
    // Create a new dictionary with sorted keys and corresponding values
    var sortedGroupedRequests: [String: [Requestdata]] = [:]
    var profileImg : UIImage = UIImage(named: "user")!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardDataAPI()
        //   self.tabBarController!.tabBar.addTopBorder(color: UIColor.lightGray, height: 4.0)
        self.tabBarController?.tabBar.tintColor = .black
        //        self.tabBarController!.tabBar.unselectedItemTintColor = UIColor.black
        if let tabBar = self.tabBarController?.tabBar {
            applyStylings(to: tabBar)
        }
        //  print(LocalStore.shared.isDarkMode)
        
        switch_btn.isOn = true
        switch_btn.tintColor = .blue
        //  updateBackgroundColor()
        self.calenderView.scope = .month
        
        calenderView.dataSource = self
        makeReportBtn.isHidden = true
        onRoutebtn.isHidden = true
        time_CollectionVW.showsVerticalScrollIndicator = false
        time_CollectionVW.showsHorizontalScrollIndicator = false
        time_CollectionVW.delegate = self
        time_CollectionVW.dataSource = self
        CalanderHomeViewCell.registerCollectionCell(for: time_CollectionVW)
        let nib = UINib(nibName: "CalanderHomeReusableView", bundle: nil)
        self.time_CollectionVW.register(nib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CalanderHomeReusableView")
        UIViewSetting()
        
        calenderView.scrollEnabled = false
        calenderView.isHidden = true
        
    }
    func applyStylings(to tabBar: UITabBar) {
        //  tabBar.layer.cornerRadius = 12
        tabBar.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
        tabBar.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
        tabBar.layer.shadowOpacity = 1.5
        tabBar.layer.shadowRadius = 4
    }
    
    func dashboardDataAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.DashboardDataUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : DashboardModel?) in
            let dashboardData = success!.data
            
            
            if dashboardData.punchData == 0{
                SingleTon.shared.isPunchedIn = false
            }
            else{
                SingleTon.shared.isPunchedIn = true
            }
            
            
            profileImgVw.sd_setImage(with: URL(string: ApiUrl.ProfileImgBase + dashboardData.profilePic), placeholderImage: UIImage(named: "user"))
            profileImg = profileImgVw.image!
            lbl_Nm.text = dashboardData.userName
            
        }
    }
    
    func UIViewSetting() {
        // applyStyling(to: vwtop)
        // profileImgVw.image! = profileImg
        profileImgVw.clipsToBounds = true
        profileImgVw.layer.cornerRadius = 20
        profileImgVw.contentMode = .scaleToFill
        profileImgVw.alpha = 1.0
        vwtop.roundCornerss(corners: [.topLeft, .topRight], radius: 45, newWidth: self.view.frame.width)
        btn_Add.actionBlock {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenualReportVC") as! MenualReportVC
            SingleTon.shared.isMakeMenualReport = false
            self.isFromCalenderVC = true
            vc.isComingFromCalenderVC = self.isFromCalenderVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        logoutBtn.actionBlock { [self] in
            AlertControl.shared.showAlert("Poseidon", message: "Are you sure to logout?", buttons: ["Cancel","OK"]) { value in
                if value == 1{
                    self.addHapticFeedback()
                    self.logOutApi()
                }
            }
        }
        notification_Centerimg.actionBlock {
            print("tap to AllRequestsVC")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllRequestsVC") as! AllRequestsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
    }
    private func groupRequestsByDate() {
        groupedRequests.removeAll() // Clear the existing data
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        for request in loginrequests {
            if let date = dateFormatter.date(from: request.assignedDate) {
                let dateString = dateFormatter.string(from: date)
                if groupedRequests[dateString] == nil {
                    groupedRequests[dateString] = [request]
                } else {
                    groupedRequests[dateString]?.append(request)
                }
            }
        }
        
        // Sort keys (assigned dates) in descending order
        let sortedKeys = groupedRequests.keys.sorted(by: >).reversed()
        print(sortedKeys)
        
    }
    
    func setUI() {
        
        //--POP UI SET
        //        userTxtLabel_pop.layer.cornerRadius = 5
        //        numberTxtLabel_pop.layer.cornerRadius = 5
        //        locationTxtLabel_pop.layer.cornerRadius = 5
        //---------
        //baseView.backgroundColor = UIColor(named: "Main_Color")
        //    baseView.backgroundColor = UIColor(red: 0/255, green: 66/255, blue: 138/255, alpha: 1.0)
        self.capsuleButtons(makeReportBtn)
        self.capsuleonrouteButtons(onRoutebtn)
        onRoutebtn.clipsToBounds = true
        makeReportBtn.clipsToBounds = true
        //        self.setButtonImage(image: UIImage(named: "cross")!, Btn: popRemoveBtn)
        //        self.setButtonImage(image: UIImage(named: "bell")!, Btn: notificationBtn)
        //        self.setButtonImage(image: UIImage(named: "logout_white")!, Btn: logOutBtn)
        //        self.setButtonImage(image: UIImage(named: "reload")!, Btn: refreshBtn)
        
        popUserImage.layer.cornerRadius = 10
        popUserImage.clipsToBounds = true
        // roundCornerView.roundCorners([.topRight,.topLeft], radius: 40)
        popContent_VW.roundCorners([.topRight,.topLeft], radius: 40)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        //  updateBackgroundColor()
        
        getStartAndEndDateOfMonth()
    }
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        
        //  updateBackgroundColor()
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
        
    }
    
    func applyStyling(to view: UIView) {
        
        view.layer.cornerRadius = 12
        //view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
        view.layer.shadowOpacity = 1.5
        
        vwtop.roundCornerss(corners: [.topLeft, .topRight], radius: 45, newWidth: self.view.frame.width)
    }
    
    @IBAction func backClick(_ sender: Any) {
        self.moveCurrentPage(moveUp: false)
        
    }
    @IBAction func nextClick(_ sender: Any) {
        self.moveCurrentPage(moveUp: true)
        
    }
    
    
    
    @IBAction func home_Vc_BtnAction(_ sender: UIButton) {
        switch sender.tag {
        case 0://--logout Button
            logoutAlert()
            //            self.PopToViewControllert(vc: Home_VC.self)
            //            self.navigationController?.popToRootViewController(animated: true)
        case 1://-- NotificationBurtton
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Notification_VC")as! Notification_VC
            self.navigationController?.pushViewController(vc, animated: true)
        case 2://-- REFRESH BUTTON
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let str = dateFormatter.string(from: Date())
            print(str)
            self.requestApi(str)
            self.allRequestApi()
        case 3://-- POP REMOVE BUTTON
            UIView.transition(with: self.view, duration: 1, options: [.transitionCrossDissolve], animations: {
                self.popUpView.removeFromSuperview()
            }, completion: nil)
        case 4://-- MAKE REPORT BUTTON
            
            //            var requestDict = [String:Any]()
            //
            //            requestDict["index"] = selectedIndex
            //            requestDict["model"] = loginrequest[selectedIndex]
            //            requestDict["clientName"] = SingleTon.shared.clientName
            //            requestDict["inspectorName"] = SingleTon.shared.inspectorName
            //            print(requestDict)
            //            Indicator.sharedInstance.showIndicator()
            //self.pushWithData("Form_VC", requestDict)
            ClearDataClass.removeAllValues()
            //showInspectPopUp()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SectionTitlesViewController") as! SectionTitlesViewController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        self.allRequestApi()
    }
    
    
    
    
    func logoutAlert() {
        let alert = UIAlertController(title: "", message: "Are you want to logout", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action -> Void in
            self.logOutApi()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    func logOutApi() {
        loginrequest = [Request]()
        ApiFunc.shared.logoutApi(self.view) { responseModel in
            if responseModel.status == true {
                SingleTon.shared.userToken = ""
                self.executeLogin()
            } else {
                HUD.flash(.labeledError(title: "", subtitle: responseModel.message), delay: 1.0)
            }
        }
    }
    // MARK: - Functions
    func executeLogin() {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
        UIApplication.shared.currentWindow?.rootViewController = loginVC
        UIApplication.shared.currentWindow?.makeKeyAndVisible()
    }
    
    @IBAction func switchChangescreen(_ sender: UISwitch) {
        
        if sender.isOn {
            //              let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            //              self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    
    
    
    
    //    func updateBackgroundColor() {
    //        if LocalStore.shared.isDarkMode == true {
    //            vwtop.backgroundColor = ThemeColor.darkThemeViewBGColor
    //            //  super_Vw.backgroundColor = ThemeColor.darkThemeViewBGColor
    //            time_CollectionVW.backgroundColor = ThemeColor.darkThemeViewBGColor
    //            bgImgVw.image = UIImage(named: "MakeChange")
    //            segmentControl.backgroundColor = .white
    //            segmentControl.selectedSegmentTintColor = ThemeColor.lightThemeImageTintColor
    //            UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:ThemeColor.lightThemeImageTintColor], for: .normal)
    //            UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
    //
    //            lbl_AllRequests.textColor = ThemeColor.darkThemeTextColor
    //            btnAdd.tintColor = ThemeColor.darkThemeImageTintColor
    //            popContent_VW.backgroundColor = ThemeColor.darkThemeCellBGColor
    //            logoutBtn.tintColor = .white
    //        } else {
    //            logoutBtn.tintColor = ThemeColor.lightThemeImageTintColor
    //            vwtop.backgroundColor = ThemeColor.lightThemeViewBGColor
    //            // super_Vw.backgroundColor = ThemeColor.lightThemeViewBGColor
    //            bgImgVw.image = UIImage(named: "ChangeDashboard")
    //
    //        }
    //    }
    
    
    
    
    
    
    
    
    
    
    @IBAction func btnRequest(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllListHomeVC")as! AllListHomeVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    //    private lazy var today: Date = {
    //        return Date()
    //    }()
    
    private lazy var today = Date()
    
    private func moveCurrentPage(moveUp: Bool) {
        
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = moveUp ? 1 : -1
        
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        calenderView.setCurrentPage(self.currentPage!, animated: true)
        
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        let monthNameWithYear = dateFormatter.string(from: self.currentPage ?? self.today)
        
        monthNameLabel.text = monthNameWithYear
    }
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let now = Date()
        let cal = Calendar.current
        
        
        
        let newDate = cal.date(bySettingHour: cal.component(.hour, from: now),
                               minute: cal.component(.minute, from: now),
                               second: cal.component(.second, from: now),
                               of: date)!
        
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let UTCTimeAsString = dateFormatter.string(from: newDate)
        
        
        print("UTCTimeAsString---?" , UTCTimeAsString)
        selectedtime = UTCTimeAsString
        print(calenderView.selectedDates)
        allRequestApi(isForCalendarDateSelect: true)
        
        if let previousDate = previouslySelectedDate {
            
            calendar.deselect(previousDate)
        }
        calendar.appearance.titleSelectionColor = .white
        calendar.appearance.selectionColor = UIColor(red: 34/255, green: 52/255, blue: 140/255, alpha: 1)
        
        previouslySelectedDate = date
        
    }
    
    @IBAction func makrReportBtn(_ sender: UIButton) {
        print ("gkjgkjddfkd_______", isOnRouteBtnTapped)
        if isOnRouteBtnTapped == false {
            print ("not working isOnRouteBtnTapped")
        }else{
            ApiFunc.shared.newDetailOnRouteTime(self.view) { [self] responseModel in
                print("Make----responseModel.data.type---->", responseModel.data.type)
                Indicator.sharedInstance.hideIndicator()
                
            }
        }
        //  let vc = storyboard?.instantiateViewController(withIdentifier: "MenualReportVC") as!  MenualReportVC
        let vc = storyboard?.instantiateViewController(withIdentifier: "SectionTitlesViewController") as!  SectionTitlesViewController
        
        SingleTon.shared.isMakeMenualReport = false
        //        ClearDataClass.removeAllValues()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
  
    @IBAction func onRoutebtn(_ sender: Any) {
        print("SingleTon.shared.onRoute--" , SingleTon.shared.onRoute)
        ApiFunc.shared.updateRouteApis(self.view) { responseModel in
            if responseModel.status == true {
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                    let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "Dashboard_Nav")
                    SingleTon.shared.isMakeMenualReport = false
                    appDelegate.window?.rootViewController = initialViewController
                    appDelegate.window?.makeKeyAndVisible()
                    
                }
            } else {
                HUD.flash(.labeledError(title: "", subtitle: responseModel.message), delay: 1.0)
            }
        }
    }
    
    
    @IBAction func acceptAction(_ sender: UIButton) {
        self.ChageRequestStatusAPI(section: Acceptsection, index: AcceptIndex, status: "1")
        agreeStackVw.isHidden = true
        agree2Stack.isHidden = false
        makeReportBtn.isHidden = false
        onRoutebtn.isHidden = false
      
    }
    
    @IBAction func rejectAction(_ sender: UIButton) {
        
        self.ChageRequestStatusAPI( section: Acceptsection, index: AcceptIndex, status: "2")
    }
    
    
    func requestApi(_ selectedDate: String) {
        SingleTon.shared.clientName = ""
        loginrequest = [Request]()
        ApiFunc.shared.requestApi(self.view, selectedDate: selectedDate) { responseModel in
            if responseModel.status == true {
                SingleTon.shared.inspectorName = responseModel.data.inspectorName//responseModel.inspectorName
                self.loginrequest = responseModel.data.requests
                if responseModel.data.requests.count == 0 {
                    self.noReqLbl.isHidden = false
                } else {
                    self.noReqLbl.isHidden = true
                }
                
                
                if SingleTon.shared.notificationType{
                    SingleTon.shared.notificationType = false
                    //         let filtered = self.loginrequest.filter { $0.id == SingleTon.shared.reqesedtUserId }
                    for i in 0..<self.loginrequest.count{
                        if SingleTon.shared.reqesedtUserId == self.loginrequest[i].id{
                            //   self.openReportPopUp(index: i)
                            self.AcceptIndex = i
                            return
                        }
                    }
                }
            } else {
                HUD.flash(.labeledError(title: "", subtitle: responseModel.message), delay: 1.0)
            }
        }
    }
    
    
    
    
    
    @objc func ChageRequestStatusAPI( section:Int, index:Int,status:String){
        print("Tapped")
        
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ChageRequestStatusUrl, method: .post, parameters: ["sessionToken" : SingleTon.shared.userToken,"type" : status,"requestId" : loginrequests[section].data[index].id]) { [self] (success : ChageRequestStatusModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            self.allRequestApi()
            let indxPath = IndexPath(row: index, section: 0)
            //  self.time_CollectionVW.scrollToRow(at: indxPath, at: .bottom, animated: false)
            
            //me
            //            UIView.transition(with: self.view, duration: 1, options: [.transitionCrossDissolve], animations: {
            //                self.popUpView.removeFromSuperview()
            //            }, completion: nil)
            if status == "1"{
                //             DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                //                    let vc = storyboard?.instantiateViewController(withIdentifier: "SectionTitlesViewController") as!  SectionTitlesViewController
                //                    SingleTon.shared.isMakeMenualReport = false
                //                    //        ClearDataClass.removeAllValues()
                //                    self.navigationController?.pushViewController(vc, animated: true)
                //               }
            }
        }
    }
    
    func allRequestApi(isForCalendarDateSelect:Bool? = false) {
        SingleTon.shared.clientName = ""
        // loginrequest = [Request]()
        loginrequests = [Requestdata]()
        ApiFunc.shared.allRequestsApis(self.view, date: selectedtime) { [self] responseModel in
            if responseModel.status == true {
                SingleTon.shared.inspectorName = responseModel.data.inspectorName
                
                responseModel.data.requests.forEach { req in
                    self.datesWithEvent.append(req.assignedDate)
                }
                print("self.datesWithEvent" , self.datesWithEvent)
                calenderView.delegate = self
                calenderView.reloadData()
                
                self.loginrequests = (responseModel.data.requests)
                if responseModel.data.requests.count == 0 {
                    //self.noReqLbl.isHidden = false
                } else {
                    // self.noReqLbl.isHidden = true
                }
                
                
                print(SectionDataHandler.shared.selectedReportId)
                //  self.constraint_ViewHeight.constant =   CGFloat(constraint_ViewHeight? * (loginrequests.count/2))
                print(self.constraint_ViewHeight.constant)
                //  self.constraint_ViewHeight.constant = (CGFloat(CGFloat(constraint_ViewHeight.constant) * CGFloat(loginrequests.count/2))) + CGFloat((20 * loginrequests.count))
                print(loginrequests.count)
                if isForCalendarDateSelect == true {
                    
                    if responseModel.data.requests.count > 0 && responseModel.data.requests[0].data.count > 0 {
                        self.constraint_ViewHeight.constant = CGFloat(80 * CGFloat(responseModel.data.requests[0].data.count)) + 300
                    } else {
                        self.constraint_ViewHeight.constant = 350
                    }
                    
                    // self.constraint_ViewHeight.constant = CGFloat(80 * CGFloat(responseModel.data.requests[0].data.count)) + 50
                } else {
                    //  self.constraint_ViewHeight.constant = (CGFloat(CGFloat(constraint_ViewHeight.constant) * CGFloat(loginrequests.count/2))) + CGFloat((10 * loginrequests.count))
                    
                    self.constraint_ViewHeight.constant = CGFloat(80 * CGFloat(loginrequests.count)) + CGFloat(50 * CGFloat(loginrequests.count)) + 360
                }
                
                
                
                
                print(self.constraint_ViewHeight.constant)
                self.time_CollectionVW.dataSource = self
                self.time_CollectionVW.delegate = self
                //groupRequestsByDate()
                calenderView.isHidden = false
                calender()
                
                self.time_CollectionVW.reloadData()
                
            } else {
                HUD.flash(.labeledError(title: "", subtitle: responseModel.message), delay: 1.0)
            }
        }
        
    }
    
    
    
    
    
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUI()
    }
    
    @IBAction func segmetCotroller(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 1  {
            self.calenderView.scope = FSCalendarScope.week
            getStartAndEndDateOfMonth()
        }else{
            getStartAndEndDateOfMonth()
            self.calenderView.scope = FSCalendarScope.month
        }
    }
    
}

extension CalanderHomeVC {
    
    
    
    
    func calender(){
        
        
        calenderView.appearance.headerTitleColor = UIColor.black
        calenderView.appearance.weekdayTextColor = UIColor.black
        calenderView.appearance.titleTodayColor = UIColor.black
        calenderView.appearance.borderRadius = 0.5
        calenderView.appearance.selectionColor =  UIColor(r: 34, g: 52, b: 140)
        calenderView.appearance.titleSelectionColor = .white
        //calenderView.appearance.titleSelectionColor = .black
        //calenderView.appearance.titleSelectionColor = UIColor(red: 216/255, green: 22/255, blue: 57/255, alpha: 1)
        //  calenderView.appearance.borderSelectionColor = UIColor(red: 216/255, green: 22/255, blue: 57/255, alpha: 1)
        calenderView.appearance.todayColor =   UIColor(r: 34, g: 52, b: 140)
        calenderView.appearance.titleTodayColor = .white
        
        //        calenderView.appearance.titleFont = UIFont.PoppinsFont(.medium,size: 13)
        //        calenderView.appearance.weekdayFont = UIFont.PoppinsFont(.medium,size: 13)
        //        calenderView.appearance.headerTitleFont = UIFont.PoppinsFont(.semiBold,size: 18)
        calenderView.calendarHeaderView.calendar.headerHeight = 0
        calenderView.scrollEnabled = false
        
        if monthNameLabel.text == "Label" {
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMMM yyyy"
            
                    let currentDate = Date()
                    let monthNameWithYear = dateFormatter.string(from: currentDate)
                    print("monthNameWithYear" , monthNameWithYear)
                    monthNameLabel.text = monthNameWithYear
        }
        
        if let firstRequest = loginrequests.first {
            let assignedDate = firstRequest.assignedDate
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMMM, yyyy"
            
            if let date = dateFormatter.date(from: assignedDate) {
                calenderView.setCurrentPage(date, animated: true)
                // monthNameLabel.text = monthNameWithYear
                
                today = date
                
                calenderView.today = today
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMMM yyyy"
                
                let monthNameWithYear = dateFormatter.string(from: date)
                print("monthNameWithYear" , monthNameWithYear)
                monthNameLabel.text = monthNameWithYear
                
                
                calenderView.reloadData()
            }
        }
        
    }
    
    
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool
    {
        if isOpenCalendarForVacation{
            let mydate = DateFormatter()
            mydate.dateFormat = "MM/dd/yyyy"
            let dateString : String = mydate.string(from:date)
            if self.leavesArray.contains(dateString)
            {
                return false
            }
            else
            {
                return true
            }
        }
        else{
            return true
        }
    }
    
    
    
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let mydate = DateFormatter()
        mydate.dateFormat = "MM/dd/yyyy"
        let dateString : String = mydate.string(from:date)
        if self.leavesArray.contains(dateString) {
            return UIColor(red: 26/255, green: 50/255, blue: 120/255, alpha: 1.0)
        } else {
            return nil
        }
        
        
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let mydate = DateFormatter()
        mydate.dateFormat = "MM/dd/yyyy"
        let dateString : String = mydate.string(from:date)
        if self.leavesArray.contains(dateString) {
            return .white
        } else {
            return nil
        }
    }
    
    
    func getStartAndEndDateOfMonth() {
        let currentPage = calenderView.currentPage
        let calendar = Calendar.current
        
        guard let startDate = calendar.date(from: calendar.dateComponents([.year, .month], from: currentPage)) else {
            return
        }
        guard let endDate = calendar.date(byAdding: DateComponents(month: 1, day: -1), to: startDate) else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let startDateString = dateFormatter.string(from: startDate)
        let endDateString = dateFormatter.string(from: endDate)
        
        print("Start Date:", startDateString)
        print("End Date:", endDateString)
    }
    
    func RoutedetailDataAPI(){
        ApiFunc.shared.newDetailOnRouteTime(self.view) { [self] responseModel in
            print("DidSelect-------responseModel.data.type---->", responseModel.data.type)
            SingleTon.shared.typeID = responseModel.data.type
            if responseModel.data.type == 1 {
                agree2Stack.isHidden = false
                isOnRouteBtnTapped = true
                makeReportBtn.isHidden = false
                onRoutebtn.isHidden = true
                
                Indicator.sharedInstance.hideIndicator()
            }else {
                print ("#####000000######")
                agree2Stack.isHidden = false
                isOnRouteBtnTapped = false
                makeReportBtn.isHidden = false
                onRoutebtn.isHidden = false
                
                Indicator.sharedInstance.hideIndicator()
                
            }
        }
        
        
    }
    
}

extension CalanderHomeVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.loginrequests.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.loginrequests[section].data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CalanderHomeViewCell", for: indexPath) as! CalanderHomeViewCell
        cell.lbl_Appointment.text =  self.loginrequests[indexPath.section].data[indexPath.item].fullName
        cell.lbl_time.text =  loginrequests[indexPath.section].data[indexPath.item].buildingNo + " " + loginrequests[indexPath.section].data[indexPath.item].addressLine1 + ", " + loginrequests[indexPath.section].data[indexPath.item].city + ", " + loginrequests[indexPath.section].data[indexPath.item].state
        cell.lbl_Location.text = "(\(self.loginrequests[indexPath.section].data[indexPath.item].inspectionType))"
        // cell.llbl_Name.text = self.loginrequests[indexPath.section].data[indexPath.item].assignedTime
        
        //  let dateFormatter = DateFormatter()
        //  dateFormatter.dateFormat = "HH:mm"
        //        let datasting = self.loginrequests[indexPath.section].data[indexPath.item].assignedTime
        //
        //        if datasting != nil {
        //            if let date = dateFormatter.date(from: datasting) {
        //                dateFormatter.dateFormat = "h:mm a"
        //                let formattedTime = dateFormatter.string(from: date)
        //                cell.llbl_Name.text = formattedTime
        //            } else {
        //                print("Invalid input time format")
        //            }
        //        } else {
        //            print("Assigned time is nil")
        //        }
        
        
        let datasting = self.loginrequests[indexPath.section].data[indexPath.item].assignedTime
        
        if datasting != nil {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "h:mm a"
            
            if let date = dateFormatter.date(from: datasting) {
                dateFormatter.dateFormat = "h:mm a"
                let formattedTime = dateFormatter.string(from: date)
                cell.llbl_Name.text = formattedTime
            } else {
                dateFormatter.dateFormat = "HH:mm"
                if let date = dateFormatter.date(from: datasting) {
                    dateFormatter.dateFormat = "h:mm a"
                    let formattedTime = dateFormatter.string(from: date)
                    cell.llbl_Name.text = formattedTime
                } else {
                    print("Invalid input time format")
                }
            }
        } else {
            print("Assigned time is nil")
        }
        
        
        cell.vw_Top.backgroundColor = colors[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CalanderHomeReusableView", for: indexPath) as! CalanderHomeReusableView
        headerView.lbl_Header.text = self.loginrequests[indexPath.section].assignedDate
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //   let model = SectionDataHandler.shared.model
        //  UserDefaults.standard.set("", forKey: "model")
        print(indexPath.row)
        
        SingleTon.shared.reqesedtUserId = loginrequests[indexPath.section].data[indexPath.item].id
        SectionDataHandler.shared.selectedReportId = loginrequests[indexPath.section].data[indexPath.item].id
        SectionDataHandler.shared.Buildingids = loginrequests[indexPath.section].data[indexPath.item].buildingNo
        RoutedetailDataAPI()
        
        if loginrequests[indexPath.section].data[indexPath.item].inspectorInspectionStatus == "0"{
            //  openActionSheet(index: indexPath.row)
            agreeStackVw.isHidden = false
            AcceptIndex = indexPath.row
            Acceptsection = indexPath.section
            agree2Stack.isHidden = true
            makeReportBtn.isHidden = true
            onRoutebtn.isHidden = true
            
        }
        else{
            agreeStackVw.isHidden = true
            agree2Stack.isHidden = true
            makeReportBtn.isHidden = true
            onRoutebtn.isHidden = true
            
            
        }
        
        selectedIndex = indexPath.row
        
        
        UIView.transition(with: self.view, duration: 1, options: [.curveEaseIn], animations: {
            self.view.addSubview(self.popUpView)
        }, completion: nil)
        
        if isOnRouteBtnTapped == false {
            makeReportBtn.isHidden = false
            onRoutebtn.isHidden = false
        }else{
            makeReportBtn.isHidden = false
            onRoutebtn.isHidden = true
        }
        
        popUpView.updatePopUpViewConstraints(Of: popUpView, to: self.view)
        userTxtLabel_pop.text = loginrequests[indexPath.section].data[indexPath.row].fullName
        inspectionType.text = loginrequests[indexPath.section].data[indexPath.row].inspectionType
        numberTxtLabel_pop.text = loginrequests[indexPath.section].data[indexPath.row].mobileNumber
        locationTxtLabel_pop.text = loginrequests[indexPath.section].data[indexPath.row].addressLine1 + ", " + loginrequests[indexPath.section].data[indexPath.row].city + ", " + loginrequests[indexPath.section].data[indexPath.row].state
        notes.text = "    "+loginrequests[indexPath.section].data[indexPath.row].notes
        print(loginrequests[indexPath.section].data[indexPath.row].notes)
        let myImg = ApiUrl.ProfileImgBase + loginrequests[indexPath.section].data[indexPath.row].profileImage
        let imageUrl = URL(string: myImg)!
        
        SingleTon.shared.clientName = loginrequests[indexPath.section].data[indexPath.row].fullName
        SingleTon.shared.requestStreetNuber = loginrequests[indexPath.section].data[indexPath.row].streetNumber
        SingleTon.shared.requestAddressLine1 = loginrequests[indexPath.section].data[indexPath.row].addressLine1
        SingleTon.shared.requestAddressLine2 = loginrequests[indexPath.section].data[indexPath.row].addressLine2
        SingleTon.shared.requestCity = loginrequests[indexPath.section].data[indexPath.row].city
        SingleTon.shared.requestState = loginrequests[indexPath.section].data[indexPath.row].state
        SingleTon.shared.postalCode = loginrequests[indexPath.section].data[indexPath.row].postalCode
        
        //        if loginrequests[indexPath.section].data[indexPath.row].onRouteTime != "" {
        //            isOnRouteBtnTapped = true
        //        }
        //SingleTon.shared.onRoute = loginrequests[indexPath.section].data[indexPath.row].onRouteTime
        
        
        popUserImage.loadImage(fromURL: imageUrl, placeHolderImage: "user")
        
        
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.time_CollectionVW.frame.width / 2)-5, height: 80)
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    //    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    //        return UICollectionViewFlowLayout.automaticSize
    //    }
    
}
extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
extension UIView {
    func roundCornerss(corners: UIRectCorner, radius: CGFloat, newWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: newWidth, height: bounds.height), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        
        frame.size.width = newWidth
    }
}
extension UITabBar {
    func addTopBorder(color: UIColor, height: CGFloat) {
        let topBorder = CALayer()
        topBorder.backgroundColor = color.cgColor
        topBorder.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: height)
        self.layer.addSublayer(topBorder)
    }
}
