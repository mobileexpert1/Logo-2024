//  PickerHandler.swift


import Foundation
import UIKit

var systemNameSelectedId : Int?

extension UITextField {
    func  loadDropdownData(data: [String], selectedIndex : Int, indexPathRow: Int) {
        self.inputView = MyPickerView(pickerData: data, dropdownField: self, selectedIndex: selectedIndex, indexPathRow: indexPathRow)
    }
    
    func loadDropdownData2(data: [String]) {
        self.inputView = MyPickerView2(pickerData: data, dropdownField: self)
    }}



class MyPickerView : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerData : [String]!
    var pickerTextField : UITextField!
    var selectedIndex : Int!
    var indexPathRow : Int!
    
    init(pickerData: [String], dropdownField: UITextField, selectedIndex: Int, indexPathRow : Int) {
        super.init(frame: CGRect.zero)
        
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
        self.selectedIndex = selectedIndex
        self.indexPathRow = indexPathRow
        
        self.delegate = self
        self.dataSource = self
        
        setToolBar(pickerTextField)
        DispatchQueue.main.async {
            self.pickerTextField.allowsEditingTextAttributes = false
            if pickerData.count != 0 {
                if  let storedModel = UserDefaults.standard.object(forKey: "model" + SectionDataHandler.shared.selectedReportId) as? Data {
                    let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
                    
                    let year = model.data[self.selectedIndex].questionJSON![indexPathRow].answer
                    self.pickerTextField.text = year
                } else {
                    self.pickerTextField.text = self.pickerData[0]
                }
                
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickerTextField.text = pickerData[row]
        SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![self.indexPathRow].answer = pickerData[row]
        
        let model = SectionDataHandler.shared.model
        try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model" + SectionDataHandler.shared.selectedReportId)
    }
    
    func setToolBar(_ textField : UITextField) {
        // UIPickerView
        self.backgroundColor = UIColor.white
        textField.inputView = self
        
        // Adding Button ToolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)

        toolBar.backgroundColor = .clear
        toolBar.barTintColor = #colorLiteral(red: 0, green: 0.4789864421, blue: 1, alpha: 1)

        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(resignTextFieldResponder))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(resignTextFieldResponder))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func resignDoneTextFieldResponder() {
        if ((pickerTextField.text?.isEmpty) != nil) {
            pickerTextField.text = pickerData[0]
        }
        pickerTextField.resignFirstResponder()
    }
    
    @objc func resignTextFieldResponder() {
        pickerTextField.resignFirstResponder()
    }
}

class MyPickerView2 : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var pickerData : [String]!
    var pickerTextField : UITextField!
    
    
    init(pickerData: [String], dropdownField: UITextField) {
        super.init(frame: CGRect.zero)
        
        self.pickerData = pickerData
        self.pickerTextField = dropdownField
        
        self.delegate = self
        self.dataSource = self
        
        setToolBar(pickerTextField)
        DispatchQueue.main.async {
            if pickerData.count != 0 {
                self.pickerTextField.text = self.pickerData[0]
                self.pickerTextField.isEnabled = true
            } else {
                self.pickerTextField.text = nil
                self.pickerTextField.isEnabled = false
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Sets number of columns in picker view
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // Sets the number of rows in the picker view
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // This function sets the text of the picker view to the content of the "salutations" array
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        systemNameSelectedId = row+1
        return pickerData[row]
    }
    
    // When user selects an option, this function will set the text of the text field to reflect
    // the selected option.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        systemNameSelectedId = row+1
        pickerTextField.text = pickerData[row]
    }
    
    func setToolBar(_ textField : UITextField) {
        // UIPickerView
        self.backgroundColor = UIColor.white
        textField.inputView = self
        
        // Adding Button ToolBar
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        toolBar.tintColor =  #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        toolBar.backgroundColor = .clear
        toolBar.barTintColor =  #colorLiteral(red: 0, green: 0.4789864421, blue: 1, alpha: 1)
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(resignTextFieldResponder))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(resignTextFieldResponder))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        textField.inputAccessoryView = toolBar
    }
    
    @objc func resignTextFieldResponder() {
        pickerTextField.resignFirstResponder()
    }
}




////  PickerHandler.swift
//
//
//import Foundation
//import UIKit
//
//var systemNameSelectedId : Int?
//
//extension UITextField {
//    func  loadDropdownData(data: [String], selectedIndex : Int, indexPathRow: Int) {
//        self.inputView = MyPickerView(pickerData: data, dropdownField: self, selectedIndex: selectedIndex, indexPathRow: indexPathRow)
//    }
//    
//    func loadDropdownData2(data: [String]) {
//        self.inputView = MyPickerView2(pickerData: data, dropdownField: self)
//    }}
//
//
//
//class MyPickerView : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
//    
//    var pickerData : [String]!
//    var pickerTextField : UITextField!
//    var selectedIndex : Int!
//    var indexPathRow : Int!
//    
//    init(pickerData: [String], dropdownField: UITextField, selectedIndex: Int, indexPathRow : Int) {
//        super.init(frame: CGRect.zero)
//        
//        self.pickerData = pickerData
//        self.pickerTextField = dropdownField
//        self.selectedIndex = selectedIndex
//        self.indexPathRow = indexPathRow
//        
//        self.delegate = self
//        self.dataSource = self
//        
//        setToolBar(pickerTextField)
//        DispatchQueue.main.async {
//            self.pickerTextField.allowsEditingTextAttributes = false
//            if pickerData.count != 0 {
//                if  let storedModel = UserDefaults.standard.object(forKey: "model" + SectionDataHandler.shared.selectedReportId) as? Data {
//                    let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
//                    
//                    let year = model.data[self.selectedIndex].questionJSON![indexPathRow].answer
//                    self.pickerTextField.text = year
//                } else {
//                    self.pickerTextField.text = self.pickerData[0]
//                }
//                
//                self.pickerTextField.isEnabled = true
//            } else {
//                self.pickerTextField.text = nil
//                self.pickerTextField.isEnabled = false
//            }
//        }
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // Sets number of columns in picker view
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    // Sets the number of rows in the picker view
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count
//    }
//    
//    // This function sets the text of the picker view to the content of the "salutations" array
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return pickerData[row]
//    }
//    
//    // When user selects an option, this function will set the text of the text field to reflect
//    // the selected option.
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        pickerTextField.text = pickerData[row]
//        SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![self.indexPathRow].answer = pickerData[row]
//        
//        let model = SectionDataHandler.shared.model
//        try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model" + SectionDataHandler.shared.selectedReportId)
//    }
//    
//    func setToolBar(_ textField : UITextField) {
//        // UIPickerView
//        self.backgroundColor = UIColor.white
//        textField.inputView = self
//        
//        // Adding Button ToolBar
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//        toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        toolBar.backgroundColor = .clear
//        toolBar.barTintColor = #colorLiteral(red: 0, green: 0.4789864421, blue: 1, alpha: 1)
//        
//        // Adding Button ToolBar
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(resignTextFieldResponder))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(resignTextFieldResponder))
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//        textField.inputAccessoryView = toolBar
//    }
//    
//    @objc func resignDoneTextFieldResponder() {
//        if ((pickerTextField.text?.isEmpty) != nil) {
//            pickerTextField.text = pickerData[0]
//        }
//        pickerTextField.resignFirstResponder()
//    }
//    
//    @objc func resignTextFieldResponder() {
//        pickerTextField.resignFirstResponder()
//    }
//}
//
//class MyPickerView2 : UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
//    
//    var pickerData : [String]!
//    var pickerTextField : UITextField!
//    
//    
//    init(pickerData: [String], dropdownField: UITextField) {
//        super.init(frame: CGRect.zero)
//        
//        self.pickerData = pickerData
//        self.pickerTextField = dropdownField
//        
//        self.delegate = self
//        self.dataSource = self
//        
//        setToolBar(pickerTextField)
//        DispatchQueue.main.async {
//            if pickerData.count != 0 {
//                self.pickerTextField.text = self.pickerData[0]
//                self.pickerTextField.isEnabled = true
//            } else {
//                self.pickerTextField.text = nil
//                self.pickerTextField.isEnabled = false
//            }
//        }
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//    
//    // Sets number of columns in picker view
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1
//    }
//    
//    // Sets the number of rows in the picker view
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return pickerData.count
//    }
//    
//    // This function sets the text of the picker view to the content of the "salutations" array
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        systemNameSelectedId = row+1
//        return pickerData[row]
//    }
//    
//    // When user selects an option, this function will set the text of the text field to reflect
//    // the selected option.
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        systemNameSelectedId = row+1
//        pickerTextField.text = pickerData[row]
//        
//        //for type type 1,2 for this api: submitManualRequestApi1
//        if row == 0 {
//            pickerTextField.text = pickerData[0]
//        }else {
//            pickerTextField.text = pickerData[1]
//        }
//        
//    }
//    
//    func setToolBar(_ textField : UITextField) {
//        // UIPickerView
//        self.backgroundColor = UIColor.white
//        textField.inputView = self
//        
//        // Adding Button ToolBar
//        let toolBar = UIToolbar()
//        toolBar.sizeToFit()
//        toolBar.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        toolBar.backgroundColor = .clear
//        toolBar.barTintColor = #colorLiteral(red: 0, green: 0.4789864421, blue: 1, alpha: 1)
//        
//        // Adding Button ToolBar
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(resignTextFieldResponder))
//        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
//        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(resignTextFieldResponder))
//        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
//        toolBar.isUserInteractionEnabled = true
//        textField.inputAccessoryView = toolBar
//    }
//    
//    @objc func resignTextFieldResponder() {
//        pickerTextField.resignFirstResponder()
//    }
//}
