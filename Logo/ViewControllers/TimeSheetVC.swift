//
//  TimeSheetVC.swift
//  Logo
//
//  Created by MOBILE on 27/07/23.
//

import UIKit

class TimeSheetVC: UIViewController , UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var jobNameFld: UITextField!
    @IBOutlet weak var timeInFls: UITextField!
    @IBOutlet weak var timeOutFld: UITextField!
    @IBOutlet weak var hoursFld: UITextField!
    @IBOutlet weak var workDescriptionTxtVw: UITextView!
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var backBtn: UIImageView!
    
    
    
    var DataArr = [["weekName":"Mon", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""],["weekName":"Tue", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""],["weekName":"Wed", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""],["weekName":"Thu", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""],["weekName":"Fri", "jobName" : "", "inTime" : "","outTime" : "","hrs" : "","descriptionOfWork" : ""]]
    
    var isTimesheetAdded = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // OR "dd-MM-yyyy"
        let currentDateString: String = dateFormatter.string(from: date)
        print("Current date is \(currentDateString)")
        
        if isTimesheetAdded{
            if SingleTon.shared.timeSheetData.count < 2{
                
            }
            else{
                DataArr = SingleTon.shared.timeSheetData
            }
            //            jobNameFld.isEnabled = false
            //            timeInFls.isEnabled = false
            //            timeOutFld.isEnabled = false
            //            hoursFld.isEnabled = false
            //            workDescriptionTxtVw.isEditable = false
        }
        
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
    
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField{
        case jobNameFld :
            var myDict = DataArr[segmentControl.selectedSegmentIndex]
            myDict["jobName"] = jobNameFld.text!
            DataArr[segmentControl.selectedSegmentIndex] = myDict
        case timeInFls :
            var myDict = DataArr[segmentControl.selectedSegmentIndex]
            myDict["inTime"] = timeInFls.text!
            DataArr[segmentControl.selectedSegmentIndex] = myDict
        case timeOutFld :
            var myDict = DataArr[segmentControl.selectedSegmentIndex]
            myDict["outTime"] = timeOutFld.text!
            DataArr[segmentControl.selectedSegmentIndex] = myDict
        case hoursFld :
            var myDict = DataArr[segmentControl.selectedSegmentIndex]
            myDict["hrs"] = hoursFld.text!
            DataArr[segmentControl.selectedSegmentIndex] = myDict
        default :
            print("Nothing")
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        var myDict = DataArr[segmentControl.selectedSegmentIndex]
        myDict["descriptionOfWork"] = workDescriptionTxtVw.text!
        DataArr[segmentControl.selectedSegmentIndex] = myDict
        
        
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
                segmentControl.backgroundColor = .white
                segmentControl.selectedSegmentTintColor = ThemeColor.lightThemeImageTintColor
                UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:ThemeColor.lightThemeImageTintColor], for: .normal)
                UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.white], for: .selected)
                submitBtn.backgroundColor = .white
                submitBtn.setTitleColor(ThemeColor.lightThemeImageTintColor, for: .normal)
            } else {
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
        
        // Check if there are empty strings
        let hasEmptyString = containsEmptyString(in: DataArr)
        
        // Output the result
        if hasEmptyString {
            AlertControl.shared.showOnlyAlert("", message: "Kindly fill the Timesheet completely")
            //      submitBtn.isEnabled = false
        } else {
            print("The array does not contain empty strings.")
            
            
            if let theJSONData = try? JSONSerialization.data(
                withJSONObject: DataArr,
                options: []) {
                var stringJson = (String(data: theJSONData,
                                         encoding: .utf8)!)
                stringJson = stringJson.replacingOccurrences(of: "\\", with: "")
                print(("My Json String :- \(stringJson)"))
                
                AddTimesheetAPI(jsonStr: stringJson)
            }
            
            //     submitBtn.isEnabled = true
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
    
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        print(sender.selectedSegmentIndex)
        let myDict = DataArr[segmentControl.selectedSegmentIndex]
        jobNameFld.text = myDict["jobName"]
        timeInFls.text = myDict["inTime"]
        timeOutFld.text = myDict["outTime"]
        hoursFld.text = myDict["hrs"]
        workDescriptionTxtVw.text = myDict["descriptionOfWork"]
    }
    
    
    
    
    // MARK: - ADD_TIMESHEET_API
    func AddTimesheetAPI(jsonStr : String){
        let params = ["sessionToken" : SingleTon.shared.userToken,"weekData" : jsonStr] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.TimeSheetSubmitUrl, method: .post, parameters: params) { [self] (success : AddExpenseModel?) in
            SingleTon.shared.timeSheetData = DataArr
            AlertControl.shared.showAlert("", message: "Timesheet Added Successfully", buttons: ["OK"]) { a in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
}

