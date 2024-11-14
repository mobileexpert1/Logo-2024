//
//  MenualReportVC.swift
//  Logo
//
//  Created by Mobile on 29/10/22.
//

import UIKit

class MenualReportVC: UIViewController {

    var userDetail:MenualReportModel?
    var inspectTypePopUp: InspectionTypePopup!
    
    
    @IBOutlet weak var installationTypeTxtFld: UITextField!
    @IBOutlet weak var nameTxtFld: UITextField!
    @IBOutlet weak var emailTxtField: UITextField!
    @IBOutlet weak var mobileTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var address1TextField: UITextField!
    @IBOutlet weak var address2TextField: UITextField!
    @IBOutlet weak var postalCodeTextField: UITextField!
    @IBOutlet weak var assignTimeTextField: DatePickerField!
    @IBOutlet weak var assignDateTextField: DatePickerField!
    @IBOutlet weak var inspectorTypeTextField: UITextField!
    @IBOutlet weak var buildingNameTextField: UITextField!
    @IBOutlet weak var baseVw: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var nameHeaderLbl: UILabel!
    @IBOutlet weak var billVw: UIView!
    @IBOutlet weak var inpectionVw: UIView!
    
    
    @IBOutlet weak var vw_One: UIView!
    @IBOutlet weak var vw_Two: UIView!
    @IBOutlet weak var vw_Three: UIView!
    @IBOutlet weak var vw_Four: UIView!
    @IBOutlet weak var vw_five: UIView!
    @IBOutlet weak var vw_six: UIView!
    @IBOutlet weak var vw_Seven: UIView!
    @IBOutlet weak var vw_Eight: UIView!
    @IBOutlet weak var vw_Nine: UIView!
    
    @IBOutlet weak var vw_Elv: UIView!
    @IBOutlet weak var vw_Ten: UIView!
    
    @IBOutlet weak var vw_Twelve: UIView!
    @IBOutlet weak var vw_Eleven: UIView!
    @IBOutlet weak var twelveEntireView: UIView!
    
    var isComeFromInstallation = false
    //pickerView
    let pickerView = UIPickerView()
    let pickerData = ["Above ground","Back flow"]
//    var textValueForPicker: String?
    
    var isComingFromCalenderVC: Bool?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(vc: self, backBtnImg: UIImage(named: "Vector right")!, middleTitle: "Add request" , rightAction: #selector(RightBtnAction(sender:)))
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(red: 31/255, green: 51/255, blue: 113/255, alpha: 1.0)]
      
        let fonts =  UIFont.boldSystemFont(ofSize: 21.0)
        let textAttributes = [NSAttributedString.Key.font: fonts]
        self.navigationController?.navigationBar.titleTextAttributes = textAttributes
        inspectorTypeTextField.loadDropdownData2(data: ["Quarterly", "1st Quarterly", "2nd Quarterly", "3rd Quarterly", "Semi-Annual", "Annual", "Standpipe", "Dry Valve", "Preaction", "Extinguishers", "Pump Inspection", "5 Year", "3-Year Dry Trip Test"])
        assignDateTextField.setSimpleDatePicker()
        assignTimeTextField.setTimePicker()
        font()
       // setupPickerView()
    }
    
    func font(){
        vw_One.layer.cornerRadius = 12
        vw_Two.layer.cornerRadius = 12
        vw_Three.layer.cornerRadius = 12
        vw_Four.layer.cornerRadius = 12
        vw_five.layer.cornerRadius = 12
        vw_six.layer.cornerRadius = 12
        vw_Seven.layer.cornerRadius = 12
        vw_Eight.layer.cornerRadius = 12
        vw_Nine.layer.cornerRadius = 12
        vw_Elv.layer.cornerRadius = 12
        vw_Ten.layer.cornerRadius = 12
        vw_Eleven.layer.cornerRadius = 12
        vw_Twelve.layer.cornerRadius = 12
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateBackgroundColor()
        installationTypeTxtFld.loadDropdownData2(data: ["Above ground","Back flow"])  // testing purpose
        
        if isComeFromInstallation{
            nameHeaderLbl.text = "Property Name"
            billVw.isHidden = true
            inpectionVw.isHidden = true
        }
        else{
            nameHeaderLbl.text = "Name"
            billVw.isHidden = false
            inpectionVw.isHidden = false
        }
        
        //to hide tweleve View when coming from home controller
        if isComingFromCalenderVC ?? false  {
            twelveEntireView.isHidden = true
        }else {
            twelveEntireView.isHidden = false
        }
    }
    
   //  picker setting up
    func setupPickerView() {
     installationTypeTxtFld.inputView = pickerView
     pickerView.delegate = self
     pickerView.dataSource = self
    }
    
    
    
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                // Dark mode is enabled
                baseVw.backgroundColor = ThemeColor.lightThemeImageTintColor
                self.view.backgroundColor = ThemeColor.lightThemeImageTintColor
         //       nextBtn.backgroundColor = ThemeColor.darkThemeCellBGColor
            }
            else{
                
            }
        }
    }
    

    @objc func RightBtnAction(sender: UIButton){
    }
    
    @IBAction func makeReportButton(_ sender: UIButton) {
        ClearDataClass.removeAllValues()
        if isComeFromInstallation{
            self.pushToformVcByValidations1()
        }
        else{
            self.pushToformVcByValidations()
        }
      
    }
    func showInspectPopUp(){
        inspectTypePopUp = InspectionTypePopup()
        inspectTypePopUp?.cancelButton.actionBlock { [weak self] in
            guard let self = self else { return }
            self.inspectTypePopUp.removeFromSuperview()
        }
        inspectTypePopUp?.nextBtn.actionBlock { [weak self] in
            guard let self = self else { return }
            //let vc = self.storyboard?.instantiateViewController(withIdentifier: "Form_VC") as! Form_VC
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SectionTitlesViewController") as! SectionTitlesViewController
            self.navigationController?.pushViewController(vc, animated: true)
            self.inspectTypePopUp?.removeFromSuperview()
            self.inspectTypePopUp = nil
           }
        self.navigationController?.view.addSubview(self.inspectTypePopUp)
        self.inspectTypePopUp.frame = (self.navigationController?.view.frame)!
        //self.tabBarController?.view.addSubview(self.completeKyc)
    }
   
    func pushToformVcByValidations(){
        if let name = nameTxtFld.text,let email = emailTxtField.text,let cont = mobileTextField.text,let address1 = address1TextField.text,let address2 = address2TextField.text,let postal = postalCodeTextField.text,let state = stateTextField.text,let city = cityTextField.text ,let time = assignTimeTextField.text,let date = assignDateTextField.text,let type = inspectorTypeTextField.text,let installationType = installationTypeTxtFld.text {
            
            SingleTon.shared.menualReportDetail = MenualReportModel(name: name, email: email, contact: cont, city: city, state: state, addressLine1: address1, addressLine2: address2, postalCode: postal, userId: "999")
            //MenualReportModel(name: name, email: email, contact: cont, location: address1, userId: "999")
            SingleTon.shared.isMakeMenualReport = true
            SingleTon.shared.clientName = name
            SingleTon.shared.requestAddressLine1 = address1
            SingleTon.shared.requestAddressLine2 = address2
            SingleTon.shared.postalCode = postal
            SingleTon.shared.requestState = state
            SingleTon.shared.requestCity = city
           // SingleTon.shared.requestStreetNuber = street
            SingleTon.shared.reqesedtUserId = "999"
            
            if name == ""{
                showOnlyAlert("Poseidon", message: "enter name")
            }else if email == ""{
                showOnlyAlert("Poseidon", message: "enter Email Address")
            }else if !email.isValidEmail(){
                showOnlyAlert("Poseidon", message: "enter Valid Email Address")
            }else if cont == ""{
                showOnlyAlert("Poseidon", message: "enter Contact Number")
            }
            else if city == ""{
                showOnlyAlert("Poseidon", message: "enter City")
            }
            else if state == ""{
                showOnlyAlert("Poseidon", message: "enter State")
            }
            else if address1 == ""{
                showOnlyAlert("Poseidon", message: "enter Address Line 1")
            }
            else if address2 == ""{
                showOnlyAlert("Poseidon", message: "enter Address Line 2")
            }
            else if postal == ""{
                showOnlyAlert("Poseidon", message: "enter Postal Code")
            }
            else if date == ""{
                showOnlyAlert("Poseidon", message: "enter date")
            }
            else if time == ""{
                showOnlyAlert("Poseidon", message: "enter time")
            }
            else if type == ""{
                showOnlyAlert("Poseidon", message: "enter type")
            }
            else if installationType == ""{
                showOnlyAlert("Poseidon", message: "enter installation type")
            }
            
            else{
                // call api here
               // showInspectPopUp()
                ApiFunc.shared.submitManualRequestApi(self.view, self.nameTxtFld.text, self.emailTxtField.text, self.mobileTextField.text, self.address1TextField.text, self.address2TextField.text, self.cityTextField.text, self.stateTextField.text, self.postalCodeTextField.text, self.assignDateTextField.text, self.assignTimeTextField.text, self.inspectorTypeTextField.text, self.buildingNameTextField.text, "\(systemNameSelectedId ?? 0)") { response in
                    print(response)
                    print(response.status)
                    print(response.message)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
       
        else{
            showOnlyAlert("Poseidon!", message: "fill all details and continue")
        }
    }
    
    
    
    func pushToformVcByValidations1(){
        if let name = nameTxtFld.text,let email = emailTxtField.text,let cont = mobileTextField.text,let address1 = address1TextField.text,let postal = postalCodeTextField.text,let state = stateTextField.text,let city = cityTextField.text ,let time = assignTimeTextField.text,let date = assignDateTextField.text,let installationType = installationTypeTxtFld.text {
            
            
            if name == ""{
                showOnlyAlert("Poseidon", message: "enter name")
            }else if email == ""{
                showOnlyAlert("Poseidon", message: "enter Email Address")
            }else if !email.isValidEmail(){
                showOnlyAlert("Poseidon", message: "enter Valid Email Address")
            }else if cont == ""{
                showOnlyAlert("Poseidon", message: "enter Contact Number")
            }
            else if city == ""{
                showOnlyAlert("Poseidon", message: "enter City")
            }
            else if state == ""{
                showOnlyAlert("Poseidon", message: "enter State")
            }
            else if address1 == ""{
                showOnlyAlert("Poseidon", message: "enter Address Line 1")
            }
            else if postal == ""{
                showOnlyAlert("Poseidon", message: "enter Postal Code")
            }
            else if date == ""{
                showOnlyAlert("Poseidon", message: "enter date")
            }
            else if time == ""{
                showOnlyAlert("Poseidon", message: "enter time")
            }else if installationType == ""{
                showOnlyAlert("Poseidon", message: "enter installation type")
            }
            
            else{
                // call api here
               // showInspectPopUp()
                ApiFunc.shared.submitManualRequestApi1(self.view, self.nameTxtFld.text, self.emailTxtField.text, self.mobileTextField.text, self.address1TextField.text, self.cityTextField.text, self.stateTextField.text, self.postalCodeTextField.text, self.assignDateTextField.text, self.assignTimeTextField.text,"\(systemNameSelectedId ?? 0)"){ response in
                    print(response)
                    print(response.status)  
                    print(response.message)
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
       
        else{
            showOnlyAlert("Poseidon!", message: "fill all details and continue")
        }
    }
    
    
    
}
struct MenualReportModel{
    var name:String
    var email:String
    var contact: String
    var city:String
    var state:String
    var addressLine1:String
    var addressLine2:String
   // var street:String
    var postalCode:String
    var userId:String
    init(name: String, email: String, contact: String,city:String, state: String, addressLine1: String, addressLine2: String, postalCode: String, userId: String) {
        self.name = name
        self.email = email
        self.contact = contact
        self.city = city
        self.state = state
        self.addressLine1 = addressLine1
        self.addressLine2 = addressLine2
       // self.street = street
        self.postalCode = postalCode
        self.userId = userId
    }
    
}

// picker delegates
extension MenualReportVC: UIPickerViewDelegate, UIPickerViewDataSource {
    // MARK:  UIPickerViewDataSource
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return 1
       }

       func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
           return pickerData.count
       }
       
       // MARK:  UIPickerViewDelegate
       func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
           return pickerData[row]
       }

       func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
          // textValueForPicker = "\(row+1)"
           if row == 0 {
               installationTypeTxtFld.text = pickerData[0]
           }else{
               installationTypeTxtFld.text = pickerData[1]
           }
           
       }
}
