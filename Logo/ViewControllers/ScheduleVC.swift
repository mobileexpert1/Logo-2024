//
//  ScheduleVC.swift
//  Logo
//
//  Created by Mobile on 05/04/24.
//

import UIKit
import FSCalendar

class ScheduleVC: UIViewController ,FSCalendarDelegate, FSCalendarDataSource {
    var leavesArray : [String] = []
    @IBOutlet weak var calenderView: FSCalendar!
    @IBOutlet weak var monthNameLabel: UILabel!
    @IBOutlet weak var bgImgVw: UIImageView!
    @IBOutlet weak var back_img: UIImageView!
    @IBOutlet weak var baseVw: UIView!
   var StartDate : Date?
    var EndDate : Date?
    var StartDateStr : String?
    var EndDateStr : String?
    var applyLeavesArray : [String] = []
    private var currentPage: Date?
    var isOpenCalendarForVacation = true
    override func viewDidLoad() {
        super.viewDidLoad()
        GetScheduleAPI()
        calenderView.dataSource = self
        calenderView.delegate = self
        calenderView.appearance.headerTitleColor = UIColor.black
        calenderView.appearance.weekdayTextColor = UIColor.black
        calenderView.appearance.titleTodayColor = UIColor.white
        calenderView.appearance.borderRadius = 0.5
        calenderView.appearance.selectionColor = UIColor.clear
        updateBackgroundColor()
//        calenderView.appearance.titleSelectionColor = UIColor(red: 0.847, green: 0.086, blue: 0.224, alpha: 1)
//        calenderView.appearance.borderSelectionColor = UIColor(red: 0.847, green: 0.086, blue: 0.224, alpha: 1)
        calenderView.appearance.titleSelectionColor = .black
     //  calenderView.appearance.titleSelectionColor = UIColor(red: 216/255, green: 22/255, blue: 57/255, alpha: 1)
        //calenderView.appearance.borderSelectionColor = UIColor(red: 216/255, green: 22/255, blue: 57/255, alpha: 1)
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
   

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func updateBackgroundColor() {
        
            if traitCollection.userInterfaceStyle == .dark {
             
                baseVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                back_img.tintColor = .white
                bgImgVw.image = UIImage(named: "Dashboard2Light")
            
            }
            else{
                
                back_img.tintColor = .black
              
            }
        
    }
    // MARK: - GET_SCHEDULE_API
    func GetScheduleAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ScheduleUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : ScheduleModel?) in
            let scheduleData = success!.data
            leavesArray.removeAll()
            leavesArray = scheduleData.dates
         calenderView.reloadData()
           
         
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
    
    @IBAction func nextClick(_ sender: Any) {
        self.moveCurrentPage(moveUp: true)

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
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showTabBar(false)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        updateBackgroundColor()
      
    }
    func showTabBar(_ show: Bool) {
        tabBarController?.tabBar.isHidden = !show
        
    }
    
    @IBAction func btn_backscreen(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
