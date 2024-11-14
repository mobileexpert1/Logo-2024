//
//  HomeViewController.swift
//  Logo
//
//  Created by Mobile on 03/04/24.
//

import UIKit
import MSCircularSlider
import iOSDropDown
import SDWebImage
import CoreLocation
import PKHUD
import SevenSwitch
class HomeViewController: UIViewController,CLLocationManagerDelegate {
//main home screen//
    @IBOutlet weak var profileImgVw: UIImageView!
    @IBOutlet weak var logoutBtn: UIImageView!
    @IBOutlet weak var super_VW: UIView!
    @IBOutlet weak var switch_Top: UISwitch!
    @IBOutlet weak var vwFirst: UIView!
    @IBOutlet weak var vwsecond: UIView!
    @IBOutlet weak var vwthree: UIView!
    @IBOutlet weak var vwFour: UIView!
    @IBOutlet weak var vwFive: UIView!
    @IBOutlet weak var vwsix: UIView!
    @IBOutlet weak var vwseven: UIView!
    @IBOutlet weak var vwEight: UIView!
    @IBOutlet weak var vwNine: UIView!
    @IBOutlet weak var vwtop: UIView!
    
    @IBOutlet weak var lbl_DarkMode: UILabel!
    @IBOutlet weak var darkVW: UIView!
    @IBOutlet weak var vwimgone: UIView!
    @IBOutlet weak var vwimgTwo: UIView!
    @IBOutlet weak var vwimgThree: UIView!
    @IBOutlet weak var vwimgFour: UIView!
    @IBOutlet weak var vwimgFive: UIView!
    @IBOutlet weak var vwimgSix: UIView!
    @IBOutlet weak var vwimgSeven: UIView!
    @IBOutlet weak var vwimgEight: UIView!
    @IBOutlet weak var vwimgNine: UIView!
    
    @IBOutlet weak var vw_AppliedLeaves: UIView!
    @IBOutlet weak var vw_NoProject: UIView!
    
    @IBOutlet weak var lbl_Clock: UILabel!
    @IBOutlet weak var punchTimerLbl: UILabel!
    @IBOutlet weak var circllarSlider: MSCircularSlider!
    
    //topvw
    @IBOutlet weak var timer_TopVw: UIView!
    
    @IBOutlet weak var dark_TopVw: UIView!
    
    @IBOutlet weak var schedulereqTop_vw: UIView!
    @IBOutlet weak var schedule_TopVw: UIView!
    @IBOutlet weak var vacation_Topvw: UIView!
    @IBOutlet weak var Exp_topVw: UIView!
    @IBOutlet weak var work_orderTopVw: UIView!
    
    @IBOutlet weak var askadmin_TopVw: UIView!
    @IBOutlet weak var createproject_TopVw: UIView!
    
    @IBOutlet weak var timeSheet_TopVw: UIView!
    
    @IBOutlet weak var safety_TopVw: UIView!
    
    @IBOutlet weak var back_Vw: UIView!
    @IBOutlet weak var empty_CenterVw: UIView!
    @IBOutlet weak var empty_Vw: UIView!
    //Label
    
    @IBOutlet weak var bgImgVw: UIImageView!
    @IBOutlet weak var noOfProjectsLbl: UILabel!
   
    @IBOutlet weak var lbl_Expense: UILabel!
    @IBOutlet weak var lbl_WorkOrder: UILabel!
    @IBOutlet weak var lbl_AppliedLeaves: UILabel!
    @IBOutlet weak var aplliedLeavesLbl: UILabel!
    @IBOutlet weak var lbl_NoProject: UILabel!
    
    @IBOutlet weak var lbl_CreateProject: UILabel!
    @IBOutlet weak var lbl_ScheduleReq: UILabel!
    @IBOutlet weak var lbl_Schedule: UILabel!
    @IBOutlet weak var lbl_Vacations: UILabel!
    @IBOutlet weak var lbl_AskAdmin: UILabel!
    
    @IBOutlet weak var lbl_Welcome: UILabel!
    @IBOutlet weak var lbl_Meeting: UILabel!
    @IBOutlet weak var lbl_TimeSheet: UILabel!
    
    @IBOutlet weak var lbl_TitleName: UILabel!
    
    //Backbtn
    
    @IBOutlet weak var btn_Back: UIButton!
    
    @IBOutlet weak var pinchday: UILabel!
    
    //imgvwarrowbtn
   
    
    @IBOutlet weak var img_ExpArrow: UIButton!
    
    
    @IBOutlet weak var img_VacArrow: UIButton!
    
    @IBOutlet weak var img_ScdArrow: UIButton!
    
    @IBOutlet weak var btn_ScdReqArrow: UIButton!
    
   
    @IBOutlet weak var mySwitch: UISwitch!
    
    @IBOutlet weak var btn_ScheduleArrow: UIButton!
    
    @IBOutlet weak var btn_ArrowSchReq: UIButton!
    
    @IBOutlet weak var btn_askArrow: UIButton!
    @IBOutlet weak var btn_CreProjectArrow: UIButton!
    
    
    @IBOutlet weak var btn_timeArrow: UIButton!
    
    
    @IBOutlet weak var expenseTitleTxtFld: UITextField!
    @IBOutlet weak var expensePriceTxtFld: UITextField!
  
    @IBOutlet weak var expenseCategoryTxtFld: DropDown!
    @IBOutlet weak var expenseProjectTxtFld: DropDown!
    @IBOutlet weak var recieptImgVw: UIImageView!
   
    @IBOutlet weak var expenseCheckBox: UIImageView!
    @IBOutlet weak var expenseView: UIView!
    @IBOutlet weak var expenseVw: UIView!
    @IBOutlet weak var alphaImgVw: UIImageView!
    var isSwitchOn: Bool = false
    
    @IBOutlet weak var notification_Vw: UIView!
    
    @IBOutlet weak var notification_CenterVw: UIView!
    
    @IBOutlet weak var lbl_Notification: UILabel!
    
    @IBOutlet weak var img_TopVw: UIView!
    
    @IBOutlet weak var btn_Notification: UIButton!
    
    @IBOutlet weak var injuryTxtFld: DropDown!
    
    
    @IBOutlet weak var injuryPopUp: UIView!
   
   
    @IBOutlet weak var injuryTxtVw: UITextView!
    @IBOutlet weak var explainVw: UIView!
  
    @IBOutlet weak var startDayVw: UIView!
    
    //centerimgvw
    @IBOutlet weak var img_vwwork: UIImageView!
    @IBOutlet weak var img_vwExp: UIImageView!
    @IBOutlet weak var img_vwVacation: UIImageView!
    @IBOutlet weak var img_vwSchedule: UIImageView!
    @IBOutlet weak var img_vwScheReq: UIImageView!
    @IBOutlet weak var img_vwCreatePro: UIImageView!
    @IBOutlet weak var img_vwAskto: UIImageView!
    @IBOutlet weak var img_vwTimesheet: UIImageView!
    @IBOutlet weak var img_vwSafety: UIImageView!
    @IBOutlet weak var img_vwNoti: UIImageView!
    
    
    
    
    
    
    // MARK: - VARIABLES
    var namedata : String?
    var StartDate : Date?
    var EndDate : Date?
    var StartDateStr : String?
    var EndDateStr : String?
    var expenseCategoryArr : [ExpenseDatum] = []
    var categoryArr : [String] = []
    var imagePicker = UIImagePickerController()
    var isOpenCameraForExpense = false
    var isOpenCalendarForVacation = true
    var lat = ""
    var long = ""
    var profileImg : UIImage = UIImage(named: "user")!
    var locManager : CLLocationManager?
    var applyLeavesArray : [String] = []
    var leavesArray : [String] = []
    var isCheckedForExpense = false
    var loginrequest = [Request]()
    var expenseCattId = 0
    var allProjectsArray : [String] = []
    var allProjectsIdArray : [String] = []
  
    var leaveTypeArray = ["Unpaid","Paid"]
  let optionArr = ["Yes","No"]
    var timer:Timer?
    var timeCount = 0
    var clockedInIdArray : [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        //injuryTxtFld.delegate = self
        mySwitch.isOn = isSwitchOn
        updateBackgroundColor()
        alphaImgVw.isUserInteractionEnabled = true
        didLoadMethods()
        UIViewSetting()
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager?.requestAlwaysAuthorization()
    
      
        mySwitch.addTarget(self, action: #selector(SwtchModeAction), for: UIControl.Event.valueChanged)
        HideViews()
        switch_Top.tintColor = .blue
        profileImgVw.alpha = 1.0
       // pinchday.text = "Start"
    }
    
    
    @objc func SwtchModeAction(){
        
        if ThemeManager.currentTheme == .light {
            LocalStore.shared.isDarkMode = true
            ThemeManager.applyTheme(.dark)
        } else {
            LocalStore.shared.isDarkMode = false
            ThemeManager.applyTheme(.light)
        }
        
    }
   
    
    // MARK: - VIEW_WILL_APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        switch_Top.isOn = false
        var currentLocation: CLLocation!
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager?.location
            lat = currentLocation.coordinate.latitude.description
            long = currentLocation.coordinate.longitude.description
        }
        dashboardDataAPI()
        
        if LocalStore.shared.isDarkMode == false {
            mySwitch.isOn = true
            ThemeManager.applyTheme(.dark)
            ThemeManager.applyTheme(.dark)
        } else {
            mySwitch.isOn = false
            ThemeManager.applyTheme(.light)
        }
        updateBackgroundColor()
    }
    
    
    func dashboardDataAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.DashboardDataUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : DashboardModel?) in
            let dashboardData = success!.data
            categoryArr.removeAll()
            self.expenseCategoryArr = dashboardData.expenseData
            if dashboardData.punchData == 0{
                SingleTon.shared.isPunchedIn = false
            }
            else{
                SingleTon.shared.isPunchedIn = true
            }
            for i in 0..<self.expenseCategoryArr.count{
                categoryArr.append(self.expenseCategoryArr[i].name)
            }
            expenseCategoryTxtFld.optionArray = categoryArr
            profileImgVw.sd_setImage(with: URL(string: ApiUrl.ProfileImgBase + dashboardData.profilePic), placeholderImage: UIImage(named: "user"))
            profileImg = profileImgVw.image!
            lbl_TitleName.text = dashboardData.userName
             namedata = dashboardData.userName
            noOfProjectsLbl.text = dashboardData.projectCount.description
            aplliedLeavesLbl.text = dashboardData.approvedLeaveCount.description
        //    punchInListAPI(type : "0")
            
            
          
            if dashboardData.punchData == 0{
              //  dayPunchSwitch.setOn(false, animated: false)
                punchTimerLbl.text = "00:00"
                timeCount = 0
                if timer != nil{
                    timer?.invalidate()
                }
            }
            else{
              //  dayPunchSwitch.setOn(true, animated: true)
                timeCount = dashboardData.punchData
                timerMethod()
                pinchday.text = "End"
            }
        }
    }
    // MARK: - ALL_PROJECTS_API
    func punchInListAPI(type : String){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ClockInListUrl, method: .post, parameters: ["sessionToken" : SingleTon.shared.userToken,"lat" : lat,"long" : long, "type" : type]) { [self] (success : ClockInListModel?) in
            let myProjectsArr = success!.data.projects
            self.allProjectsArray.removeAll()
           myProjectsArr.forEach({ data in
                self.allProjectsArray.append(data.fullName)
               self.allProjectsIdArray.append(data.id)
            })
            expenseProjectTxtFld.optionArray = allProjectsArray
        }
    }
    
    internal func drawUnfilledCircle(ctx: CGContext, center: CGPoint, radius: CGFloat, lineWidth: CGFloat, maximumAngle: CGFloat, lineCap: CGLineCap) {
        
        drawArc(ctx: ctx, center: center, radius: radius, lineWidth: 30, fromAngle: 0, toAngle: maximumAngle, lineCap: lineCap)
    }
    internal func drawArc(ctx: CGContext, center: CGPoint, radius: CGFloat, lineWidth: CGFloat, fromAngle: CGFloat, toAngle: CGFloat, lineCap: CGLineCap) {
        let cartesianFromAngle = toCartesian(toRad(Double(fromAngle)))
        let cartesianToAngle = toCartesian(toRad(Double(toAngle)))
        
        ctx.addArc(center: center, radius: radius, startAngle: CGFloat(cartesianFromAngle), endAngle: CGFloat(cartesianToAngle), clockwise: false)
        
        ctx.setLineWidth(lineWidth)
        ctx.setLineCap(lineCap)
        ctx.drawPath(using: CGPathDrawingMode.stroke)
    }
    private func toCartesian(_ compassRad: Double) -> Double {
        return compassRad - (Double.pi / 2)
    }
    private func toRad(_ degrees: Double) -> Double {
        return ((Double.pi * degrees) / 180.0)
    }
    
    /** Converts radians to degrees */
    private func toDeg(_ radians: Double) -> Double {
        return ((180.0 * radians) / Double.pi)
    }
    
    func UIViewSetting(){
        applyStyling(to: vwFirst)
        applyStyling(to: vwsecond)
        applyStyling(to: vwthree)
        applyStyling(to: vwFour)
        applyStyling(to: vwFive)
        applyStyling(to: vwsix)
        applyStyling(to: vwseven)
        applyStyling(to: vwEight)
        applyStyling(to: vwNine)
        applyStyling(to: notification_CenterVw)
        
        applyStyling(to: vwimgone)
        applyStyling(to: vwimgTwo)
        applyStyling(to: vwimgThree)
        applyStyling(to: vwimgFour)
        applyStyling(to: vwimgFive)
        applyStyling(to: vwimgSix)
        applyStyling(to: vwimgSeven)
        applyStyling(to: vwimgEight)
        applyStyling(to: vwimgNine)
        applyStyling(to: darkVW)
        applyStyling(to: vw_AppliedLeaves)
        applyStyling(to: vw_NoProject)
        applyStyling(to: img_TopVw)
        circllarSlider.unfilledColor = ThemeColor.lightThemeImageTintColor
        circllarSlider.unfilledColor = .lightGray
    //    timerMethod()
       // timerVw.sliderLineThickness = 100
    }
    
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           super.traitCollectionDidChange(previousTraitCollection)

          
           updateBackgroundColor()
       }
    
    // MARK: - CLOCK_TIMER_METHOD
    func timerMethod(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
           
            self.timeCount += 1
            print("Timer fired! \(timeCount)")
            let hourValue = self.timeCount/3600
            let hourRemValue = self.timeCount%3600
            let minValue = hourRemValue/60
            let minRemValue = hourRemValue%60
            
            var hourValueStr = ""
            var minValueStr = ""
            
            if hourValue<10{
                hourValueStr = "0\(hourValue.description)"
            }
            else{
                hourValueStr = hourValue.description
            }
            if minValue<10{
                minValueStr = "0\(minValue.description)"
            }
            else{
                minValueStr = minValue.description
            }
            self.punchTimerLbl.text = "\(hourValueStr):\(minValueStr)"
            self.circllarSlider.currentValue = Double(self.timeCount)
            
        }
    }

    

    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
               
                if traitCollection.userInterfaceStyle == .dark {
                    
                    logoutBtn.tintColor = .white
                    pinchday.textColor = ThemeColor.darkThemeTextColor
                    img_ExpArrow.tintColor = ThemeColor.darkThemeImageTintColor
                    
                    img_VacArrow.tintColor = ThemeColor.darkThemeImageTintColor
                    
                    btn_ScdReqArrow.tintColor = ThemeColor.darkThemeImageTintColor
                    btn_ScheduleArrow.tintColor = ThemeColor.darkThemeImageTintColor
                    btn_askArrow.tintColor = ThemeColor.darkThemeImageTintColor
                    btn_CreProjectArrow.tintColor = ThemeColor.darkThemeImageTintColor
                   
                    btn_ArrowSchReq.tintColor = ThemeColor.darkThemeImageTintColor
                    btn_timeArrow.tintColor = ThemeColor.darkThemeImageTintColor
                    
                    btn_Back.tintColor = ThemeColor.darkThemeImageTintColor
                    btn_Notification.tintColor = ThemeColor.darkThemeImageTintColor
                  
                   // super_VW.backgroundColor = ThemeColor.darkThemeViewBGColor
                    vwtop.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwFirst.backgroundColor = ThemeColor.darkThemeViewBGColor
                punchTimerLbl.backgroundColor = ThemeColor.darkThemeViewBGColor
                vw_AppliedLeaves.backgroundColor = ThemeColor.darkThemeViewBGColor
                vw_NoProject.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwimgNine.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwimgEight.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwimgSeven.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwimgSix.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwimgFive.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwimgFour.backgroundColor = ThemeColor.darkThemeViewBGColor
                    img_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwimgThree.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwimgTwo.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwimgone.backgroundColor = ThemeColor.darkThemeViewBGColor
                darkVW.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwFirst.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwsecond.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwthree.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwFour.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwFive.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwsix.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwseven.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwEight.backgroundColor = ThemeColor.darkThemeViewBGColor
                vwNine.backgroundColor = ThemeColor.darkThemeViewBGColor
                    notification_Vw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    notification_CenterVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                   
                    schedule_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
               

                    timer_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    dark_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    schedulereqTop_vw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    vacation_Topvw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    Exp_topVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    work_orderTopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    timeSheet_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    safety_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    timer_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    empty_Vw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    createproject_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    askadmin_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    empty_CenterVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    back_Vw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    
                    
                    lbl_Notification.textColor = ThemeColor.darkThemeTextColor
                    noOfProjectsLbl.textColor = ThemeColor.darkThemeTextColor
                    lbl_Expense.textColor = ThemeColor.darkThemeTextColor
                    lbl_WorkOrder.textColor = ThemeColor.darkThemeTextColor
                    lbl_AppliedLeaves.textColor = ThemeColor.darkThemeTextColor
                    aplliedLeavesLbl.textColor = ThemeColor.darkThemeTextColor
                    lbl_NoProject.textColor = ThemeColor.darkThemeTextColor
                    lbl_ScheduleReq.textColor = ThemeColor.darkThemeTextColor
                    lbl_Schedule.textColor = ThemeColor.darkThemeTextColor
                    lbl_Vacations.textColor = ThemeColor.darkThemeTextColor
                    lbl_AskAdmin.textColor = ThemeColor.darkThemeTextColor
                   // lbl_Welcome.textColor = ThemeColor.lightThemeTextColor
                    lbl_Meeting.textColor = ThemeColor.darkThemeTextColor
                    lbl_TimeSheet.textColor = ThemeColor.darkThemeTextColor
                  //  lbl_TitleName.textColor = ThemeColor.lightThemeTextColor
                    lbl_CreateProject.textColor = ThemeColor.darkThemeTextColor
                    lbl_Clock.textColor = ThemeColor.darkThemeTextColor
                    lbl_DarkMode.textColor = ThemeColor.darkThemeTextColor
                    bgImgVw.image = UIImage(named: "Dashboard2")
                    switch_Top.onTintColor = .green
                
                    
                   
                    
                    img_vwwork.tintColor = ThemeColor.darkThemeImageTintColor
                    img_vwExp.tintColor = ThemeColor.darkThemeImageTintColor
                    img_vwVacation.tintColor = ThemeColor.darkThemeImageTintColor
                    img_vwSchedule.tintColor = ThemeColor.darkThemeImageTintColor
                    img_vwScheReq.tintColor = ThemeColor.darkThemeImageTintColor
                    img_vwCreatePro.tintColor = ThemeColor.darkThemeImageTintColor
                    img_vwAskto.tintColor = ThemeColor.darkThemeImageTintColor
                    img_vwTimesheet.tintColor = ThemeColor.darkThemeImageTintColor
                    img_vwSafety.tintColor = ThemeColor.darkThemeImageTintColor
                    img_vwNoti.tintColor = ThemeColor.darkThemeImageTintColor
                    img_VacArrow.tintColor = ThemeColor.darkThemeImageTintColor
                    punchTimerLbl.textColor = ThemeColor.darkThemeTextColor
                } else {
                    logoutBtn.tintColor = ThemeColor.lightThemeImageTintColor
                    pinchday.textColor = ThemeColor.lightThemeTextColor
                    punchTimerLbl.textColor = ThemeColor.lightThemeTextColor
                    img_VacArrow.tintColor = ThemeColor.lightThemeImageTintColor
                    img_vwwork.tintColor = ThemeColor.lightThemeImageTintColor
                    img_vwExp.tintColor = ThemeColor.lightThemeImageTintColor
                    img_vwVacation.tintColor = ThemeColor.lightThemeImageTintColor
                    img_vwSchedule.tintColor = ThemeColor.lightThemeImageTintColor
                    img_vwScheReq.tintColor = ThemeColor.lightThemeImageTintColor
                    img_vwCreatePro.tintColor = ThemeColor.lightThemeImageTintColor
                    img_vwAskto.tintColor = ThemeColor.lightThemeImageTintColor
                    img_vwTimesheet.tintColor = ThemeColor.lightThemeImageTintColor
                    img_vwSafety.tintColor = ThemeColor.lightThemeImageTintColor
                    img_vwNoti.tintColor = ThemeColor.lightThemeImageTintColor
                    
                    img_ExpArrow.tintColor = ThemeColor.lightThemeImageTintColor
                    img_VacArrow.tintColor = ThemeColor.lightThemeImageTintColor
                    
                    btn_ArrowSchReq.tintColor = ThemeColor.lightThemeImageTintColor
                    btn_ScheduleArrow.tintColor = ThemeColor.lightThemeImageTintColor
                    btn_askArrow.tintColor = ThemeColor.lightThemeImageTintColor
                    btn_CreProjectArrow.tintColor = ThemeColor.lightThemeImageTintColor
                    btn_timeArrow.tintColor = ThemeColor.lightThemeImageTintColor
                   btn_ScdReqArrow.tintColor = ThemeColor.lightThemeImageTintColor
                 
                btn_Back.tintColor = ThemeColor.lightThemeImageTintColor
                    
                    btn_Notification.tintColor = ThemeColor.lightThemeImageTintColor
                    
                    
                    
                    
                    
                  
                    
                  //  super_VW.backgroundColor = ThemeColor.lightThemeViewBGColor
                    notification_Vw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    notification_CenterVw.backgroundColor = ThemeColor.lightThemeViewBGColorvw
                    switch_Top.onTintColor = .white
                    bgImgVw.image = UIImage(named: "ChangeDashboard")
                  
                    
                    back_Vw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    empty_CenterVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    schedule_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    vwtop.backgroundColor = ThemeColor.lightThemeViewBGColor
                vwFirst.backgroundColor = ThemeColor.lightThemeViewBGColor
                punchTimerLbl.backgroundColor = ThemeColor.lightThemeViewBGColor
                vw_AppliedLeaves.backgroundColor = ThemeColor.lightThemeViewBGColor
                vw_NoProject.backgroundColor = ThemeColor.lightThemeViewBGColor
                vwimgNine.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
                vwimgEight.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
                vwimgSeven.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
                vwimgSix.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
                vwimgFive.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
                vwimgFour.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
                vwimgThree.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
                img_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
                vwimgTwo.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
                vwimgone.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
                darkVW.backgroundColor = ThemeColor.lightThemeViewBGColor
                    
                    
                vwFirst.backgroundColor = ThemeColor.lightThemeViewBGColorvw
                vwsecond.backgroundColor = ThemeColor.lightThemeViewBGColorvw
                vwthree.backgroundColor = ThemeColor.lightThemeViewBGColorvw
                vwFour.backgroundColor = ThemeColor.lightThemeViewBGColorvw
                vwFive.backgroundColor = ThemeColor.lightThemeViewBGColorvw
                vwsix.backgroundColor = ThemeColor.lightThemeViewBGColorvw
                vwseven.backgroundColor = ThemeColor.lightThemeViewBGColorvw
                vwEight.backgroundColor = ThemeColor.lightThemeViewBGColorvw
                vwNine.backgroundColor = ThemeColor.lightThemeViewBGColorvw
                    
                    timer_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    dark_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    schedulereqTop_vw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    vacation_Topvw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    Exp_topVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    work_orderTopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    timeSheet_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    safety_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    timer_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    empty_Vw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    createproject_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    askadmin_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    
                    
                    
                    noOfProjectsLbl.textColor = ThemeColor.lightThemeTextColor
                    lbl_Notification.textColor = ThemeColor.lightThemeTextColor
                    lbl_Expense.textColor = ThemeColor.lightThemeTextColor
                    lbl_WorkOrder.textColor = ThemeColor.lightThemeTextColor
                    lbl_AppliedLeaves.textColor = ThemeColor.lightThemeTextColor
                    aplliedLeavesLbl.textColor = ThemeColor.lightThemeTextColor
                    lbl_NoProject.textColor = ThemeColor.lightThemeTextColor
                    lbl_ScheduleReq.textColor = ThemeColor.lightThemeTextColor
                    lbl_Schedule.textColor = ThemeColor.lightThemeTextColor
                    lbl_Vacations.textColor = ThemeColor.lightThemeTextColor
                    lbl_AskAdmin.textColor = ThemeColor.lightThemeTextColor
                    lbl_Welcome.textColor = ThemeColor.darkThemeTextColor
                    lbl_CreateProject.textColor = ThemeColor.lightThemeTextColor
                    lbl_Meeting.textColor = ThemeColor.lightThemeTextColor
                    lbl_Meeting.textColor = ThemeColor.lightThemeTextColor
                    lbl_TimeSheet.textColor = ThemeColor.lightThemeTextColor
                    lbl_TitleName.textColor = ThemeColor.darkThemeTextColor
                    
                    lbl_DarkMode.textColor = ThemeColor.lightThemeTextColor
                    lbl_Clock.textColor = ThemeColor.lightThemeViewBGColorClock
               //     btn_Back.backgroundColor = ThemeColor.lightThemeTextColor
             //       injuryTxtFld.attributedPlaceholder = NSAttributedString(string: "Select",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                }
            } else {
                // Fallback for earlier versions
            //    UIView.appearance().backgroundColor = .white
            }

            // Refresh the view hierarchy to apply the new background color
            view.setNeedsDisplay()
        }
    // MARK: - VIEW_DID_LOAD_CALLING_METHODS
    func didLoadMethods(){
//        NotificationCenter.default.addObserver(self, selector: #selector(openForSchedule), name: Notification.Name("Schedule"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(openForNotification), name: Notification.Name("Accept"), object: nil)
        LocationDidloadRequirements()
    actionBlocks()
        SetUI()
        delegates()
        HideViews()
        expenseCategoryTxtFld.didSelect { selectedText, index, id in
            print("Selected Text \(selectedText)")
            self.expenseCattId = Int(self.expenseCategoryArr[index].id)!
            self.expenseProjectTxtFld.didSelect { selectedText, index, id in
                print("Selected Text \(selectedText)")
               
            }
          
        }
        self.injuryTxtFld.optionArray = self.optionArr
            self.injuryTxtFld.didSelect { selectedText, index, id in
            if selectedText == "No"{
                self.PunchDayAPI()
                self.injuryPopUp.isHidden = true
                self.alphaImgVw.isHidden = true
            }
            else if selectedText == "Yes"{
                self.explainVw.isHidden = false
            }
        }
        
        
        // MARK: - DELEGATES_SELF
        func delegates(){
          
            expenseCategoryTxtFld.delegate = self
          
            expenseProjectTxtFld.delegate = self
            injuryTxtFld.delegate = self
            
        }
        func SetUI(){
           
            punchTimerLbl.text = "00:00"
            
            circllarSlider.handleType = .smallCircle
            circllarSlider.handleColor = .systemGreen
            circllarSlider.filledColor = .systemGreen
            circllarSlider.currentValue = Double(timeCount)
            injuryPopUp.clipsToBounds = true
            injuryPopUp.layer.cornerRadius = 10.0
            
            expenseVw.clipsToBounds = true
            expenseVw.layer.cornerRadius = 10.0
            recieptImgVw.clipsToBounds = true
            recieptImgVw.layer.cornerRadius = 50.0
           
          //  profileImgVw.clipsToBounds = true
            profileImgVw.layer.cornerRadius = 17.5
            profileImgVw.contentMode = .scaleToFill
            
        }
        func LocationDidloadRequirements(){
            locManager = CLLocationManager()
            locManager!.delegate = self
            locManager!.requestWhenInUseAuthorization()
            locManager?.requestAlwaysAuthorization()
          
//            txt_FldProjectName.layer.cornerRadius = 12
//            txt_FldContractorName.layer.cornerRadius = 12
//            txt_FldAddressName.layer.cornerRadius = 12
//            txt_FldStateName.layer.cornerRadius = 12
//            txt_FldCityName.layer.cornerRadius = 12
//            txt_FldPostalName.layer.cornerRadius = 12
        }
        
        expenseProjectTxtFld.didSelect { selectedText, index, id in
            print("Selected Text \(selectedText)")
        }
        
       
    }
    
    
    
    @IBAction func btn_NextMove(_ sender: Any) {
        if let button = sender as? UIButton {
                if button.tag == 0 {
                    print("Work Order Tapped")
                  //  openWorkOrder()
                    self.addHapticFeedback()
                    openWorkOrderHome()
                } else if button.tag == 1 {
                    print("expenseView Tapped")
                    self.addHapticFeedback()
                    expenseCheckBox.image = UIImage(named: "uncheckB")
                    isOpenCameraForExpense = true
                    openCamera()
                }else if button.tag == 2 {
                    let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VacationsVC") as! VacationsVC
                    self.navigationController?.pushViewController(VC, animated: true)
                }
            else if button.tag == 3 {
                print("holidaysVw Tapped")
                let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScheduleVC") as! ScheduleVC
                self.navigationController?.pushViewController(VC, animated: true)
//                self.addHapticFeedback()
//                GetLeavesAPI()
            }else if button.tag == 4 {
                self.addHapticFeedback()
                openScheduleRequestVC()
            }else if button.tag == 5 {
                self.addHapticFeedback()
                let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateProjectVC") as! CreateProjectVC
                self.navigationController?.pushViewController(VC, animated: true)
                
            }else if button.tag == 6 {
                let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubjectDiscussVC") as! SubjectDiscussVC
                self.navigationController?.pushViewController(VC, animated: true)
                
                
            }else if button.tag == 7 {
                self.addHapticFeedback()
                let date = Date()
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "EEEE" // OR "dd-MM-yyyy"
                let currentDateString: String = dateFormatter.string(from: date)
                print("Current date is \(currentDateString)")
                print("Current date is \(currentDateString)")
                    let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FSCalendarVC") as! FSCalendarVC
                // VC.isTimesheetAdded = isTimesheetAdded
                    if self.timer != nil{
                        self.timer?.invalidate()
                    }
                    self.navigationController?.pushViewController(VC, animated: true)
            }else if button.tag == 8 {
                self.addHapticFeedback()
                let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScheduleRequestsVC") as! ScheduleRequestsVC
                VC.forMeetingPdf = true
                VC.headerText = "Safety Meetings"
                self.navigationController?.pushViewController(VC, animated: true)
            }
               
            }
        func openScheduleRequestVC(){
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScheduleRequestsVC") as! ScheduleRequestsVC
            VC.forMeetingPdf = false
            self.navigationController?.pushViewController(VC, animated: true)
        }
        
        // MARK: - HIDE_ALL_VIEWS_EXCEPT_A_VIEW
        func HideViewsExcept(Vw:UIView){
           alphaImgVw.isHidden = false
           expenseVw.isHidden = true
//            GlobalCalendrVw.isHidden = true
//            createProjectPopUpVw.isHidden = true
            UIView.transition(with: Vw, duration: 0.4,
                              options: .transitionCrossDissolve,
                              animations: {
                Vw.isHidden = false
                          })
        }
    }
   
    
    func actionBlocks(){
        
        logoutBtn.actionBlock { [self] in
            AlertControl.shared.showAlert("Poseidon", message: "Are you sure to logout?", buttons: ["Cancel","OK"]) { value in
                if value == 1{
                    self.addHapticFeedback()
                    self.logOutApi()
                }
            }
        }
        expenseCheckBox.actionBlock { [self] in
            self.addHapticFeedback()
            if isCheckedForExpense{
                isCheckedForExpense = false
                expenseCheckBox.image = UIImage(named: "uncheckB")
            }
            else{
                isCheckedForExpense = true
                expenseCheckBox.image = UIImage(named: "checkB")
            }
        }
        
        lbl_Clock.actionBlock {
            self.openClockInVC()
            self.addHapticFeedback()
            print("clockInOutVw Tapped")
        }
        circllarSlider.actionBlock { [self] in
           isOpenCameraForExpense = false
            if SingleTon.shared.isPunchedIn{
                HideViewsExcept(Vw: injuryPopUp)
              //  pinchday.text = "End"
            }
            else{
                openCamera()
//                if isOpenCameraForExpense == false {
//                    pinchday.text = "Start"
//                }else{
//                    print ("not open camer")
//                }
            }
        }
        
        vwFirst.actionBlock {
            print("Work Order Tapped")
          //  openWorkOrder()
            self.addHapticFeedback()
            self.openWorkOrderHome()
        }
        vwsecond.actionBlock {
            print("expenseView Tapped")
            self.addHapticFeedback()
            self.expenseCheckBox.image = UIImage(named: "uncheckB")
            self.isOpenCameraForExpense = true
            self.openCamera()
        }
        vwthree.actionBlock {
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VacationsVC") as! VacationsVC
            self.navigationController?.pushViewController(VC, animated: true)
        }
        vwFour.actionBlock {
            print("holidaysVw Tapped")
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScheduleVC") as! ScheduleVC
            self.navigationController?.pushViewController(VC, animated: true)
        }
        vwFive.actionBlock {
            self.addHapticFeedback()
            self.openScheduleRequestVC()
        }
        vwsix.actionBlock {
            self.addHapticFeedback()
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateProjectVC") as! CreateProjectVC
            self.navigationController?.pushViewController(VC, animated: true)
        }
        vwseven.actionBlock {
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubjectDiscussVC") as! SubjectDiscussVC
            self.navigationController?.pushViewController(VC, animated: true)
        }
        vwEight.actionBlock {
            self.addHapticFeedback()
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE" // OR "dd-MM-yyyy"
            let currentDateString: String = dateFormatter.string(from: date)
            print("Current date is \(currentDateString)")
            print("Current date is \(currentDateString)")
                let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FSCalendarVC") as! FSCalendarVC
            // VC.isTimesheetAdded = isTimesheetAdded
            self.navigationController?.pushViewController(VC, animated: true)
        }
        vwNine.actionBlock {
            self.addHapticFeedback()
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScheduleRequestsVC") as! ScheduleRequestsVC
            VC.forMeetingPdf = true
            VC.headerText = "Safety Meetings"
            self.navigationController?.pushViewController(VC, animated: true)
        }
        notification_CenterVw.actionBlock {
            print("lkgbnfkgjdfgn")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllRequestsVC") as! AllRequestsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - EXECUTE_LOGOUT_API
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
    func executeLogin() {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
        UIApplication.shared.currentWindow?.rootViewController = loginVC
        UIApplication.shared.currentWindow?.makeKeyAndVisible()
    }
    
    @IBAction func submitInjuryBtnAction(_ sender: UIButton) {

        if injuryTxtVw.text.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Kindly explain the injury")
        }
        else{
            self.PunchDayAPI()
        }
    }
    
    // MARK: - GET_LEAVES_API
    func GetLeavesAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.LeavesUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : LeavesModel?) in
            let leavesData = success!.data
            leavesArray.removeAll()
            leavesArray = leavesData.vacationsLeaves
//            calendr.reloadData()
//            HideViewsExcept(Vw: GlobalCalendrVw)
//            crossCalndr.isHidden = true
//            calndrCancelSubmitVw.isHidden = false
//            calendrReasonVw.isHidden = true
//            isOpenCalendarForVacation = true
        }
    }
    func openWorkOrderHome(){
    //  let VC = UIStoryboard(name: "WorkOrde rView", bundle: nil).instantiateViewController(withIdentifier: "WorkOrderView")
        let VC = UIStoryboard(name: "WorkOrderView", bundle: nil).instantiateViewController(withIdentifier: "EmergencyWorkOrderVC")
        if self.timer != nil{
            self.timer?.invalidate()
        }
        self.navigationController?.pushViewController(VC, animated: true)
    //    self.pushOnly(controllerId: "EmergencyWorkOrderVC", animation: true)
    }
    func openClockInVC(){
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ClockVC") as! ClockVC
        if self.timer != nil{
            self.timer?.invalidate()
        }
        self.navigationController?.pushViewController(VC, animated: true)
    }
    func openPoseidon(){
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home_VC")
        if self.timer != nil{
            self.timer?.invalidate()
        }
        self.navigationController?.pushViewController(VC, animated: true)
    }
    func openScheduleRequestVC(){
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScheduleRequestsVC") as! ScheduleRequestsVC
        VC.forMeetingPdf = false
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    @IBAction func switchChangescreen(_ sender: UISwitch) {
      
      self.addHapticFeedback()
        if sender.isOn {
              let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalanderHomeVC") as! CalanderHomeVC
             vc.namedata = namedata
            vc.profileImg = profileImg
              self.navigationController?.pushViewController(vc, animated: true)
            self.addHapticFeedback()
          } else {
              
              let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalanderHomeVC") as! CalanderHomeVC
              vc.namedata = namedata
              self.navigationController?.pushViewController(vc, animated: true)
            self.addHapticFeedback()
          }
    }
    

    
    @IBAction func expenseSubmitBtnAction(_ sender: UIButton) {
        if expenseTitleTxtFld.text!.isEmpty || expensePriceTxtFld.text!.isEmpty || expenseCategoryTxtFld.text!.isEmpty || expenseProjectTxtFld.text!.isEmpty {
            showOnlyAlert("Poseidon", message: "Kindly fill all fields.")
        }
        else{
           AddExpensesAPI()
        }
    }
    // MARK: - ADD_EXEPENSES_API
    func AddExpensesAPI(){
        
        var check = 0
        if isCheckedForExpense{
            check = 1
        }
        else{
            check = 0
        }
        
        
        
        let params = ["sessionToken" : SingleTon.shared.userToken,"title" : expenseTitleTxtFld.text!,"category" : expenseCattId,"price" : expensePriceTxtFld.text!,"image" : SingleTon.shared.punchImage, "reimbursement" : check.description, "projectId" : allProjectsIdArray[expenseProjectTxtFld.selectedIndex!]] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.AddExpensesUrl, method: .post, parameters:  params) { [self] (success : AddExpenseModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            HideViews()
        }
    }
    @IBAction func cancelBtnExpenseAction(_ sender: UIButton) {
        expenseTitleTxtFld.text = nil
        expenseCategoryTxtFld.text = nil
        expensePriceTxtFld.text = nil
        expenseProjectTxtFld.text = nil
        isCheckedForExpense = false
        HideViews()
    }
    
    @IBAction func AcceptRejectScheduleAction(_ sender: UIButton) {
        AcceptRejectScheduleAPI(status: sender.tag)
    }
    func AcceptRejectScheduleAPI(status : Int){
        let params = ["sessionToken" : SingleTon.shared.userToken,"meetingId" : SingleTon.shared.scheduleData["mettingId"].debugDescription ,"status" : status.description] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.AcceptRejectScheduleUrl, method: .post, parameters: params) { [self] (success : AcceptRejectScheduleModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            HideViews()
        }
    }
    func HideViews(){
        alphaImgVw.isHidden = true
        expenseVw.isHidden = true
        injuryPopUp.isHidden = true
        StartDate = nil
        EndDate = nil
        applyLeavesArray.removeAll()
       
        expenseTitleTxtFld.text = nil
        expenseCategoryTxtFld.text = nil
        
        
        expensePriceTxtFld.text = nil
        expensePriceTxtFld.text = nil
      
      //  calendr.reloadData()
    }
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        if sender.isOn {
         //   super_VW.backgroundColor = ThemeColor.darkThemeViewBGColor
            pinchday.textColor = ThemeColor.darkThemeTextColor
            img_VacArrow.tintColor = ThemeColor.darkThemeImageTintColor
            vwtop.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwFirst.backgroundColor = ThemeColor.darkThemeViewBGColor
        punchTimerLbl.backgroundColor = ThemeColor.darkThemeViewBGColor
        vw_AppliedLeaves.backgroundColor = ThemeColor.darkThemeViewBGColor
        vw_NoProject.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwimgNine.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwimgEight.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwimgSeven.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwimgSix.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwimgFive.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwimgFour.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwimgThree.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwimgTwo.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwimgone.backgroundColor = ThemeColor.darkThemeViewBGColor
        darkVW.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwFirst.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwsecond.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwthree.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwFour.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwFive.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwsix.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwseven.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwEight.backgroundColor = ThemeColor.darkThemeViewBGColor
        vwNine.backgroundColor = ThemeColor.darkThemeViewBGColor
            notification_Vw.backgroundColor = ThemeColor.darkThemeViewBGColor
            notification_CenterVw.backgroundColor = ThemeColor.darkThemeViewBGColor
            schedule_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
       

            timer_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
            dark_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
            schedulereqTop_vw.backgroundColor = ThemeColor.darkThemeViewBGColor
            vacation_Topvw.backgroundColor = ThemeColor.darkThemeViewBGColor
            Exp_topVw.backgroundColor = ThemeColor.darkThemeViewBGColor
            work_orderTopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
            timeSheet_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
            safety_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
            timer_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
            empty_Vw.backgroundColor = ThemeColor.darkThemeViewBGColor
            createproject_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
            askadmin_TopVw.backgroundColor = ThemeColor.darkThemeViewBGColor
            empty_CenterVw.backgroundColor = ThemeColor.darkThemeViewBGColor
            back_Vw.backgroundColor = ThemeColor.darkThemeViewBGColor
            
            lbl_Notification.textColor = ThemeColor.darkThemeTextColor
            img_TopVw.backgroundColor = ThemeColor.darkThemeTextColor
            noOfProjectsLbl.textColor = ThemeColor.darkThemeTextColor
            lbl_Expense.textColor = ThemeColor.darkThemeTextColor
            lbl_WorkOrder.textColor = ThemeColor.darkThemeTextColor
            lbl_AppliedLeaves.textColor = ThemeColor.darkThemeTextColor
            aplliedLeavesLbl.textColor = ThemeColor.darkThemeTextColor
            lbl_NoProject.textColor = ThemeColor.darkThemeTextColor
            lbl_ScheduleReq.textColor = ThemeColor.darkThemeTextColor
            lbl_Schedule.textColor = ThemeColor.darkThemeTextColor
            lbl_Vacations.textColor = ThemeColor.darkThemeTextColor
            lbl_AskAdmin.textColor = ThemeColor.darkThemeTextColor
         //   lbl_Welcome.textColor = ThemeColor.lightThemeTextColor
            lbl_Meeting.textColor = ThemeColor.darkThemeTextColor
            lbl_TimeSheet.textColor = ThemeColor.darkThemeTextColor
         //   lbl_TitleName.textColor = ThemeColor.lightThemeTextColor
            lbl_CreateProject.textColor = ThemeColor.darkThemeTextColor
            lbl_Clock.textColor = ThemeColor.darkThemeTextColor
            lbl_DarkMode.textColor = ThemeColor.darkThemeTextColor
            noOfProjectsLbl.textColor = ThemeColor.darkThemeTextColor
           // btn_Back.backgroundColor = ThemeColor.darkThemeTextColor
            
            img_vwwork.tintColor = ThemeColor.darkThemeImageTintColor
            img_vwExp.tintColor = ThemeColor.darkThemeImageTintColor
            img_vwVacation.tintColor = ThemeColor.darkThemeImageTintColor
            img_vwSchedule.tintColor = ThemeColor.darkThemeImageTintColor
            img_vwScheReq.tintColor = ThemeColor.darkThemeImageTintColor
            img_vwCreatePro.tintColor = ThemeColor.darkThemeImageTintColor
            img_vwAskto.tintColor = ThemeColor.darkThemeImageTintColor
            img_vwTimesheet.tintColor = ThemeColor.darkThemeImageTintColor
            img_vwSafety.tintColor = ThemeColor.darkThemeImageTintColor
            img_vwNoti.tintColor = ThemeColor.darkThemeImageTintColor
            punchTimerLbl.textColor = ThemeColor.darkThemeTextColor
            
            logoutBtn.tintColor = .white
        bgImgVw.image = UIImage(named: "Dashboard2")
            switch_Top.onTintColor = .green
        } else {
            logoutBtn.tintColor = ThemeColor.lightThemeImageTintColor
            pinchday.textColor = ThemeColor.lightThemeTextColor
            img_VacArrow.tintColor = ThemeColor.lightThemeImageTintColor
            img_vwwork.tintColor = ThemeColor.lightThemeImageTintColor
            img_vwExp.tintColor = ThemeColor.lightThemeImageTintColor
            img_vwVacation.tintColor = ThemeColor.lightThemeImageTintColor
            img_vwSchedule.tintColor = ThemeColor.lightThemeImageTintColor
            img_vwScheReq.tintColor = ThemeColor.lightThemeImageTintColor
            img_vwCreatePro.tintColor = ThemeColor.lightThemeImageTintColor
            img_vwAskto.tintColor = ThemeColor.lightThemeImageTintColor
            img_vwTimesheet.tintColor = ThemeColor.lightThemeImageTintColor
            img_vwSafety.tintColor = ThemeColor.lightThemeImageTintColor
            img_vwNoti.tintColor = ThemeColor.lightThemeImageTintColor
          //  super_VW.backgroundColor = ThemeColor.lightThemeViewBGColor
            switch_Top.onTintColor = .white
            bgImgVw.image = UIImage(named: "ChangeDashboard")
            notification_Vw.backgroundColor = ThemeColor.lightThemeViewBGColor
            notification_CenterVw.backgroundColor = ThemeColor.lightThemeViewBGColorvw
            back_Vw.backgroundColor = ThemeColor.lightThemeViewBGColor
            empty_CenterVw.backgroundColor = ThemeColor.lightThemeViewBGColor
            schedule_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
            vwtop.backgroundColor = ThemeColor.lightThemeViewBGColor
        vwFirst.backgroundColor = ThemeColor.lightThemeViewBGColor
      //  punchTimerLbl.backgroundColor = ThemeColor.lightThemeViewBGColor
            punchTimerLbl.textColor = ThemeColor.lightThemeTextColor
        vw_AppliedLeaves.backgroundColor = ThemeColor.lightThemeViewBGColor
        vw_NoProject.backgroundColor = ThemeColor.lightThemeViewBGColor
        vwimgNine.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
        vwimgEight.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
        vwimgSeven.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
        vwimgSix.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
        vwimgFive.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
        vwimgFour.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
        vwimgThree.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
        vwimgTwo.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
        vwimgone.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
        darkVW.backgroundColor = ThemeColor.lightThemeViewBGColor
            
            noOfProjectsLbl.textColor = ThemeColor.lightThemeTextColor
        vwFirst.backgroundColor = ThemeColor.lightThemeViewBGColorvw
        vwsecond.backgroundColor = ThemeColor.lightThemeViewBGColorvw
        vwthree.backgroundColor = ThemeColor.lightThemeViewBGColorvw
        vwFour.backgroundColor = ThemeColor.lightThemeViewBGColorvw
        vwFive.backgroundColor = ThemeColor.lightThemeViewBGColorvw
        vwsix.backgroundColor = ThemeColor.lightThemeViewBGColorvw
        vwseven.backgroundColor = ThemeColor.lightThemeViewBGColorvw
        vwEight.backgroundColor = ThemeColor.lightThemeViewBGColorvw
        vwNine.backgroundColor = ThemeColor.lightThemeViewBGColorvw
            
            timer_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
            dark_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
            schedulereqTop_vw.backgroundColor = ThemeColor.lightThemeViewBGColor
            vacation_Topvw.backgroundColor = ThemeColor.lightThemeViewBGColor
            Exp_topVw.backgroundColor = ThemeColor.lightThemeViewBGColor
            work_orderTopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
            timeSheet_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
            safety_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
            timer_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
            empty_Vw.backgroundColor = ThemeColor.lightThemeViewBGColor
            createproject_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
            askadmin_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColor
            
            
            lbl_Notification.textColor = ThemeColor.lightThemeTextColor
            noOfProjectsLbl.textColor = ThemeColor.lightThemeTextColor
            lbl_Expense.textColor = ThemeColor.lightThemeTextColor
            lbl_WorkOrder.textColor = ThemeColor.lightThemeTextColor
            lbl_AppliedLeaves.textColor = ThemeColor.lightThemeTextColor
            aplliedLeavesLbl.textColor = ThemeColor.lightThemeTextColor
            lbl_NoProject.textColor = ThemeColor.lightThemeTextColor
            lbl_ScheduleReq.textColor = ThemeColor.lightThemeTextColor
            lbl_Schedule.textColor = ThemeColor.lightThemeTextColor
            lbl_Vacations.textColor = ThemeColor.lightThemeTextColor
            lbl_AskAdmin.textColor = ThemeColor.lightThemeTextColor
            lbl_Welcome.textColor = ThemeColor.darkThemeTextColor
            lbl_CreateProject.textColor = ThemeColor.lightThemeTextColor
            lbl_Meeting.textColor = ThemeColor.lightThemeTextColor
            lbl_Meeting.textColor = ThemeColor.lightThemeTextColor
            lbl_TimeSheet.textColor = ThemeColor.lightThemeTextColor
            lbl_TitleName.textColor = ThemeColor.darkThemeTextColor
            
            lbl_DarkMode.textColor = ThemeColor.lightThemeTextColor
            lbl_Clock.textColor = ThemeColor.lightThemeViewBGColorClock
        //    btn_Back.backgroundColor = ThemeColor.lightThemeTextColor
            btn_ScheduleArrow.setBackgroundImage(UIImage(named: "arrowWhite"), for: .normal)
            img_TopVw.backgroundColor = ThemeColor.lightThemeViewBGColorIMGVW
          
           
        }
        
        
//        let themeColor = sender.isOn ? ThemeColor.darkThemeViewBGColor : ThemeColor.lightThemeViewBGColor
//           
//           let viewsToChangeColor: [UIView] = [
//               vwtop, vwFirst, punchTimerLbl, vw_AppliedLeaves,
//               vw_NoProject, vwimgNine, vwimgEight, vwimgSeven,
//               vwimgSix, vwimgFive, vwimgFour, vwimgThree,
//               vwimgTwo, vwimgone, darkVW, vwsecond,
//               vwthree, vwFour, vwFive, vwsix,
//               vwseven, vwEight, vwNine
//           ]
//           
//           for view in viewsToChangeColor {
//               view.backgroundColor = themeColor
//           }
//           
//           let tintedViews: [UIView] = [
//               vwtop, vwFirst, punchTimerLbl, vwimgFive,
//               vwimgFour, vwimgThree, vwimgTwo, vwimgone,
//               darkVW
//           ]
//           
//           for view in tintedViews {
//               view.tintColor = themeColor
//           }
    }

    func applyStyling(to view: UIView) {
           
           view.layer.cornerRadius = 12
           //view.backgroundColor = UIColor.white
           view.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
           view.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
           view.layer.shadowOpacity = 1.5
           view.layer.shadowRadius = 4
        vwtop.roundCorners(corners: [.topLeft, .topRight], radius: 30, newWidth: self.view.frame.width)
       }
    
    func HideViewsExcept(Vw:UIView){
        alphaImgVw.isHidden = false
       expenseVw.isHidden = true
       // GlobalCalendrVw.isHidden = true
        //createProjectPopUpVw.isHidden = true
        UIView.transition(with: Vw, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            Vw.isHidden = false
                      })
    }

}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat, newWidth: CGFloat) {
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: newWidth, height: bounds.height), byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        
        frame.size.width = newWidth
    }
}

extension HomeViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
            if isOpenCameraForExpense == false{
                var currentLocation: CLLocation!
                if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                    CLLocationManager.authorizationStatus() ==  .authorizedAlways
                {
                    currentLocation = locManager?.location
                    lat = currentLocation.coordinate.latitude.description
                    long = currentLocation.coordinate.longitude.description
                }
            }
            
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
               // dayPunchSwitch.setOn(SingleTon.shared.isPunchedIn, animated: true)
                return controller
            }()
            self.present(alertController, animated: true)
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            // imageViewPic.contentMode = .scaleToFill
            if imagePicker.sourceType == .camera{
                UIImageWriteToSavedPhotosAlbum(pickedImage, self, nil, nil)
                setUserPhoto(UserPhoto: pickedImage)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUserPhoto(UserPhoto : UIImage){
        let imgData = UserPhoto.jpegData(compressionQuality: 0.5)
        let base64Data = imgData?.base64EncodedString()
        SingleTon.shared.punchImage = base64Data!
        if isOpenCameraForExpense{
            DispatchQueue.main.asyncAfter(wallDeadline: .now()+1.0) {
                self.isCheckedForExpense = false
                self.HideViewsExcept(Vw: self.expenseVw)
               self.recieptImgVw.image = UserPhoto
            }
        }
        else{
           PunchDayAPI()
        }
    }
    // MARK: - PUNCH_DAY_API
    func PunchDayAPI(){
        
        if SingleTon.shared.punchImage.isEmpty{
            let img = UIImage(named: "user")
            let imgData = img!.jpegData(compressionQuality: 0.5)
            let base64Data = imgData?.base64EncodedString()
            SingleTon.shared.punchImage = base64Data!
        }
        let params = ["sessionToken" : SingleTon.shared.userToken,"lat" : lat,"long" : long,"image" :SingleTon.shared.punchImage,"injured" : ""] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.PunchDayUrl, method: .post, parameters: params) { [self] (success : PunchDayModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            if success?.message == "Can't clockout before one hour"{
                //dayPunchSwitch.setOn(true, animated: true)
                timerMethod()
                pinchday.text = "End"
                return
            }
            print("success?.data.punch", success?.data.punch)
            SingleTon.shared.isPunchedIn = ((success?.data.punch) != nil)
            SingleTon.shared.isPunchedIn = ((success?.data.punch) != nil)
           // SingleTon.shared.isPunchedIn = success!.data.punch!
           // print("success!.data.punch!--->", success!.data.punch!)
         //   dayPunchSwitch.setOn(SingleTon.shared.isPunchedIn, animated: true)
            
            if SingleTon.shared.isPunchedIn{
                timerMethod()
                pinchday.text = "End"
            }
            else{
                timer?.invalidate()
                punchTimerLbl.text = "00:00"
            circllarSlider.currentValue = 0
            }
        }
    }
    
    
    
    
}

extension HomeViewController : UITextFieldDelegate{
    // MARK: - TEXTFIELD_DELEGATES
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.expenseCategoryTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.expenseCategoryTxtFld.showList()
            return false
        }
      
        else if textField == self.expenseProjectTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.expenseProjectTxtFld.showList()
            return false
        }
        
        
       else if textField == self.injuryTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.injuryTxtFld.showList()
            return false
        }
        
        return true
    }
}
