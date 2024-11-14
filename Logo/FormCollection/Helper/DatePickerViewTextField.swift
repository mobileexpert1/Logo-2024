//  DatePickerViewTextField.swift

import Foundation
import UIKit

class DatePickerField: UITextField {

    // Date Picker
    let datePickerView:UIDatePicker = UIDatePicker()
    let timePicker : UIDatePicker = UIDatePicker()
    var selectedIndex = Int()
    var indexPathRow = Int()

    // ==================
    //              DATE
    // ==================
    
    func setDatePicker(selectedIndex : Int, indexPathRow: Int) {
        self.allowsEditingTextAttributes = false
        self.selectedIndex = selectedIndex
        self.indexPathRow = indexPathRow
        // Adding Date Picker
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        }
        let calendar = Calendar(identifier: .gregorian)
        let currentDate = NSDate()
        //let dateComponents = NSDateComponents()
        //dateComponents.year = -10
        //let maxDate = calendar.date(byAdding: dateComponents as DateComponents, to: currentDate as Date)
        datePickerView.maximumDate = Date()
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControl.Event.valueChanged)
        datePickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        datePickerView.setValue(UIColor.black, forKey: "textColor")
        datePickerView.setValue(false, forKey: "highlightsToday")
        self.inputView = datePickerView
        // Adding Button ToolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        toolBar.backgroundColor = .clear
        toolBar.barTintColor = #colorLiteral(red: 0, green: 0.4789864421, blue: 1, alpha: 1)

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.datePickerDone))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelBtnTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.inputAccessoryView = toolBar
    }
    
    func setSimpleDatePicker() {
      
        // Adding Date Picker
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        if #available(iOS 13.4, *) {
            datePickerView.preferredDatePickerStyle = .wheels
        }
//        let calendar = Calendar(identifier: .gregorian)
//        let currentDate = NSDate()
        //let dateComponents = NSDateComponents()
        //dateComponents.year = -10
        //let maxDate = calendar.date(byAdding: dateComponents as DateComponents, to: currentDate as Date)
//        datePickerView.maximumDate = Date()
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged2), for: UIControl.Event.valueChanged)
        datePickerView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        datePickerView.setValue(UIColor.black, forKey: "textColor")
        datePickerView.setValue(false, forKey: "highlightsToday")
        self.inputView = datePickerView
        // Adding Button ToolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        toolBar.backgroundColor = .clear
        toolBar.barTintColor = #colorLiteral(red: 0, green: 0.4789864421, blue: 1, alpha: 1)

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.datePickerDone2))
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelBtnTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.inputAccessoryView = toolBar
    }
    // Done Button
    @objc func datePickerDone() {
        setDate()
        self.resignFirstResponder()
    }
    // Done Button
    @objc func datePickerDone2() {
        setDate2()
        self.resignFirstResponder()
    }
    // Cancel button
    @objc func cancelBtnTapped() {
        self.resignFirstResponder()
    }
    // Slider Value for date
    @objc func datePickerValueChanged() {
        setDate()
    }
    // Slider Value for date
    @objc func datePickerValueChanged2() {
        setDate2()
    }
    // Set Date To TextField
    func setDate() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: datePickerView.date)
        self.text = dateStr.uppercased()
        
        
        
        SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPathRow].answer = self.text!
        print("test33-->",SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPathRow].question)
        print("test33-->",SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPathRow].answer)
        
        let model = SectionDataHandler.shared.model
        try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model" + SectionDataHandler.shared.selectedReportId)
    }
    // Set Date To TextField
    func setDate2() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateStr = dateFormatter.string(from: datePickerView.date)
        self.text = dateStr.uppercased()
    }
    
    
        //==================
       //              TIME
       //==================
       
       func setTimePicker() {
           // Adding Date Picker
           timePicker.datePickerMode = UIDatePicker.Mode.time
           if #available(iOS 13.4, *) {
               timePicker.preferredDatePickerStyle = .wheels
           }
           //datePickerView.minimumDate = Date()
           timePicker.addTarget(self, action: #selector(self.timePickerValueChanged), for: UIControl.Event.valueChanged)
           timePicker.locale = NSLocale(localeIdentifier: "en_GB") as Locale
           timePicker.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           self.inputView = timePicker
           
           // Adding Button ToolBar
           let toolBar = UIToolbar()
           toolBar.sizeToFit()
           toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
           toolBar.backgroundColor = .clear
           toolBar.barTintColor = #colorLiteral(red: 0, green: 0.4789864421, blue: 1, alpha: 1)
           
           let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.timePickerDone))
           let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.timeCancelBtnTapped))
           let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
           
           toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
           toolBar.isUserInteractionEnabled = true
           
           self.inputAccessoryView = toolBar
       }
       
       // Done Button
       @objc func timePickerDone() {
           setTime()
           self.resignFirstResponder()
       }
       
       // Cancel button
       @objc func timeCancelBtnTapped() {
           self.resignFirstResponder()
       }
       
       // Slider Value for date
       @objc func timePickerValueChanged() {
           setTime()
       }
       
       // Set Date To TextField
       func setTime() {
           let dateFormatter = DateFormatter()
           
           dateFormatter.dateFormat =  "HH:mm"
           //dateFormatter.dateFormat =  "MM-dd-yyyy HH:mm"
           //dateFormatter.dateFormat =  "yyyy-MM-dd HH:mm:ss"
           
           let dateStr = dateFormatter.string(from: timePicker.date)
           self.text = dateStr
       }
    
    

}

/*
 //======================  FORMATS ======================//
 
 Wednesday, Sep 12, 2018           --> EEEE, MMM d, yyyy
 09/12/2018                        --> MM/dd/yyyy
 09-12-2018 14:11                  --> MM-dd-yyyy HH:mm
 Sep 12, 2:11 PM                   --> MMM d, h:mm a
 September 2018                    --> MMMM yyyy
 Sep 12, 2018                      --> MMM d, yyyy
 Wed, 12 Sep 2018 14:11:54 +0000   --> E, d MMM yyyy HH:mm:ss Z
 2018-09-12T14:11:54+0000          --> yyyy-MM-dd'T'HH:mm:ssZ
 12.09.18                          --> dd.MM.yy
 10:41:02.112                      --> HH:mm:ss.SSS
 10:41 AM                          --> hh:mm a
 
 //======================================================//
 */

protocol ToolbarPickerViewDelegate: AnyObject {
    func didTapDone()
    func didTapCancel()
}

class ToolbarPickerView: UIPickerView {

    public private(set) var toolbar: UIToolbar?
    public weak var toolbarDelegate: ToolbarPickerViewDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }

    private func commonInit() {
        // Adding Button ToolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        toolBar.backgroundColor = .clear
        toolBar.barTintColor = #colorLiteral(red: 0.2274509804, green: 0.568627451, blue: 0.9450980392, alpha: 1)

        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.doneTapped))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(self.cancelTapped))

        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true

        self.toolbar = toolBar
    }

    @objc func doneTapped() {
        self.toolbarDelegate?.didTapDone()
    }

    @objc func cancelTapped() {
        self.toolbarDelegate?.didTapCancel()
    }
}
