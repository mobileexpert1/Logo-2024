//
//  VacationsVC.swift
//  Logo
//
//  Created by Mobile on 05/04/24.
//

import UIKit
import FSCalendar
import iOSDropDown

class VacationsVC: UIViewController,FSCalendarDelegate, FSCalendarDataSource {
    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var monthNameLabel: UILabel!
    @IBOutlet weak var bgImgVw: UIImageView!
    @IBOutlet weak var back_img: UIImageView!
    @IBOutlet weak var baseVw: UIView!
    
    @IBOutlet weak var calendrReasonVw: UIView!
    @IBOutlet weak var reasonTxtVw: UITextView!
    @IBOutlet weak var okReasonBtn: UIButton!
    @IBOutlet weak var GlobalCalendrVw: UIView!
    @IBOutlet weak var startdateHolidayLbl: UILabel!
    @IBOutlet weak var leaveTypeTxtFld: DropDown!
    @IBOutlet weak var crossCalndr: UIImageView!
    
    @IBOutlet weak var bgimg: UIImageView!
    @IBOutlet weak var calndrCancelSubmitVw: UIView!
    
    var leaveTypeArray = ["Unpaid","Paid"]
    
    
    private var currentPage: Date?
    var StartDate : Date?
    var EndDate : Date?
    var StartDateStr : String?
    var EndDateStr : String?
    var applyLeavesArray : [String] = []
    var leavesArray : [String] = []
    var isOpenCalendarForVacation = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgimg.isHidden = true
        GlobalCalendrVw.isHidden = true
        GetLeavesAPI()
        calenderView.dataSource = self
        leaveTypeTxtFld.delegate = self
        calenderView.delegate = self
        leaveTypeTxtFld.optionArray = leaveTypeArray
        leaveTypeTxtFld.didSelect { selectedText, index, id in
            print("Selected Text \(selectedText)")
            
            
        }
        
        calenderView.appearance.headerTitleColor = UIColor.black
        calenderView.appearance.weekdayTextColor = UIColor.black
        calenderView.appearance.titleTodayColor = UIColor.white
        calenderView.appearance.borderRadius = 0.5
        calenderView.appearance.selectionColor = UIColor.clear
        //        calenderView.appearance.titleSelectionColor = UIColor(red: 0.847, green: 0.086, blue: 0.224, alpha: 1)
        //        calenderView.appearance.borderSelectionColor = UIColor(red: 0.847, green: 0.086, blue: 0.224, alpha: 1)
        updateBackgroundColor()
        GlobalCalendrVw.layer.cornerRadius = 10.0
        reasonTxtVw.layer.cornerRadius = 5.0
        calenderView.appearance.titleSelectionColor = UIColor(red: 216/255, green: 22/255, blue: 57/255, alpha: 1)
        calenderView.appearance.borderSelectionColor = UIColor(red: 216/255, green: 22/255, blue: 57/255, alpha: 1)
        calenderView.appearance.todayColor = UIColor.blue
        calenderView.calendarHeaderView.calendar.headerHeight = 0
        calenderView.scrollEnabled = false
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        let currentDate = Date()
        let monthNameWithYear = dateFormatter.string(from: currentDate)
        
        print(monthNameWithYear)
        monthNameLabel.text = monthNameWithYear
        var temp = [Date]()
        
        let today = Date()
        
        let calendar = Calendar.current
        let tomorrow = calendar.date(byAdding: .day, value: 1, to: today)
        let newDat = calendar.date(byAdding: .day, value: 2, to: today)
        let newDattr = calendar.date(byAdding: .day, value: 6, to: today)
        
        let dateFormattere = DateFormatter()
        dateFormattere.dateFormat = "yyyy-MM-dd"
        
        
        temp.append(today)
        temp.append(tomorrow!)
        temp.append(newDat!)
        temp.append(newDattr!)
        
        
        
        print(temp)
        
        
        
        
        
    }
    func HideViewsExcept(Vw:UIView){
        
        GlobalCalendrVw.isHidden = true
        bgimg.isHidden = true
        UIView.transition(with: Vw, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            Vw.isHidden = false
        })
    }
    
    func updateBackgroundColor() {
        
        if traitCollection.userInterfaceStyle == .dark {
            
            baseVw.backgroundColor = ThemeColor.darkThemeViewBGColor
            back_img.tintColor = .white
            bgImgVw.image = UIImage(named: "Dashboard2Light")
            bgimg.image = UIImage(named: "Dashboard2")
        }
        else{
            bgimg.tintColor = .black
            back_img.tintColor = .black
            
        }
        
    }
    @IBAction func cancelHolidayBtnAction(_ sender: UIButton) {
        cancelCalndrAction()
    }
    func cancelCalndrAction(){
        reasonTxtVw.text = nil
        leaveTypeTxtFld.text = nil
        leavesArray.removeAll()
        GlobalCalendrVw.isHidden = true
        bgimg.isHidden = true
        StartDate = nil
        EndDate = nil
        HideViews()
        if (calenderView.selectedDate != nil){
            calenderView.deselect(calenderView.selectedDate!)
        }
        calendrReasonVw.isHidden = true
        // okReasonBtn.isEnabled = false
        calenderView.reloadData()
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
    func ApplyLeavesAPI(){
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: applyLeavesArray, options: .prettyPrinted)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                print(jsonString)
                let params = ["sessionToken" : SingleTon.shared.userToken,"leaveDates" : jsonString,"reason" : reasonTxtVw.text!, "type":leaveTypeTxtFld.selectedIndex?.description] as [String : Any]
                ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ApplyLeavesUrl, method: .post, parameters: params) { [self] (success : ApplyLeavesModel?) in
                    AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
                    HideViews()
                    if (calenderView.selectedDate != nil){
                        calenderView.deselect(calenderView.selectedDate!)
                    }
                    calenderView.reloadData()
                }
            }
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    func HideViews(){
        
        
        StartDate = nil
        EndDate = nil
        applyLeavesArray.removeAll()
        reasonTxtVw.text = nil
        // startdateHolidayLbl.text = "Select Time Off Dates"
        
        leaveTypeTxtFld.text = nil
        bgimg.isHidden = true
        GlobalCalendrVw.isHidden = true
        calenderView.reloadData()
    }
    @IBAction func backClick(_ sender: Any) {
        self.moveCurrentPage(moveUp: false)
    }
    private lazy var today: Date = {
        return Date()
    }()
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
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        updateBackgroundColor()
    }
    
    @IBAction func nextClick(_ sender: Any) {
        self.moveCurrentPage(moveUp: true)
        
    }
    
    @IBAction func btn_backscreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    //        let now = Date()
    //            let cal = Calendar.current
    //        
    //        
    //
    //            let newDate = cal.date(bySettingHour: cal.component(.hour, from: now),
    //                                          minute: cal.component(.minute, from: now),
    //                                          second: cal.component(.second, from: now),
    //                                              of: date)!
    //        
    //        
    //      
    //        
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "yyyy-MM-dd"
    //        let UTCTimeAsString = dateFormatter.string(from: newDate)
    //
    //        
    //        print(UTCTimeAsString)
    //        print(calenderView.selectedDates)
    //        
    //
    //    }
    
    
    
    // MARK: - GET_LEAVES_API
    func GetLeavesAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.LeavesUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : LeavesModel?) in
            let leavesData = success!.data
            leavesArray.removeAll()
            leavesArray = leavesData.vacationsLeaves
            //            HideViewsExcept(Vw: GlobalCalendrVw)
            crossCalndr.isHidden = true
            calndrCancelSubmitVw.isHidden = false
            calendrReasonVw.isHidden = true
            isOpenCalendarForVacation = true
            // calenderView.reloadData()
            
            
            
            
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
                //  startdateHolidayLbl.text = "Select Time Off Dates"
                calenderView.reloadData()
            }
            else{
                EndDateStr = mydate.string(from: date)
                EndDate = date
                print(EndDateStr)
                applyLeavesArray.append(EndDateStr!)
                GlobalCalendrVw.isHidden = false
                calendrReasonVw.isHidden = false
                bgimg.isHidden = false
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
                calenderView.deselect(date)
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
    
    
    
    //    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    //        let dateFormatter = DateFormatter()
    //        dateFormatter.dateFormat = "yyyy-MM-dd"
    //        let selectedDateAsString = dateFormatter.string(from: date)
    //        
    //        print(selectedDateAsString)
    //        
    //        
    //    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabBar(false)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    func showTabBar(_ show: Bool) {
        tabBarController?.tabBar.isHidden = !show
    }
}
extension VacationsVC : UITextFieldDelegate{
    // MARK: - TEXTFIELD_DELEGATES
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.leaveTypeTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.leaveTypeTxtFld.showList()
            return false
        }
        
        return true
    }
}
