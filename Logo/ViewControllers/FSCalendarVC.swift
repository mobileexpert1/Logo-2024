//
//  FSCalendarVC.swift
//  Logo
//
//  Created by Vishal on 07/04/24.
//

import UIKit
import FSCalendar


class FSCalendarVC: UIViewController , FSCalendarDataSource, FSCalendarDelegate , UITextFieldDelegate, UITextViewDelegate{
    @IBOutlet weak var calendar: FSCalendar!
    
    
    @IBOutlet weak var jobNameFld: UITextField!
    @IBOutlet weak var timeInFls: UITextField!
    @IBOutlet weak var timeOutFld: UITextField!
    @IBOutlet weak var hoursFld: UITextField!
    @IBOutlet weak var workDescriptionTxtVw: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var backBtn: UIImageView!
    
    
    var DataArr = [["weekName":"Monday", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""],["weekName":"Tuesday", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""],["weekName":"Wednesday", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""],["weekName":"Thursday", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""],["weekName":"Friday", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""]]
    var selectedDate: Date?
    var isTimesheetAdded = false
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        return formatter
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.firstWeekday = 2
        calendar.calendarHeaderView.calendar.headerHeight = 0
        calendar.appearance.headerTitleColor = UIColor.black
        calendar.appearance.weekdayTextColor = UIColor.black
        calendar.appearance.titleTodayColor = UIColor.black
        calendar.appearance.selectionColor = UIColor(red: 26/255, green: 65/255, blue: 158/255, alpha: 1.0)
        calendar.appearance.todayColor = UIColor.clear
       // calendar.appearance.borderSelectionColor = UIColor(red: 0.847, green: 0.086, blue: 0.224, alpha: 1)
        calendar.addObserver(self, forKeyPath: "scope", options: [.new, .old], context: nil)
        calendar.placeholderType = .none
        calendar.scope = .week
        
        calendar.select(Date(), scrollToDate: true)
        calendar.delegate = self
        calendar.dataSource = self
        calendar.accessibilityIdentifier = "calendar"
       
        let today = Date()
        calendar.select(today)
        selectedDate = today
        updateDataForDate(today)
        calendar.locale = Locale(identifier: "en_US")
        
        let calendar = Calendar.current
        let todays = calendar.startOfDay(for: Date())
        let dayOfWeek = calendar.component(.weekday, from: todays)
        let dates = calendar.range(of: .weekday, in: .weekOfYear, for: todays)!
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: todays) }
            .filter { !calendar.isDateInWeekend($0) }
        
        updateBackgroundColor()
        jobNameFld.delegate = self
        timeInFls.delegate = self
        timeOutFld.delegate = self
        hoursFld.delegate = self
        workDescriptionTxtVw.delegate = self
        
        let myDict = DataArr[0]
        
        jobNameFld.text = myDict["jobName"]
        timeInFls.text = myDict["inTime"]
        timeOutFld.text = myDict["outTime"]
        hoursFld.text = myDict["hrs"]
        workDescriptionTxtVw.text = myDict["descriptionOfWork"]
        
        backBtn.actionBlock {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    
    func updateDataForDate(_ date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dateString = dateFormatter.string(from: date)
        
        if let dataForDate = getDataForDate(dateString) {
            jobNameFld.text = dataForDate["jobName"]
            timeInFls.text = dataForDate["inTime"]
            timeOutFld.text = dataForDate["outTime"]
            hoursFld.text = dataForDate["hrs"]
            workDescriptionTxtVw.text = dataForDate["descriptionOfWork"]
        } else {
            jobNameFld.text = ""
            timeInFls.text = ""
            timeOutFld.text = ""
            hoursFld.text = ""
            workDescriptionTxtVw.text = ""
        }
    }
    func getDataForDate(_ date: String) -> [String: String]? {
        for dict in DataArr {
            if let weekName = dict["weekName"], weekName == date {
                return dict
            }
        }
        return nil
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let selectedDate = selectedDate else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dateString = dateFormatter.string(from: selectedDate)
        
        if let index = DataArr.firstIndex(where: { $0["weekName"] == dateString }) {
            switch textField {
            case jobNameFld:
                DataArr[index]["jobName"] = textField.text ?? ""
            case timeInFls:
                DataArr[index]["inTime"] = textField.text ?? ""
            case timeOutFld:
                DataArr[index]["outTime"] = textField.text ?? ""
            case hoursFld:
                DataArr[index]["hrs"] = textField.text ?? ""
            default:
                break
            }
        }
    }
    
    
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let selectedDate = selectedDate else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dateString = dateFormatter.string(from: selectedDate)
        
        if let index = DataArr.firstIndex(where: { $0["weekName"] == dateString }) {
            DataArr[index]["descriptionOfWork"] = textView.text ?? ""
        }
    }
    
    func containsEmptyString(in array: [[String: String]]) -> Bool {
        for dict in array {
            for value in dict.values {
                if value.isEmpty {
                    return true
                }
            }
        }
        return false
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            
            if traitCollection.userInterfaceStyle == .dark {
                // Dark mode is enabled
                self.view.backgroundColor = ThemeColor.darkThemeViewBGColor
                //      headerLbl.textColor = ThemeColor.darkThemeTextColor
                backBtn.tintColor = ThemeColor.darkThemeImageTintColor
                jobNameFld.attributedPlaceholder = NSAttributedString(
                    string: "Enter Job Name",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
                )
                timeInFls.attributedPlaceholder = NSAttributedString(
                    string: "Time In",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
                )
                timeOutFld.attributedPlaceholder = NSAttributedString(
                    string: "Time Out",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
                )
                hoursFld.attributedPlaceholder = NSAttributedString(
                    string: "Hours",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
                )
                workDescriptionTxtVw.textColor = UIColor.darkGray
                
                UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:ThemeColor.lightThemeImageTintColor], for: .normal)
                UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
                submitBtn.backgroundColor = .white
                submitBtn.setTitleColor(ThemeColor.lightThemeImageTintColor, for: .normal)
                calendar.appearance.headerTitleColor = UIColor.white
                calendar.appearance.weekdayTextColor = UIColor.white
                calendar.appearance.titleTodayColor = UIColor.white
                calendar.appearance.borderRadius = 0.5
                calendar.appearance.selectionColor = UIColor.blue
                //calendar.backgroundColor = .white
                
                
            } else {
                calendar.appearance.borderRadius = 0.5
                UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .normal)
                UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .selected)
                self.view.backgroundColor = ThemeColor.lightThemeViewBGColor
                jobNameFld.attributedPlaceholder = NSAttributedString(
                    string: "Enter Job Name",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
                )
                timeInFls.attributedPlaceholder = NSAttributedString(
                    string: "Time In",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
                )
                timeOutFld.attributedPlaceholder = NSAttributedString(
                    string: "Time Out",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
                )
                hoursFld.attributedPlaceholder = NSAttributedString(
                    string: "Hours",
                    attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
                )
                workDescriptionTxtVw.textColor = UIColor.darkGray
                backBtn.tintColor = ThemeColor.lightThemeImageTintColor
            }
        } else {
            // Fallback for earlier versions
            //    UIView.appearance().backgroundColor = .white
        }
        
        // Refresh the view hierarchy to apply the new background color
        view.setNeedsDisplay()
    }
    
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        
        guard let selectedDate = selectedDate else { return }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dateString = dateFormatter.string(from: selectedDate)
        
        // Find index of selected date in DataArr
        if let index = DataArr.firstIndex(where: { $0["weekName"] == dateString }) {
            // Check if there are empty strings in the data for the selected date
            let hasEmptyString = containsEmptyString(in: [DataArr[index]])
            
            // Output the result
            if hasEmptyString {
                AlertControl.shared.showOnlyAlert("", message: "Kindly fill the timesheet completely")
            } else {
                print("The array does not contain empty strings.")
                
                // Convert data to JSON format
                if let theJSONData = try? JSONSerialization.data(
                    withJSONObject: [DataArr[index]],
                    options: []) {
                    var stringJson = String(data: theJSONData, encoding: .utf8) ?? ""
                    stringJson = stringJson.replacingOccurrences(of: "\\", with: "")
                    print("My JSON String: \(stringJson)")
                    
                    // Call AddTimesheetAPI function
                    AddTimesheetAPI(jsonStr: stringJson)
                }
            }
        }
        
        
        
    }
    
    
    @IBAction func specialDateTextFieldClick(sender: UITextField) {
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.time
        sender.inputView = datePickerView
        if sender == timeOutFld{
            datePickerView.addTarget(self, action: #selector(datePickerFromValueChanged), for: UIControl.Event.valueChanged)
        }
        else{
            datePickerView.addTarget(self, action: #selector(datePickerFromValueChanged1), for: UIControl.Event.valueChanged)
        }
        
    }
    
    @objc func datePickerFromValueChanged(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        timeOutFld.text = dateFormatter.string(from: sender.date)
        
    }
    
    @objc func datePickerFromValueChanged1(sender:UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        timeInFls.text = dateFormatter.string(from: sender.date)
        
    }
    
    
    //    @IBAction func segmentAction(_ sender: UISegmentedControl) {
    //        print(sender.selectedSegmentIndex)
    //        let myDict = DataArr
    //         jobNameFld.text = myDict["jobName"]
    //         timeInFls.text = myDict["inTime"]
    //         timeOutFld.text = myDict["outTime"]
    //         hoursFld.text = myDict["hrs"]
    //         workDescriptionTxtVw.text = myDict["descriptionOfWork"]
    //    }
    
    
    
    
    // MARK: - ADD_TIMESHEET_API
    func AddTimesheetAPI(jsonStr : String){
        let params = ["sessionToken" : SingleTon.shared.userToken,"weekData" : jsonStr] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.TimeSheetSubmitUrl, method: .post, parameters: params) { [self] (success : AddExpenseModel?) in
            SingleTon.shared.timeSheetData = DataArr
            print(SingleTon.shared.timeSheetData)
            AlertControl.shared.showAlert("", message: "Timesheet Added Successfully", buttons: ["OK"]) { a in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
    
    
}


extension FSCalendarVC {
    
    
    // MARK: - KVO
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "scope" {
            if let oldScopeValue = change?[.oldKey] as? Int,
               let newScopeValue = change?[.newKey] as? Int,
               let oldScope = FSCalendarScope(rawValue: UInt(oldScopeValue)),
               let newScope = FSCalendarScope(rawValue: UInt(newScopeValue)) {
                print("From \(oldScope == .week ? "week" : "month") to \(newScope == .week ? "week" : "month")")
            }
        }
    }
    
    
    
    // MARK: - FSCalendarDelegate
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        
        view.layoutIfNeeded()
    }
    
    //    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
    //        print("did select date \(dateFormatter.string(from: date))")
    //
    //        let selectedDates = calendar.selectedDates.map { dateFormatter.string(from: $0) }
    //        print("selected dates are \(selectedDates)")
    //
    //
    //        if monthPosition == .next || monthPosition == .previous {
    //            calendar.setCurrentPage(date, animated: true)
    //        }
    //    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(#function) \(dateFormatter.string(from: calendar.currentPage))")
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        
        let weekDayName = dateFormatter.string(from: date)
        print("Selected day of the week: \(weekDayName)")
        
        selectedDate = date
        updateDataForDate(date)
        print("did select date \(dateFormatter.string(from: date))")
        
        let selectedDates = calendar.selectedDates.map { dateFormatter.string(from: $0) }
        print("selected dates are \(selectedDates)")
        
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
  
}

































//class FSCalendarVC: UIViewController , FSCalendarDataSource, FSCalendarDelegate , UITextFieldDelegate, UITextViewDelegate{
//    @IBOutlet weak var calendar: FSCalendar!
//    
//    
//    @IBOutlet weak var jobNameFld: UITextField!
//    @IBOutlet weak var timeInFls: UITextField!
//    @IBOutlet weak var timeOutFld: UITextField!
//    @IBOutlet weak var hoursFld: UITextField!
//    @IBOutlet weak var workDescriptionTxtVw: UITextView!
//    @IBOutlet weak var submitBtn: UIButton!
//    @IBOutlet weak var backBtn: UIImageView!
//    
//    var DataArr = [["weekName":"Mon", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""],["weekName":"Tue", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""],["weekName":"Wed", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""],["weekName":"Thu", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""],["weekName":"Fri", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""]]
//    
//    var isTimesheetAdded = false
//
//    private var dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy/MM/dd"
//        return formatter
//    }()
//    
//        
//        override func viewDidLoad() {
//            super.viewDidLoad()
//            calendar.calendarHeaderView.calendar.headerHeight = 0
//            calendar.appearance.headerTitleColor = UIColor.black
//            calendar.appearance.weekdayTextColor = UIColor.black
//            calendar.appearance.titleTodayColor = UIColor.black
//            calendar.addObserver(self, forKeyPath: "scope", options: [.new, .old], context: nil)
//            calendar.placeholderType = .none
//            calendar.scope = .week
//            calendar.select(Date(), scrollToDate: true)
//            calendar.delegate = self
//            // For UITest
//            calendar.accessibilityIdentifier = "calendar"
//            
//      
//        
//            
//            
//            updateBackgroundColor()
//            jobNameFld.delegate = self
//            timeInFls.delegate = self
//            timeOutFld.delegate = self
//            hoursFld.delegate = self
//            workDescriptionTxtVw.delegate = self
//            
//           let myDict = DataArr[0]
//            
//            jobNameFld.text = myDict["jobName"]
//            timeInFls.text = myDict["inTime"]
//            timeOutFld.text = myDict["outTime"]
//            hoursFld.text = myDict["hrs"]
//            workDescriptionTxtVw.text = myDict["descriptionOfWork"]
//            
//            backBtn.actionBlock {
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
//        
//  
//    
//    func containsEmptyString(in array: [[String: String]]) -> Bool {
//        for dict in array {
//            for value in dict.values {
//                if value.isEmpty {
//                    return true
//                }
//            }
//        }
//        return false
//    }
//
//   
//    
//    
////    func textFieldDidEndEditing(_ textField: UITextField) {
////        switch textField{
////        case jobNameFld :
////            var myDict = DataArr
////            myDict["jobName"] = jobNameFld.text!
////            DataArr[segmentControl.selectedSegmentIndex] = myDict
////        case timeInFls :
////            var myDict = DataArr[segmentControl.selectedSegmentIndex]
////            myDict["inTime"] = timeInFls.text!
////            DataArr[segmentControl.selectedSegmentIndex] = myDict
////        case timeOutFld :
////            var myDict = DataArr[segmentControl.selectedSegmentIndex]
////            myDict["outTime"] = timeOutFld.text!
////            DataArr[segmentControl.selectedSegmentIndex] = myDict
////        case hoursFld :
////            var myDict = DataArr[segmentControl.selectedSegmentIndex]
////            myDict["hrs"] = hoursFld.text!
////            DataArr[segmentControl.selectedSegmentIndex] = myDict
////        default :
////            print("Nothing")
////        }
////    }
//    
////    func textViewDidEndEditing(_ textView: UITextView) {
////        var myDict = DataArr[segmentControl.selectedSegmentIndex]
////        myDict["descriptionOfWork"] = workDescriptionTxtVw.text!
////        DataArr[segmentControl.selectedSegmentIndex] = myDict
////        
////        
////    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.setNavigationBarHidden(true, animated: animated)
//     
//       
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        navigationController?.setNavigationBarHidden(false, animated: animated)
//    }
//    
//    func updateBackgroundColor() {
//            if #available(iOS 13.0, *) {
//               
//                if traitCollection.userInterfaceStyle == .dark {
//              // Dark mode is enabled
//                    self.view.backgroundColor = ThemeColor.darkThemeViewBGColor
//              //      headerLbl.textColor = ThemeColor.darkThemeTextColor
//                    backBtn.tintColor = ThemeColor.darkThemeImageTintColor
//                    jobNameFld.attributedPlaceholder = NSAttributedString(
//                        string: "Enter Job Name",
//                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
//                    )
//                    timeInFls.attributedPlaceholder = NSAttributedString(
//                        string: "Time In",
//                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
//                    )
//                    timeOutFld.attributedPlaceholder = NSAttributedString(
//                        string: "Time Out",
//                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
//                    )
//                    hoursFld.attributedPlaceholder = NSAttributedString(
//                        string: "Hours",
//                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
//                    )
//                    workDescriptionTxtVw.textColor = UIColor.darkGray
//                    
//                    UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:ThemeColor.lightThemeImageTintColor], for: .normal)
//                    UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
//                    submitBtn.backgroundColor = .white
//                    submitBtn.setTitleColor(ThemeColor.lightThemeImageTintColor, for: .normal)
//                    calendar.appearance.headerTitleColor = UIColor.white
//                    calendar.appearance.weekdayTextColor = UIColor.white
//                    calendar.appearance.titleTodayColor = UIColor.white
//                    calendar.appearance.borderRadius = 0.5
//                    calendar.appearance.selectionColor = UIColor.blue
//                    //calendar.backgroundColor = .white
//                   
//                    
//                } else {
//                    calendar.appearance.borderRadius = 0.5
//                    UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .normal)
//                    UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.black], for: .selected)
//                    self.view.backgroundColor = ThemeColor.lightThemeViewBGColor
//                    jobNameFld.attributedPlaceholder = NSAttributedString(
//                        string: "Enter Job Name",
//                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
//                    )
//                    timeInFls.attributedPlaceholder = NSAttributedString(
//                        string: "Time In",
//                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
//                    )
//                    timeOutFld.attributedPlaceholder = NSAttributedString(
//                        string: "Time Out",
//                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
//                    )
//                    hoursFld.attributedPlaceholder = NSAttributedString(
//                        string: "Hours",
//                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray]
//                    )
//                    workDescriptionTxtVw.textColor = UIColor.darkGray
//                    backBtn.tintColor = ThemeColor.lightThemeImageTintColor
//                }
//            } else {
//                // Fallback for earlier versions
//            //    UIView.appearance().backgroundColor = .white
//            }
//
//            // Refresh the view hierarchy to apply the new background color
//            view.setNeedsDisplay()
//        }
//    
//    
//    @IBAction func submitBtnAction(_ sender: UIButton) {
//   
//        // Check if there are empty strings
//        let hasEmptyString = containsEmptyString(in: DataArr)
//
//        // Output the result
//        if hasEmptyString {
//            AlertControl.shared.showOnlyAlert("", message: "Kindly fill the Timesheet completely")
//      //      submitBtn.isEnabled = false
//        } else {
//            print("The array does not contain empty strings.")
//            
//            
//            if let theJSONData = try? JSONSerialization.data(
//                withJSONObject: DataArr,
//                options: []) {
//                var stringJson = (String(data: theJSONData,
//                                         encoding: .utf8)!)
//                stringJson = stringJson.replacingOccurrences(of: "\\", with: "")
//                print(("My Json String :- \(stringJson)"))
//                
//                AddTimesheetAPI(jsonStr: stringJson)
//            }
//            
//       //     submitBtn.isEnabled = true
//        }
//        
//        
//    }
//    
//    
//    @IBAction func specialDateTextFieldClick(sender: UITextField) {
//        let datePickerView:UIDatePicker = UIDatePicker()
//        datePickerView.datePickerMode = UIDatePicker.Mode.time
//        sender.inputView = datePickerView
//        if sender == timeOutFld{
//            datePickerView.addTarget(self, action: #selector(datePickerFromValueChanged), for: UIControl.Event.valueChanged)
//        }
//        else{
//            datePickerView.addTarget(self, action: #selector(datePickerFromValueChanged1), for: UIControl.Event.valueChanged)
//        }
//     
//    }
//    
//    @objc func datePickerFromValueChanged(sender:UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "hh:mm a"
//        timeOutFld.text = dateFormatter.string(from: sender.date)
//        
//    }
//    
//    @objc func datePickerFromValueChanged1(sender:UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "hh:mm a"
//        timeInFls.text = dateFormatter.string(from: sender.date)
//        
//    }
//    
//    
////    @IBAction func segmentAction(_ sender: UISegmentedControl) {
////        print(sender.selectedSegmentIndex)
////        let myDict = DataArr
////         jobNameFld.text = myDict["jobName"]
////         timeInFls.text = myDict["inTime"]
////         timeOutFld.text = myDict["outTime"]
////         hoursFld.text = myDict["hrs"]
////         workDescriptionTxtVw.text = myDict["descriptionOfWork"]
////    }
//    
//    
//    
//    
//    // MARK: - ADD_TIMESHEET_API
//    func AddTimesheetAPI(jsonStr : String){
//        let params = ["sessionToken" : SingleTon.shared.userToken,"weekData" : jsonStr] as [String : Any]
//        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.TimeSheetSubmitUrl, method: .post, parameters: params) { [self] (success : AddExpenseModel?) in
//            SingleTon.shared.timeSheetData = DataArr
//             print(SingleTon.shared.timeSheetData)
//            AlertControl.shared.showAlert("", message: "Timesheet Added Successfully", buttons: ["OK"]) { a in
//                self.navigationController?.popViewController(animated: true)
//            }
//        }
//    }
//    
//        
//        
//        
//    }
//    
//
//extension FSCalendarVC {
//  
//    
//    // MARK: - KVO
//    
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "scope" {
//            if let oldScopeValue = change?[.oldKey] as? Int,
//               let newScopeValue = change?[.newKey] as? Int,
//               let oldScope = FSCalendarScope(rawValue: UInt(oldScopeValue)),
//               let newScope = FSCalendarScope(rawValue: UInt(newScopeValue)) {
//                print("From \(oldScope == .week ? "week" : "month") to \(newScope == .week ? "week" : "month")")
//            }
//        }
//    }
//    
//    
//    
//    // MARK: - FSCalendarDelegate
//    
//    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
//      
//        view.layoutIfNeeded()
//    }
//    
////    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
////        print("did select date \(dateFormatter.string(from: date))")
////        
////        let selectedDates = calendar.selectedDates.map { dateFormatter.string(from: $0) }
////        print("selected dates are \(selectedDates)")
////      
////        
////        if monthPosition == .next || monthPosition == .previous {
////            calendar.setCurrentPage(date, animated: true)
////        }
////    }
//    
//    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//        print("\(#function) \(dateFormatter.string(from: calendar.currentPage))")
//    }
//    
//    
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "EEEE"
//        
//        let weekDayName = dateFormatter.string(from: date)
//        print("Selected day of the week: \(weekDayName)")
//         
//        
//        print("did select date \(dateFormatter.string(from: date))")
//        
//        let selectedDates = calendar.selectedDates.map { dateFormatter.string(from: $0) }
//        print("selected dates are \(selectedDates)")
//        
//        if monthPosition == .next || monthPosition == .previous {
//            calendar.setCurrentPage(date, animated: true)
//        }
//    }
//
//}
