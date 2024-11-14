//
//  DashboardVC.swift
//  Logo
//
//  Created by Mobile on 18/05/23.
//

import UIKit
import MSCircularSlider
import FSCalendar
import iOSDropDown
import SDWebImage
import CoreLocation
import PKHUD
import SevenSwitch

class DashboardVC: UIViewController,CLLocationManagerDelegate {
    
    // MARK: - OUTLETS
    @IBOutlet weak var userNmLbl: UILabel!
    @IBOutlet weak var dayPunchSwitch: UISwitch!
    @IBOutlet weak var circllarSlider: MSCircularSlider!
    @IBOutlet weak var punchTimerLbl: UILabel!
    @IBOutlet weak var noOfProjectsLbl: UILabel!
    @IBOutlet weak var aplliedLeavesLbl: UILabel!
    @IBOutlet weak var clockInOutVw: UIView!
    @IBOutlet weak var workOrderVw: UIView!
    @IBOutlet weak var inspectionVw: UIView!
    @IBOutlet weak var expenseView: UIView!
    @IBOutlet weak var holidaysVw: UIView!
    @IBOutlet weak var scheduleVw: UIView!
    @IBOutlet weak var createProjectVw: UIView!
    @IBOutlet weak var expenseVw: UIView!
    @IBOutlet weak var createProjectPopUpVw: UIView!
    @IBOutlet weak var GlobalCalendrVw: UIView!
    @IBOutlet weak var calendr: FSCalendar!
    @IBOutlet weak var alphaImgVw: UIImageView!
    @IBOutlet weak var calendrReasonVw: UIView!
    @IBOutlet weak var reasonTxtVw: UITextView!
    @IBOutlet weak var okReasonBtn: UIButton!
    @IBOutlet weak var recieptImgVw: UIImageView!
    @IBOutlet weak var expenseTitleTxtFld: UITextField!
    @IBOutlet weak var expensePriceTxtFld: UITextField!
    @IBOutlet weak var expenseCategoryTxtFld: DropDown!
    @IBOutlet weak var startdateHolidayLbl: UILabel!
    @IBOutlet weak var profileImgVw: UIImageView!
    @IBOutlet weak var logoutBtn: UIImageView!
    @IBOutlet weak var createProjectNameTxtFld: UITextField!
    @IBOutlet weak var createProjectAddressTxtFld: UITextField!
    @IBOutlet weak var createProjectCityTxtFld: UITextField!
    @IBOutlet weak var createProjectPostalTxtFld: UITextField!
    @IBOutlet weak var createProjectContractorTxtFld: UITextField!
    @IBOutlet weak var createProjectStateTxtFld: DropDown!
    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var schedulePopUpVw: UIView!
    @IBOutlet weak var scheduleTitle: UILabel!
    @IBOutlet weak var scheduleNotes: UITextView!
    @IBOutlet weak var scheduleDateandTimeLbl: UILabel!
    @IBOutlet weak var scheduleAcceptBtn: UIButton!
    @IBOutlet weak var scheduleRejectBtn: UIButton!
    @IBOutlet weak var scheduleRequestVw: UIView!
    @IBOutlet weak var expenseCheckBox: UIImageView!
    @IBOutlet weak var askToAdminVw: UIView!
    @IBOutlet weak var askToAdminPopUpVw: UIView!
    @IBOutlet weak var chatSubjectTxtFld: UITextField!
    @IBOutlet weak var chatDescriptionTxtVw: UITextView!
    @IBOutlet weak var chatSubmitBtn: UIButton!
    @IBOutlet weak var suggestedJobsVw: UIView!
    @IBOutlet weak var leaveTypeTxtFld: DropDown!
    @IBOutlet weak var expenseProjectTxtFld: DropDown!
    @IBOutlet weak var injuryPopUp: UIView!
    @IBOutlet weak var injuryTxtFld: DropDown!
    @IBOutlet weak var injuryTxtVw: UITextView!
    @IBOutlet weak var explainVw: UIView!
    @IBOutlet weak var bgImgVw: UIImageView!
    @IBOutlet weak var startDayVw: UIView!
    
    @IBOutlet weak var calndrCancelSubmitVw: UIView!
    @IBOutlet weak var crossCalndr: UIImageView!
    
    
    @IBOutlet weak var workOrderLbl: UILabel!
    @IBOutlet weak var workOrderImgVw: UIImageView!
    
    @IBOutlet weak var inspectionLbl: UILabel!
    @IBOutlet weak var inspectionImgVw: UIImageView!
    
    @IBOutlet weak var expenseLbl: UILabel!
    @IBOutlet weak var expenseImgVw: UIImageView!
    
    @IBOutlet weak var vacationLbl: UILabel!
    @IBOutlet weak var vacationImgVw: UIImageView!
    
    @IBOutlet weak var scheduleLbl: UILabel!
    @IBOutlet weak var scheduleImgVw: UIImageView!
    
    @IBOutlet weak var scheduleRequestLbl: UILabel!
    @IBOutlet weak var scheduleRequestImgVw: UIImageView!
    
    @IBOutlet weak var createProjectLbl: UILabel!
    @IBOutlet weak var createProjectImgVw: UIImageView!
    
    @IBOutlet weak var askToAdminLbl: UILabel!
    @IBOutlet weak var askToAdminImgVw: UIImageView!
    
    @IBOutlet weak var startDayLbl: UILabel!
    @IBOutlet weak var clockInOutLbl: UILabel!
    @IBOutlet weak var clockInOutArrowImgVw: UIImageView!
    
    @IBOutlet weak var NumberProjectsLbl: UILabel!
    @IBOutlet weak var appliedLbl: UILabel!
    @IBOutlet weak var welcomeBackLbl: UILabel!
    @IBOutlet weak var topLogoImgVw: UIImageView!
    @IBOutlet weak var themeSwitchVw: UIView!
    @IBOutlet weak var inspectionMainVw: UIView!
    @IBOutlet weak var appsVw: UIStackView!
    
    @IBOutlet weak var timeSheetVw: UIView!
    @IBOutlet weak var timeSheetLbl: UILabel!
    @IBOutlet weak var timeSheetImgVw: UIImageView!
    
    @IBOutlet weak var safetyMeetingsVw: UIView!
    @IBOutlet weak var safetyMeetingsLbl: UILabel!
    @IBOutlet weak var safetyMeetingsImgVw: UIImageView!
    
    @IBOutlet weak var installationVw: UIView!
    @IBOutlet weak var installationLbl: UILabel!
    @IBOutlet weak var installationImgVw: UIImageView!
    
    @IBOutlet weak var InstallationMainVw: UIStackView!
    
    
    
    // MARK: - VARIABLES
    var timeCount = 0
    var timer : Timer?
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
    var locManager : CLLocationManager?
    var applyLeavesArray : [String] = []
    var leavesArray : [String] = []
    var isCheckedForExpense = false
    var loginrequest = [Request]()
    var expenseCattId = 0
    var allProjectsArray : [String] = []
    var allProjectsIdArray : [String] = []
    var profileImg : UIImage = UIImage(named: "user")!
    var leaveTypeArray = ["Unpaid","Paid"]
    let optionArr = ["Yes","No"]
    var statesArray = ["Alabama","Alaska","Arizona","Arkansas","California","Colorado","Connecticut","Delaware","Florida","Georgia","Hawaii","Idaho","Illinois","Indiana","Iowa","Kansas","Kentucky","Louisiana","Maine","Maryland","Massachusetts","Michigan","Minnesota","Mississippi","Missouri","Montana","Nebraska","Nevada","New Hampshire","New Jersey","New Mexico","New York","North Carolina","North Dakota","Ohio","Oklahoma","Oregon","Pennsylvania","Rhode Island","South Carolina","South Dakota","Tennessee","Texas","Utah","Vermont","Virginia","Washington","West Virginia","Wisconsin","Wyoming"]
    let mySwitch = SevenSwitch()
    var isTimesheetAdded = false
    
    // MARK: - VIEW_DID_LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager?.requestAlwaysAuthorization()
        didLoadMethods()
        updateBackgroundColor()
        self.themeSwitchVw.addSubview(mySwitch)
   
        mySwitch.offLabel.text = "LIGHT"
        mySwitch.onLabel.text = "DARK"
        mySwitch.isRounded = false
        mySwitch.frame = CGRect(x: 0, y: 0, width: 70, height: 30)
        
        mySwitch.thumbTintColor = ThemeColor.lightThemeImageTintColor
      //  mySwitch.activeColor =  .lightGray
        mySwitch.onLabel.textColor = .black
        mySwitch.offLabel.textColor = .black
        mySwitch.inactiveColor =  .white
        mySwitch.onTintColor =  .white
        mySwitch.borderColor = UIColor.clear
        mySwitch.addTarget(self, action: #selector(SwtchModeAction), for: UIControl.Event.valueChanged)
        profileImgVw.alpha = 1.0
        
    }
    
    // MARK: - VIEW_WILL_APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        switch SingleTon.shared.appId{
        case "3":
            InstallationMainVw.isHidden = true
        case "4":
            InstallationMainVw.isHidden = true
            inspectionMainVw.isHidden = true
        case "7","6":
            InstallationMainVw.isHidden = false
            appsVw.isHidden = true
        default :
            print("Nothing")
            
        }
        
        switch SingleTon.shared.appId {
        case "6":
            installationVw.isHidden = false
            appsVw.isHidden = true
        case "7":
            installationVw.isHidden = false
            workOrderVw.isHidden = true
            inspectionVw.isHidden = true
        case "3":
            installationVw.isHidden = true
            workOrderVw.isHidden = false
            inspectionVw.isHidden = false
        case "4":
            installationVw.isHidden = true
            workOrderVw.isHidden = false
            inspectionVw.isHidden = true
        default:
            installationVw.isHidden = true
            workOrderVw.isHidden = false
            inspectionVw.isHidden = false
        }
        
        var currentLocation: CLLocation!
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager?.location
            lat = currentLocation.coordinate.latitude.description
            long = currentLocation.coordinate.longitude.description
        }
        dashboardDataAPI()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           super.traitCollectionDidChange(previousTraitCollection)

           // Update the background color when appearance mode changes
           updateBackgroundColor()
       }

    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
              // Dark mode is enabled
                    UIImageView.appearance().tintColor = .white
                    
                    askToAdminVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    createProjectVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    timeSheetVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    safetyMeetingsVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    installationVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    
                    
                    scheduleVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    scheduleRequestVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    holidaysVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    expenseView.backgroundColor = ThemeColor.darkThemeViewBGColor
                    inspectionVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    workOrderVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    clockInOutVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                   startDayVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                   
                    workOrderLbl.textColor = ThemeColor.darkThemeTextColor
                    inspectionLbl.textColor = ThemeColor.darkThemeTextColor
                    expenseLbl.textColor = ThemeColor.darkThemeTextColor
                    vacationLbl.textColor = ThemeColor.darkThemeTextColor
                    scheduleLbl.textColor = ThemeColor.darkThemeTextColor
                    scheduleRequestLbl.textColor = ThemeColor.darkThemeTextColor
                    createProjectLbl.textColor = ThemeColor.darkThemeTextColor
                    timeSheetLbl.textColor = ThemeColor.darkThemeTextColor
                    safetyMeetingsLbl.textColor = ThemeColor.darkThemeTextColor
                    installationLbl.textColor = ThemeColor.darkThemeTextColor
                    askToAdminLbl.textColor = ThemeColor.darkThemeTextColor
                    
                    workOrderImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    inspectionImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    expenseImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    vacationImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    scheduleImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    scheduleRequestImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    createProjectImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    timeSheetImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    safetyMeetingsImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    installationImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    askToAdminImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    
                    
                    startDayLbl.textColor = ThemeColor.darkThemeTextColor
                    clockInOutLbl.textColor = ThemeColor.darkThemeTextColor
                    NumberProjectsLbl.textColor = ThemeColor.darkThemeTextColor
                    noOfProjectsLbl.textColor = ThemeColor.darkThemeTextColor
                    appliedLbl.textColor = ThemeColor.darkThemeTextColor
                    welcomeBackLbl.textColor = ThemeColor.darkThemeTextColor
                    punchTimerLbl.textColor = ThemeColor.darkThemeTextColor
                    userNmLbl.textColor = ThemeColor.darkThemeTextColor
                    aplliedLeavesLbl.textColor = ThemeColor.darkThemeTextColor
                    
                    topLogoImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    clockInOutArrowImgVw.tintColor = ThemeColor.darkThemeImageTintColor
                    dayPunchSwitch.thumbTintColor = .white
                    bgImgVw.image = UIImage(named: "Dashboard")
                    calendr.backgroundColor = .white
                    
                    logoutBtn.tintColor = .white
                } else {
                    // Light mode is enabled

                    logoutBtn.tintColor = ThemeColor.lightThemeImageTintColor
                    leaveTypeTxtFld.attributedPlaceholder = NSAttributedString(string: "Time off type",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    injuryTxtFld.attributedPlaceholder = NSAttributedString(string: "Select",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    createProjectNameTxtFld.attributedPlaceholder = NSAttributedString(string: "Project Name",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    createProjectAddressTxtFld.attributedPlaceholder = NSAttributedString(string: "Address",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    createProjectCityTxtFld.attributedPlaceholder = NSAttributedString(string: "City",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    createProjectStateTxtFld.attributedPlaceholder = NSAttributedString(string: "State",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    createProjectPostalTxtFld.attributedPlaceholder = NSAttributedString(string: "Postal Code",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    createProjectContractorTxtFld.attributedPlaceholder = NSAttributedString(string: "Contractor Name",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    
                    expenseProjectTxtFld.attributedPlaceholder = NSAttributedString(string: "Project Name",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    expenseTitleTxtFld.attributedPlaceholder = NSAttributedString(string: "Title",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    expensePriceTxtFld.attributedPlaceholder = NSAttributedString(string: "Price",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    expenseCategoryTxtFld.attributedPlaceholder = NSAttributedString(string: "Select Category",attributes:[NSAttributedString.Key.foregroundColor: UIColor.lightGray])
                    
                    
                    GlobalCalendrVw.backgroundColor = .white
                 
                    askToAdminVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    createProjectVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    safetyMeetingsVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    installationVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    timeSheetVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    scheduleVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    scheduleRequestVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    holidaysVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    expenseView.backgroundColor = ThemeColor.lightThemeViewBGColor
                    inspectionVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    workOrderVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    clockInOutVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    startDayVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    
                    workOrderLbl.textColor = ThemeColor.lightThemeTextColor
                    inspectionLbl.textColor = ThemeColor.lightThemeTextColor
                    expenseLbl.textColor = ThemeColor.lightThemeTextColor
                    vacationLbl.textColor = ThemeColor.lightThemeTextColor
                    scheduleLbl.textColor = ThemeColor.lightThemeTextColor
                    scheduleRequestLbl.textColor = ThemeColor.lightThemeTextColor
                    createProjectLbl.textColor = ThemeColor.lightThemeTextColor
                    timeSheetLbl.textColor = ThemeColor.lightThemeTextColor
                    safetyMeetingsLbl.textColor = ThemeColor.lightThemeTextColor
                    installationLbl.textColor = ThemeColor.lightThemeTextColor
                    askToAdminLbl.textColor = ThemeColor.lightThemeTextColor
                    
                    workOrderImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    inspectionImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    expenseImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    vacationImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    scheduleImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    scheduleRequestImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    createProjectImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    timeSheetImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    safetyMeetingsImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    installationImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    askToAdminImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    
                    startDayLbl.textColor = ThemeColor.lightThemeTextColor
                    clockInOutLbl.textColor = ThemeColor.lightThemeTextColor
                    NumberProjectsLbl.textColor = ThemeColor.lightThemeTextColor
                    noOfProjectsLbl.textColor = ThemeColor.lightThemeTextColor
                    appliedLbl.textColor = ThemeColor.lightThemeTextColor
                    welcomeBackLbl.textColor = ThemeColor.lightThemeTextColor
                    punchTimerLbl.textColor = ThemeColor.lightThemeTextColor
                    userNmLbl.textColor = ThemeColor.lightThemeTextColor
                    aplliedLeavesLbl.textColor = ThemeColor.lightThemeTextColor
                    
                    topLogoImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    clockInOutArrowImgVw.tintColor = ThemeColor.lightThemeImageTintColor
                    dayPunchSwitch.thumbTintColor = .black
                    dayPunchSwitch.tintColor = ThemeColor.lightThemeViewBGColor
                    bgImgVw.image = UIImage(named: "DashboardLight")
                   
                }
            } else {
                // Fallback for earlier versions
           //     UIView.appearance().backgroundColor = .white
            }

            // Refresh the view hierarchy to apply the new background color
            view.setNeedsDisplay()
        }
    

    
    // MARK: - CANCEL_EXPENSE_BUTTON_ACTION
    @IBAction func cancelBtnExpenseAction(_ sender: UIButton) {
        expenseTitleTxtFld.text = nil
        expenseCategoryTxtFld.text = nil
        expensePriceTxtFld.text = nil
        expenseProjectTxtFld.text = nil
        isCheckedForExpense = false
        HideViews()
    }
    
    // MARK: - CANCEL_HOLIDAYS_BUTTON_ACTION
    @IBAction func cancelHolidayBtnAction(_ sender: UIButton) {
        cancelCalndrAction()
    }
    
    
    func cancelCalndrAction(){
        reasonTxtVw.text = nil
        leaveTypeTxtFld.text = nil
        leavesArray.removeAll()
        startdateHolidayLbl.text = "Select Time Off Dates"
        StartDate = nil
        EndDate = nil
        HideViews()
        if (calendr.selectedDate != nil){
            calendr.deselect(calendr.selectedDate!)
        }
        calendrReasonVw.isHidden = true
        okReasonBtn.isEnabled = false
        calendr.reloadData()
    }
    
    
    
    // MARK: - SUBMIT_HOLIDAYS_BUTTON_ACTION
    @IBAction func SubmitLeavesBtnAction(_ sender: UIButton) {
        if reasonTxtVw.text.isEmpty{
            showOnlyAlert("Poseidon", message: "Kindly enter a valid reason for leaves.")
        }
        else if leaveTypeTxtFld.text!.isEmpty{
            showOnlyAlert("Poseidon", message: "Kindly select a valid Time Off Type for leaves.")
        }
        else{
            ApplyLeavesAPI()
        }
    }
    
    @IBAction func chatSubmitBtnAction(_ sender: UIButton) {
        if chatDescriptionTxtVw.text.isEmpty || chatSubjectTxtFld.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Kindly enter a valid reason for leaves.")
        }
        else{
            AskToAdminAPI()
        }
        
        
    }
    
    @IBAction func submitInjuryBtnAction(_ sender: UIButton) {

        if injuryTxtVw.text.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Kindly explain the injury")
        }
        else{
            self.PunchDayAPI()
        }
    }
    
    @IBAction func saveBtnAction(_ sender: UIButton) {
        if createProjectNameTxtFld.text!.isEmpty || createProjectAddressTxtFld.text!.isEmpty || createProjectCityTxtFld.text!.isEmpty || createProjectStateTxtFld.text!.isEmpty || createProjectPostalTxtFld.text!.isEmpty || createProjectContractorTxtFld.text!.isEmpty {
            showOnlyAlert("Poseidon", message: "Kindly fill all fields.")
        }
        else{
            CreateProjectAPI()
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
    
    
    @IBAction func AcceptRejectScheduleAction(_ sender: UIButton) {
        AcceptRejectScheduleAPI(status: sender.tag)
    }
    
    
    
    
    // MARK: - DAY_PUNCH_SWITCH_ACTION
    @IBAction func swtchAction(_ sender: UISwitch) {
        isOpenCameraForExpense = false
        if SingleTon.shared.isPunchedIn{
            HideViewsExcept(Vw: injuryPopUp)
        }
        else{
            openCamera()
        }
    }
    
    //Vish
    // MARK: - CUSTOM_FUNCTIONS
    
    // MARK: - ACTION_BLOCKS
    func actionBlocks(){
        
        crossCalndr.actionBlock {
            self.cancelCalndrAction()
        }
        
        workOrderVw.actionBlock { [self] in
            print("Work Order Tapped")
          //  openWorkOrder()
            self.addHapticFeedback()
            openWorkOrderHome()
        }
        
        inspectionVw.actionBlock { [self] in
            print("inspectionVw Tapped")
            self.addHapticFeedback()
            openPoseidon()
        }
        
        expenseView.actionBlock { [self] in
            print("expenseView Tapped")
            self.addHapticFeedback()
            expenseCheckBox.image = UIImage(named: "uncheckB")
            isOpenCameraForExpense = true
            openCamera()
        }
        
        holidaysVw.actionBlock { [self] in
            print("holidaysVw Tapped")
            self.addHapticFeedback()
            GetLeavesAPI()
        }
        
        clockInOutVw.actionBlock { [self] in
            openClockInVC()
            self.addHapticFeedback()
            print("clockInOutVw Tapped")
        }
        
        scheduleVw.actionBlock { [self] in
            self.addHapticFeedback()
            GetScheduleAPI()
        }
        
        alphaImgVw.actionBlock { [self] in
            self.addHapticFeedback()
            HideViews()
        }
        
        logoutBtn.actionBlock { [self] in
            AlertControl.shared.showAlert("Poseidon", message: "Are you sure to logout?", buttons: ["Cancel","OK"]) { value in
                if value == 1{
                    self.addHapticFeedback()
                    self.logOutApi()
                }
            }
        }
        
        createProjectVw.actionBlock { [self] in
            self.addHapticFeedback()
            HideViewsExcept(Vw: createProjectPopUpVw)
        }
        
        safetyMeetingsVw.actionBlock {
            self.addHapticFeedback()
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScheduleRequestsVC") as! ScheduleRequestsVC
            VC.forMeetingPdf = true
            VC.headerText = "Safety Meetings"
            self.navigationController?.pushViewController(VC, animated: true)
        }
        installationVw.actionBlock {
            self.addHapticFeedback()
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstallationHomeVC") as! InstallationHomeVC
            self.navigationController?.pushViewController(VC, animated: true)
        }
        
        timeSheetVw.actionBlock { [self] in
            self.addHapticFeedback()
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE" // OR "dd-MM-yyyy"
            let currentDateString: String = dateFormatter.string(from: date)
            print("Current date is \(currentDateString)")
            print("Current date is \(currentDateString)")
                let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TimeSheetVC") as! TimeSheetVC
             VC.isTimesheetAdded = isTimesheetAdded
                if self.timer != nil{
                    self.timer?.invalidate()
                }
                self.navigationController?.pushViewController(VC, animated: true)
            }
        
        
        scheduleRequestVw.actionBlock { [self] in
            
            self.addHapticFeedback()
            openScheduleRequestVC()
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
        
        askToAdminVw.actionBlock { [self] in
        //    HideViewsExcept(Vw: askToAdminPopUpVw)
            self.addHapticFeedback()
//            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubjectChatVC") as! SubjectChatVC
//            self.navigationController?.pushViewController(VC, animated: true)
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubjectDiscussVC") as! SubjectDiscussVC
            self.navigationController?.pushViewController(VC, animated: true)
            
        }
        
    }
    
    // MARK: - LOCATION_MANAGER_PERMISSIONS_AND_REQUIREMENTS
    func LocationDidloadRequirements(){
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager!.requestWhenInUseAuthorization()
        locManager?.requestAlwaysAuthorization()
    }
    
    @objc func openForNotification(){
        openPoseidon()
    }
    
    @objc func SwtchModeAction(){
        if ThemeManager.currentTheme == .light {
                   ThemeManager.applyTheme(.dark)
               } else {
                   ThemeManager.applyTheme(.light)
               }

    }
    
    @objc func openForSchedule(){
        scheduleTitle.text = SingleTon.shared.scheduleData["type"] as! String
        scheduleNotes.text = SingleTon.shared.scheduleData["notes"] as! String
        scheduleDateandTimeLbl.text = "(\(SingleTon.shared.scheduleData["date"] as! String), \(SingleTon.shared.scheduleData["time"] as! String))"
        HideViewsExcept(Vw: schedulePopUpVw)
    }
    
    // MARK: - HIDE_NAVIGATION_BAR
    func hideNavigationBar(){
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - SET_UI
    func SetUI(){
        okReasonBtn.isEnabled = false
        startdateHolidayLbl.text = "Select Time Off Dates"
        punchTimerLbl.text = "00:00"
        
        circllarSlider.handleType = .smallCircle
        circllarSlider.handleColor = .systemGreen
        circllarSlider.filledColor = .systemGreen
        circllarSlider.currentValue = Double(timeCount)
        hideNavigationBar()
        GlobalCalendrVw.clipsToBounds = true
        GlobalCalendrVw.layer.cornerRadius = 10.0
        expenseVw.clipsToBounds = true
        expenseVw.layer.cornerRadius = 10.0
        recieptImgVw.clipsToBounds = true
        recieptImgVw.layer.cornerRadius = 50.0
        profileImgVw.clipsToBounds = true
        profileImgVw.layer.cornerRadius = 15.0
        profileImgVw.contentMode = .scaleToFill
        createProjectPopUpVw.clipsToBounds = true
        createProjectPopUpVw.layer.cornerRadius = 10.0
        injuryPopUp.clipsToBounds = true
        injuryPopUp.layer.cornerRadius = 10.0
        saveBtn.clipsToBounds = true
        saveBtn.layer.cornerRadius = 10.0
        scheduleAcceptBtn.clipsToBounds = true
        scheduleAcceptBtn.layer.cornerRadius = 10.0
        schedulePopUpVw.clipsToBounds = true
        schedulePopUpVw.layer.cornerRadius = 10.0
        reasonTxtVw.clipsToBounds = true
        reasonTxtVw.layer.cornerRadius = 5.0
        chatSubmitBtn.clipsToBounds = true
        chatSubmitBtn.layer.cornerRadius = 10.0
        askToAdminVw.clipsToBounds = true
        askToAdminVw.layer.cornerRadius = 10.0
        chatDescriptionTxtVw.clipsToBounds = true
        chatDescriptionTxtVw.layer.cornerRadius = 5.0
        chatDescriptionTxtVw.borderWidth = 0.5
        chatDescriptionTxtVw.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    // MARK: - DELEGATES_SELF
    func delegates(){
        calendr.delegate = self
        calendr.dataSource = self
        expenseCategoryTxtFld.delegate = self
        createProjectStateTxtFld.delegate = self
        expenseProjectTxtFld.delegate = self
        leaveTypeTxtFld.delegate = self
    }
    
    // MARK: - VIEW_DID_LOAD_CALLING_METHODS
    func didLoadMethods(){
        NotificationCenter.default.addObserver(self, selector: #selector(openForSchedule), name: Notification.Name("Schedule"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(openForNotification), name: Notification.Name("Accept"), object: nil)
        LocationDidloadRequirements()
        actionBlocks()
        SetUI()
        delegates()
        HideViews()
        expenseCategoryTxtFld.didSelect { selectedText, index, id in
            print("Selected Text \(selectedText)")
            self.expenseCattId = Int(self.expenseCategoryArr[index].id)!
        }
        createProjectStateTxtFld.optionArray = statesArray
        createProjectStateTxtFld.didSelect { selectedText, index, id in
            print("Selected Text \(selectedText)")
        }
        
        leaveTypeTxtFld.optionArray = leaveTypeArray
        leaveTypeTxtFld.didSelect { selectedText, index, id in
            print("Selected Text \(selectedText)")
        }
        
        expenseProjectTxtFld.didSelect { selectedText, index, id in
            print("Selected Text \(selectedText)")
        }
        
        injuryTxtFld.optionArray = optionArr
        injuryTxtFld.didSelect { selectedText, index, id in
            if selectedText == "No"{
                self.PunchDayAPI()
                self.injuryPopUp.isHidden = true
                self.alphaImgVw.isHidden = true
            }
            else if selectedText == "Yes"{
                self.explainVw.isHidden = false
            }
        }
    }
    
    // MARK: - CLOCK_TIMER_METHOD
    func timerMethod(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            print("Timer fired!")
            self.timeCount += 1
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
    
    // MARK: - HIDE_ALL_VIEWS_AND_RESET_FUNCTIONALITIES
    func HideViews(){
        alphaImgVw.isHidden = true
        expenseVw.isHidden = true
        askToAdminPopUpVw.isHidden = true
        schedulePopUpVw.isHidden = true
        createProjectPopUpVw.isHidden = true
        GlobalCalendrVw.isHidden = true
        injuryPopUp.isHidden = true
        StartDate = nil
        EndDate = nil
        applyLeavesArray.removeAll()
        reasonTxtVw.text = nil
        startdateHolidayLbl.text = "Select Time Off Dates"
        expenseTitleTxtFld.text = nil
        expenseCategoryTxtFld.text = nil
        createProjectNameTxtFld.text = nil
        createProjectAddressTxtFld.text = nil
        createProjectCityTxtFld.text = nil
        createProjectStateTxtFld.text = nil
        createProjectPostalTxtFld.text = nil
        createProjectContractorTxtFld.text = nil
        leaveTypeTxtFld.text = nil
        expensePriceTxtFld.text = nil
        expensePriceTxtFld.text = nil
        chatSubjectTxtFld.text = nil
        chatDescriptionTxtVw.text = nil
        dayPunchSwitch.setOn(SingleTon.shared.isPunchedIn, animated: false)
        calendr.reloadData()
    }
    
    // MARK: - HIDE_ALL_VIEWS_EXCEPT_A_VIEW
    func HideViewsExcept(Vw:UIView){
        alphaImgVw.isHidden = false
        expenseVw.isHidden = true
        GlobalCalendrVw.isHidden = true
        createProjectPopUpVw.isHidden = true
        UIView.transition(with: Vw, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            Vw.isHidden = false
                      })
    }
    
    // MARK: - OPEN_POSEIDON_WORKORDER_AND_CLOCKIN
    func openPoseidon(){
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home_VC")
        if self.timer != nil{
            self.timer?.invalidate()
        }
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func openWorkOrder(){
        let VC = UIStoryboard(name: "WorkOrderView", bundle: nil).instantiateViewController(withIdentifier: "WorkOrderView")
        if self.timer != nil{
            self.timer?.invalidate()
        }
        self.navigationController?.pushViewController(VC, animated: true)
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
    
    func openScheduleRequestVC(){
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScheduleRequestsVC") as! ScheduleRequestsVC
        VC.forMeetingPdf = false
        self.navigationController?.pushViewController(VC, animated: true)
    }
  
}

// MARK: - DASHBOARDVC_EXTENSIONS

// MARK: - API_SECTION
extension DashboardVC{
    
    // MARK: - DASHBOARD_DATA_API
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
            userNmLbl.text = dashboardData.userName
            noOfProjectsLbl.text = dashboardData.projectCount.description
            aplliedLeavesLbl.text = dashboardData.approvedLeaveCount.description
            isTimesheetAdded = dashboardData.isTimesheetAdded
            punchInListAPI(type : "0")
            if dashboardData.punchData == 0{
                dayPunchSwitch.setOn(false, animated: false)
                punchTimerLbl.text = "00:00"
                timeCount = 0
                if timer != nil{
                    timer?.invalidate()
                }
            }
            else{
                dayPunchSwitch.setOn(true, animated: true)
                timeCount = dashboardData.punchData
                timerMethod()
            }
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
                dayPunchSwitch.setOn(true, animated: true)
                timerMethod()
                
                return
            }
            SingleTon.shared.isPunchedIn = ((success?.data.punch) != nil)
            SingleTon.shared.isPunchedIn = success!.data.punch!
            dayPunchSwitch.setOn(SingleTon.shared.isPunchedIn, animated: true)
            if SingleTon.shared.isPunchedIn{
                timerMethod()
            }
            else{
                timer?.invalidate()
                punchTimerLbl.text = "00:00"
                circllarSlider.currentValue = 0
            }
        }
    }
    
    // MARK: - APPLY_LEAVES_API
    func ApplyLeavesAPI(){
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: applyLeavesArray, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                let params = ["sessionToken" : SingleTon.shared.userToken,"leaveDates" : jsonString,"reason" : reasonTxtVw.text!, "type":leaveTypeTxtFld.selectedIndex?.description] as [String : Any]
                ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ApplyLeavesUrl, method: .post, parameters: params) { [self] (success : ApplyLeavesModel?) in
                    AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
                    HideViews()
                    if (calendr.selectedDate != nil){
                        calendr.deselect(calendr.selectedDate!)
                    }
                    calendr.reloadData()
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    // MARK: - GET_LEAVES_API
    func GetLeavesAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.LeavesUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : LeavesModel?) in
            let leavesData = success!.data
            leavesArray.removeAll()
            leavesArray = leavesData.vacationsLeaves
            calendr.reloadData()
            HideViewsExcept(Vw: GlobalCalendrVw)
            crossCalndr.isHidden = true
            calndrCancelSubmitVw.isHidden = false
            calendrReasonVw.isHidden = true
            isOpenCalendarForVacation = true
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
    
    // MARK: - Execute_Login
    func executeLogin() {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
        UIApplication.shared.currentWindow?.rootViewController = loginVC
        UIApplication.shared.currentWindow?.makeKeyAndVisible()
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
    
    // MARK: - ACCEPT_REJECT_SCHEDULE_API
    func AcceptRejectScheduleAPI(status : Int){
        let params = ["sessionToken" : SingleTon.shared.userToken,"meetingId" : SingleTon.shared.scheduleData["mettingId"].debugDescription ,"status" : status.description] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.AcceptRejectScheduleUrl, method: .post, parameters: params) { [self] (success : AcceptRejectScheduleModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            HideViews()
        }
    }
    
    // MARK: - ACCEPT_REJECT_SCHEDULE_API
    func AskToAdminAPI(){
        let params = ["sessionToken" : SingleTon.shared.userToken,"note" : chatDescriptionTxtVw.text! ,"subject" : chatSubjectTxtFld.text!] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.AskToAdminUrl,  method: .post, parameters: params) { [self] (success : AskToAdminModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            HideViews()
        }
    }

    
    // MARK: - CREATE_PROJECT_API
    func CreateProjectAPI(){
        var currentLocation: CLLocation!
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager?.location
            lat = currentLocation.coordinate.latitude.description
            long = currentLocation.coordinate.longitude.description
            
            let params = ["sessionToken" : SingleTon.shared.userToken,"name" : createProjectNameTxtFld.text!,"contractorName" : createProjectContractorTxtFld.text!,"lat" : lat,"long" : long,"address" : createProjectAddressTxtFld.text!,"city" : createProjectCityTxtFld.text!,"state" : createProjectStateTxtFld.text!,"postalCode" : createProjectPostalTxtFld.text!] as [String : Any]
            ApiFunc.shared.APIHeaderMethod(url: ApiUrl.CreateProjectUrl, method: .post, parameters: params) { [self] (success : CreateProjectModel?) in
                AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
                HideViews()
            }
        }
    }
    
    
    // MARK: - GET_SCHEDULE_API
    func GetScheduleAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ScheduleUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : ScheduleModel?) in
            let scheduleData = success!.data
            leavesArray.removeAll()
            leavesArray = scheduleData.dates
            calendr.reloadData()
            HideViewsExcept(Vw: GlobalCalendrVw)
            calendrReasonVw.isHidden = true
            crossCalndr.isHidden = false
            calndrCancelSubmitVw.isHidden = true
            startdateHolidayLbl.text = "Schedule Calendar"
            isOpenCalendarForVacation = false
            calendr.scope = .month
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
    
    
}

extension DashboardVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
                dayPunchSwitch.setOn(SingleTon.shared.isPunchedIn, animated: true)
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
    
}


extension DashboardVC : FSCalendarDelegateAppearance, FSCalendarDelegate, FSCalendarDataSource{
    
    // MARK: - FSCALENDAR_DELEGATES_DATASOURCES
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        if StartDate != nil{
            return StartDate!
        }
        else{
            return Date()
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
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        if isOpenCalendarForVacation{
            let mydate = DateFormatter()
            mydate.dateFormat = "MM/dd/yyyy"
            if StartDate == nil{
                StartDateStr = mydate.string(from: date)
                StartDate = date
                print(StartDateStr)
                applyLeavesArray.append(StartDateStr!)
                startdateHolidayLbl.text = "Select Time Off Dates"
                calendr.reloadData()
            }
            else{
                EndDateStr = mydate.string(from: date)
                EndDate = date
                print(EndDateStr)
                applyLeavesArray.append(EndDateStr!)
                okReasonBtn.isEnabled = true
                calendrReasonVw.isHidden = false
            }
        }
        else{
            let mydate = DateFormatter()
            mydate.dateFormat = "MM/dd/yyyy"
            let dateString : String = mydate.string(from:date)
            if self.leavesArray.contains(dateString) {
                let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScheduleRequestsVC") as! ScheduleRequestsVC
                VC.filterDate = dateString
                VC.forMeetingPdf = false
                
                VC.isComeForCheckSchedule = true
                VC.headerText = "Scheduled Events"
                self.navigationController?.pushViewController(VC, animated: true)
            }
            else{
                calendr.deselect(date)
            }
            
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
}

extension DashboardVC : UITextFieldDelegate{
    // MARK: - TEXTFIELD_DELEGATES
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.expenseCategoryTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.expenseCategoryTxtFld.showList()
            return false
        }
        else if textField == self.createProjectStateTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.createProjectStateTxtFld.showList()
            return false
        }
        
        else if textField == self.leaveTypeTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.leaveTypeTxtFld.showList()
            return false
        }
        else if textField == self.expenseProjectTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.expenseProjectTxtFld.showList()
            return false
        }
        
        return true
    }
}
