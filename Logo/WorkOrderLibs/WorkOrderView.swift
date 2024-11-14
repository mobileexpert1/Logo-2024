//  ViewController.swift
//  FireDepartment
//  Created by Akshay on 21/01/22.

import UIKit
import SimplePDF
import PKHUD
import CoreLocation

class WorkOrderView: UIViewController,UINavigationControllerDelegate {
    
    // -- checkBoxes
    @IBOutlet weak var dayWorkCheckImage: UIImageView!
    @IBOutlet weak var contractWorkCheckImage: UIImageView!
    @IBOutlet weak var extraWorkCheckImage: UIImageView!
    
    // -- mainButtons
    @IBOutlet weak var resetBtn: UIView!
    @IBOutlet weak var addMaterialBtn: UIView!
    @IBOutlet weak var addLaborBtn: UIView!
    @IBOutlet weak var submitBtn: UIView!
    @IBOutlet weak var addSignBtn: UIView!
    @IBOutlet weak var addServiceBtn: UIView!
    
    // -- popUpViews
    @IBOutlet var addMaterialView: AddMaterialView!
    @IBOutlet var addLaborView: AddLaborView!
    @IBOutlet var signaturePopUpView: SignaturePopUp!
    @IBOutlet var addServiceView: AddServiceView!
    
    @IBOutlet weak var materialImgBg: UIImageView!
    @IBOutlet weak var signatureImgBg: UIImageView!
    @IBOutlet weak var laborImgBg: UIImageView!
    @IBOutlet weak var serviceImgBg: UIImageView!
    
    @IBOutlet weak var grossTotalView: UIView!
    @IBOutlet weak var signatureImage: UIImageView!
    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var laborTableView: UITableView!
    @IBOutlet weak var materialTableView: UITableView!
    @IBOutlet weak var laborTableHeight: NSLayoutConstraint!
    @IBOutlet weak var materialTableHeight: NSLayoutConstraint!
    @IBOutlet weak var signatureImageHeight: NSLayoutConstraint!
    @IBOutlet weak var grossTotalViewHeight: NSLayoutConstraint!
    
    // START: main screen service view ******
    @IBOutlet weak var mainServiceView: UIView!
    @IBOutlet weak var serviceViewHeight: NSLayoutConstraint!
    @IBOutlet weak var mainServiceLbl: UILabel!
    @IBOutlet weak var mainServiceTxtField: UITextField!
    @IBOutlet weak var mainServiceDescriptionLbl: UILabel!
    @IBOutlet weak var mainServiceDescriptionView: UIView!
    @IBOutlet weak var mainServiceTextView: UITextView!
    // END: main screen service view ******
    
    // -- input Fields
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var termsTextField: UITextField!
    @IBOutlet weak var orderTakenByTxtField: UITextField!
    @IBOutlet weak var customersOrderNumberTxtField: UITextField!
    
    @IBOutlet weak var dateOfOrderTextField: DatePickerField!
    
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var jobLocationTextField: UITextField!
    @IBOutlet weak var jobNameTextField: UITextField!
    
    @IBOutlet weak var startingDateTextField: DatePickerField!
    @IBOutlet weak var jobPhoneTextField: UITextField!
    
    @IBOutlet weak var descriptionOfWorkTxtView: UITextView!
    @IBOutlet weak var otherChargesTxtField: UITextField!
    @IBOutlet weak var otherChargesPriceTextField: UITextField!
    @IBOutlet weak var grossTotalAmount: UILabel!
    
    @IBOutlet weak var workOrderByTextField: UITextField!
    @IBOutlet weak var numberOfWorkers: UITextField!
    @IBOutlet weak var backBtn: UIImageView!
    
    // switch fro open the Pdf or the Credit card Screen
    @IBOutlet weak var OnOffSwitch: UISwitch!
    
    
    var window: UIWindow?
    var selectedLanguageFromToggle = "en"
    
    /// LANGUAGE SEGMENT: STARTS
    @IBOutlet weak var toggleLanguage: UISegmentedControl!
    @IBAction func toggleLanguageAction(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            toggleLanguageSegment("en")
            selectedLanguageFromToggle = "en"
        } else {
            toggleLanguageSegment("es")
            selectedLanguageFromToggle = "es"
        }
    }
    func setupLanguageToggleProperties() {
        // selected option color
        toggleLanguage.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        
        // color of other options
        toggleLanguage.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
    }
    /// Code in extensions to hangle view
    /// LANGUAGE SEGMENT: ENDS
    
    
    // MARK: - TITLES
    @IBOutlet weak var welcomeTextLabel: UILabel!
    @IBOutlet weak var resetTextLabel: UILabel!
    @IBOutlet weak var toTextLabel: UILabel!
    @IBOutlet weak var termsTextLabel: UILabel!
    @IBOutlet weak var jobInvoiceTextLabel: UILabel!
    @IBOutlet weak var orderTakenByTextLabel: UILabel!
    @IBOutlet weak var customerOrderNumberTextLabel: UILabel!
    @IBOutlet weak var dateOfOrderTextLabel: UILabel!
    @IBOutlet weak var phoneTextLabel: UILabel!
    @IBOutlet weak var jobNameTextLabel: UILabel!
    @IBOutlet weak var jobLocationTextLabel: UILabel!
    @IBOutlet weak var jobPhoneTextLabel: UILabel!
    @IBOutlet weak var startingDateTextLabel: UILabel!
    @IBOutlet weak var dayWorkTextLabel: UILabel!
    @IBOutlet weak var contractTextLabel: UILabel!
    @IBOutlet weak var extraTextLabel: UILabel!
    @IBOutlet weak var descriptionOfWorkTextLabel: UILabel!
    @IBOutlet weak var otherChargesTextLabel: UILabel!
    @IBOutlet weak var totalMaterialTextLabel: UILabel!
    @IBOutlet weak var addMaterialTextLabel: UILabel!
    @IBOutlet weak var numberOfWorkerTextLabel: UILabel!
    @IBOutlet weak var grossTotalTextLabel: UILabel!
    @IBOutlet weak var priceIncludeOtherChargesTextLabel: UILabel!
    @IBOutlet weak var serviceTextLabel: UILabel!
    @IBOutlet weak var fireSprinklerTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var addServiceTextLabel: UILabel!
    @IBOutlet weak var signatureTextLabel: UILabel!
    @IBOutlet weak var workOrderByTextLabel: UILabel!
    @IBOutlet weak var signatureTextLabel2: UILabel!
    @IBOutlet weak var addSignTextLabel: UILabel!
    @IBOutlet weak var submitTextLabel: UILabel!
    @IBOutlet weak var baseVw: UIView!
    
    
    var materialArr = [[String:String]]()
    var laborArr = [[String:String]]()
    var materialFields = [UITextField]()
    var laborFields = [UITextField]()
    var serviceFields = [UITextField]()
    
    var materialTotal = 0
    var laborTotal = 0
    var otherTotal = 0
    var grossTotal = 0
    var workerCount = 1
    var workType = "Day work"
    
    fileprivate let dataPickerView = ToolbarPickerView()
    fileprivate var pickerData = [String]()
    var pickerType = ""
    var jobId = ""
    
    
    var filledDataDict = [String:Any]()
    var pdf = SimplePDF(pageSize: CGSize(width: 595, height: 840))
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    
    
    //MARK: VIEW LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("traitCollection------>" , traitCollection.userInterfaceStyle == .dark)
        self.showNavigationBar(false)
        dateOfOrderTextField.setSimpleDatePicker()
        startingDateTextField.setSimpleDatePicker()
        OnOffSwitch.isOn = false
        
        self.materialTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        self.laborTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        
        let allScrollTextFields = self.getTextfield(view: self.view)
        for txtField in allScrollTextFields {
            txtField.setLeftPaddingPoints(15)
            txtField.setRightPaddingPoints(15)
            txtField.delegate = self
        }
        mainServiceTextView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        descriptionOfWorkTxtView.delegate = self
        signatureImgBg.actionBlock {
            self.removeView(self.signaturePopUpView)
        }
        
        setBtnActions()
        setPopUpBtnActions()
        handleWorkTypeCheckBoxes()
        handlePickerData()
        handleMaterialPopUpView()
        handleLaborPopUpView()
        handleMainServiceView()
        handleServicePopUpView()
        setupLanguageToggleProperties()
        backBtn.actionBlock {
            self.navigationController?.popViewController(animated: true)
        }
        
    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        updateBackgroundColor()
        //        if dayDifference(from: SingleTon.shared.punchedDate) != "Today"{
        //            punchSwitch.setOn(false, animated: true)
        //        }
        
    }
    
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                // Dark mode is enabled
                baseVw.backgroundColor = ThemeColor.lightThemeImageTintColor
                dayWorkCheckImage.tintColor = .white
                extraWorkCheckImage.tintColor = .white
                contractWorkCheckImage.tintColor = .white
                //    self.view.backgroundColor = ThemeColor.lightThemeImageTintColor
                //       nextBtn.backgroundColor = ThemeColor.darkThemeCellBGColor
            }
            else{
                dayWorkCheckImage.tintColor = .black
                extraWorkCheckImage.tintColor = .black
                contractWorkCheckImage.tintColor = .black
            }
        }
    }
    
    
    func dayDifference(from date : Date) -> String
    {
        let calendar = Calendar.current
        let date = date
        if calendar.isDateInYesterday(date) { return "Yesterday" }
        else if calendar.isDateInToday(date) { return "Today" }
        else if calendar.isDateInTomorrow(date) { return "Tomorrow" }
        else {
            let startOfNow = calendar.startOfDay(for: Date())
            let startOfTimeStamp = calendar.startOfDay(for: date)
            let components = calendar.dateComponents([.day], from: startOfNow, to: startOfTimeStamp)
            let day = components.day!
            if day < 1 { return "\(-day) days ago" }
            else { return "In \(day) days" }
        }
    }
    
    
    
    func handleWorkTypeCheckBoxes() {
        dayWorkCheckImage.actionBlock {
            self.dayWorkCheckImage.image = #imageLiteral(resourceName: "check")
            self.contractWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
            self.extraWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
            self.workType = "Day work"
            self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
            self.filledDataDict["workType"] = self.workType
            UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
        }
        
        contractWorkCheckImage.actionBlock {
            self.dayWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
            self.contractWorkCheckImage.image = #imageLiteral(resourceName: "check")
            self.extraWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
            self.workType = "Contract"
            self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
            self.filledDataDict["workType"] = self.workType
            UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
        }
        
        extraWorkCheckImage.actionBlock {
            self.dayWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
            self.contractWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
            self.extraWorkCheckImage.image = #imageLiteral(resourceName: "check")
            self.workType = "Extra"
            
            self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
            self.filledDataDict["workType"] = self.workType
            UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
        }
    }
    
    func handleMainServiceView() {
        self.serviceViewHeight.constant = 0
        self.mainServiceView.isHidden = true
    }
    
    // -- MATERIAL POP UP
    func handleMaterialPopUpView() {
        materialFields = [self.addMaterialView.quantityTextField, self.addMaterialView.materialTxtField, self.addMaterialView.sizeTxtField]
        self.addMaterialView.materialTxtField.isEnabled = true
        //  self.addMaterialView.materialTxtField.inputView =
        materialImgBg.actionBlock {
            self.removeView(self.addMaterialView)
        }
        let allMaterialTextFields = self.getTextfield(view: self.addMaterialView)
        for txtField in allMaterialTextFields {
            txtField.setLeftPaddingPoints(15)
            txtField.setRightPaddingPoints(15)
            txtField.delegate = self
        }
        //        self.addMaterialView.materialTxtField.inputView = self.dataPickerView
        //        self.addMaterialView.materialTxtField.inputAccessoryView = self.dataPickerView.toolbar
        
        //        self.addMaterialView.sizeTxtField.inputView = self.dataPickerView
        //        self.addMaterialView.sizeTxtField.inputAccessoryView = self.dataPickerView.toolbar
    }
    
    // -- LABOR POP UP
    func handleLaborPopUpView() {
        laborFields = [self.addLaborView.hoursTextField, self.addLaborView.laborTextField, self.addLaborView.priceTextField, self.addLaborView.amountTextField]
        
        laborImgBg.actionBlock {
            self.removeView(self.addLaborView)
        }
        let allLaborTextFields = self.getTextfield(view: self.addLaborView)
        for txtField in allLaborTextFields {
            txtField.setLeftPaddingPoints(15)
            txtField.setRightPaddingPoints(15)
            txtField.delegate = self
        }
        self.addLaborView.laborTextField.inputView = self.dataPickerView
        self.addLaborView.laborTextField.inputAccessoryView = self.dataPickerView.toolbar
    }
    
    // -- SERVICE POP UP
    func handleServicePopUpView() {
        serviceFields = [self.addServiceView.addServiceTextField]
        serviceImgBg.actionBlock {
            self.removeView(self.addServiceView)
        }
        self.addServiceView.addServiceTextField.setLeftPaddingPoints(15)
        self.addServiceView.addServiceTextField.setRightPaddingPoints(15)
        self.addServiceView.addServiceTextField.delegate = self
        self.addServiceView.addServiceTextField.inputView = self.dataPickerView
        self.addServiceView.addServiceTextField.inputAccessoryView = self.dataPickerView.toolbar
        self.addServiceView.descriptionTextView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }
    
    func handlePickerData() {
        self.dataPickerView.dataSource = self
        self.dataPickerView.delegate = self
        self.dataPickerView.toolbarDelegate = self
        self.dataPickerView.reloadAllComponents()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let tbls : [UITableView] = [materialTableView, laborTableView]
        tbls.forEach { tbl in
            tbl.delegate = self
            tbl.dataSource = self
        }
        tbls[0].register(UINib(nibName: "DetailTableCell", bundle: nil), forCellReuseIdentifier: "DetailTableCell")
        tbls[1].register(UINib(nibName: "DetailTableCell", bundle: nil), forCellReuseIdentifier: "DetailTableCell")
        
        tbls[0].register(UINib(nibName: "DetailHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailHeaderCell")
        tbls[1].register(UINib(nibName: "DetailHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailHeaderCell")
        
        tbls[0].register(UINib(nibName: "DetailFooterCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailFooterCell")
        tbls[1].register(UINib(nibName: "DetailFooterCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "DetailFooterCell")
        
        descriptionOfWorkTxtView.contentInset = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        
        
        let filledDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any]
        
        if let dict = filledDict {
            print(dict)
            
            if let toTxt = dict["toTextField"] {
                toTextField.text = toTxt as? String
            }
            if let termsTxt = dict["termsTextField"] {
                termsTextField.text = termsTxt as? String
            }
            if let orderTxt = dict["orderTakenByTxtField"] {
                orderTakenByTxtField.text = orderTxt as? String
            }
            if let customersOrderTxt = dict["customersOrderNumberTxtField"] {
                customersOrderNumberTxtField.text = customersOrderTxt as? String
            }
            if let phoneTextFieldTxt = dict["phoneTextField"] {
                phoneTextField.text = phoneTextFieldTxt as? String
            }
            if let jobNameTextFieldTxt = dict["jobNameTextField"] {
                jobNameTextField.text = jobNameTextFieldTxt as? String
            }
            if let jobLocationTextFieldTxt = dict["jobLocationTextField"] {
                jobLocationTextField.text = jobLocationTextFieldTxt as? String
            }
            if let jobPhoneTextFieldTxt = dict["jobPhoneTextField"] {
                jobPhoneTextField.text = jobPhoneTextFieldTxt as? String
            }
            if let otherChargesTxtFieldTxt = dict["otherChargesTxtField"] {
                otherChargesTxtField.text = otherChargesTxtFieldTxt as? String
            }
            if let otherChargesPriceTextFieldTxt = dict["otherChargesPriceTextField"] {
                otherChargesPriceTextField.text = otherChargesPriceTextFieldTxt as? String
                otherTotal = Int(otherChargesPriceTextField.text ?? "0") ?? 0
            }
            if let workOrderByTextFieldTxt = dict["workOrderByTextField"] {
                workOrderByTextField.text = workOrderByTextFieldTxt as? String
            }
            if let numberOfWorkersTextFieldTxt = dict["numberOfWorkers"] {
                print(numberOfWorkersTextFieldTxt)
                numberOfWorkers.text = numberOfWorkersTextFieldTxt as? String
                self.workerCount = Int(numberOfWorkers.text ?? "1") ?? 1
            }
            if let dateOfOrderTextFieldTxt = dict["dateOfOrderTextField"] {
                dateOfOrderTextField.text = dateOfOrderTextFieldTxt as? String
            }
            if let startingDateTextFieldTxt = dict["startingDateTextField"] {
                startingDateTextField.text = startingDateTextFieldTxt as? String
            }
            
            
            if let materialArr = dict["materialArray"] {
                self.materialArr = materialArr as! [[String : String]]
                self.materialTableView.reloadData()
            }
            
            if let laborArray = dict["laborArray"] {
                self.laborArr = laborArray as! [[String : String]]
                self.laborTableView.reloadData()
            }
            
            if let descriptionOfWorkTxtViewTxt = dict["descriptionOfWorkTxtView"] {
                descriptionOfWorkTxtView.text = descriptionOfWorkTxtViewTxt as? String
            }
            
            if let workType = dict["workType"] {
                print(workType)
                
                switch (workType as! String) {
                case "Contract":
                    self.dayWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
                    self.contractWorkCheckImage.image = #imageLiteral(resourceName: "check")
                    self.extraWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
                case "Day work":
                    self.dayWorkCheckImage.image = #imageLiteral(resourceName: "check")
                    self.contractWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
                    self.extraWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
                case "Extra":
                    self.dayWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
                    self.contractWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
                    self.extraWorkCheckImage.image = #imageLiteral(resourceName: "check")
                default:
                    break
                }
                
            }
            
            if let serviceType = dict["serviceType"] {
                if serviceType as! String == "leftIn" {
                    if let serviceTypeFlow = dict["mainServiceTxtField"] {
                        self.mainServiceTxtField.text = serviceTypeFlow as? String
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            self.serviceViewHeight.constant = 140
                        } else {
                            self.serviceViewHeight.constant = 70
                        }
                        self.mainServiceDescriptionLbl.isHidden = true
                        self.mainServiceTextView.isHidden = true
                    }
                } else {
                    if let serviceTypeFlow = dict["mainServiceTextView"] {
                        self.mainServiceTextView.text = serviceTypeFlow as? String
                    }
                    if let serviceTypeFlow1 = dict["mainServiceTxtField"] {
                        self.mainServiceTxtField.text = serviceTypeFlow1 as? String
                    }
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        self.serviceViewHeight.constant = 350
                    } else {
                        self.serviceViewHeight.constant = 220
                    }
                    self.mainServiceDescriptionLbl.isHidden = false
                    self.mainServiceTextView.isHidden = false
                }
                self.mainServiceView.isHidden = false
            }
            
            
            if dict["signatureImage"] != nil {
                
                if let imageData = dict["signatureImage"] as? Data {
                    self.signatureImage.image = UIImage(data: imageData)!
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        self.signatureImageHeight.constant = 380
                    } else {
                        self.signatureImageHeight.constant = 200
                    }
                }
                
                
            }
            
            
        }
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        materialTableView.layer.removeAllAnimations()
        laborTableView.layer.removeAllAnimations()
        
        materialTableHeight.constant = materialTableView.contentSize.height
        laborTableHeight.constant = laborTableView.contentSize.height
        
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            self.showGrossTotal()
        }
        
    }
    
    
    
    
    
    
    func executeLogin() {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
        UIApplication.shared.currentWindow?.rootViewController = loginVC
        UIApplication.shared.currentWindow?.makeKeyAndVisible()
    }
    
}

//MARK: BUTTONS
extension WorkOrderView {
    
    func setBtnActions() {
        print("*******---------------------------------->>  ",selectedLanguageFromToggle)
        //MARK: ADD MATERIAL
        addMaterialBtn.actionBlock {
            self.view.endEditing(true)
            
            self.materialFields.forEach { txtField in
                txtField.text = ""
            }
            
            self.viewTransition(self.addMaterialView)
        }
        
        //MARK: ADD LABOR
        addLaborBtn.actionBlock {
            self.view.endEditing(true)
            self.laborFields.forEach { txtField in
                txtField.text = ""
            }
            self.viewTransition(self.addLaborView)
        }
        
        //MARK: SUBMIT BUTTON
        /*
         submitBtn.actionBlock {
         self.view.endEditing(true)
         
         print(self.materialArr)
         print(self.laborArr)
         
         if self.checkData() {
         var hyt = 0
         if UIDevice.current.userInterfaceIdiom == .pad {
         hyt = 3100
         } else {
         hyt = 2400
         }
         let A4paperSize = CGSize(width: 595, height: hyt)
         let pdf = SimplePDF(pageSize: A4paperSize)
         
         
         // spacer
         pdf.addLineSpace(20)
         pdf.addImage(UIImage(named: "Banner2")!)
         pdf.addLineSpace(15)
         // simple text
         pdf.addText("JOB INVOICE", font: .systemFont(ofSize: 25))
         
         // spacer
         pdf.addLineSpace(15)
         
         // line
         pdf.addLineSeparator(height: 2)
         
         // spacer
         pdf.addLineSpace(25)
         pdf.addText("To : " + self.toTextField.text!, font: .systemFont(ofSize: 20))
         // spacer
         pdf.addLineSpace(15)
         pdf.addText("Terms : " + self.termsTextField.text!, font: .systemFont(ofSize: 20))
         // spacer
         pdf.addLineSpace(15)
         pdf.addText("Order taken by : " + self.orderTakenByTxtField.text!, font: .systemFont(ofSize: 20))
         // spacer
         pdf.addLineSpace(15)
         pdf.addText("Customer's order number : " + self.customersOrderNumberTxtField.text!, font: .systemFont(ofSize: 20))
         // spacer
         pdf.addLineSpace(15)
         pdf.addText("Date of order : " + self.dateOfOrderTextField.text!, font: .systemFont(ofSize: 20))
         // spacer
         pdf.addLineSpace(15)
         pdf.addText("Phone : " + self.phoneTextField.text!, font: .systemFont(ofSize: 20))
         // spacer
         pdf.addLineSpace(15)
         pdf.addText("Job (Name/Number) : " + self.jobNameTextField.text!, font: .systemFont(ofSize: 20))
         // spacer
         pdf.addLineSpace(15)
         pdf.addText("Job location : " + self.jobLocationTextField.text!, font: .systemFont(ofSize: 20))
         // spacer
         pdf.addLineSpace(15)
         pdf.addText("Job phone : " + self.jobPhoneTextField.text!, font: .systemFont(ofSize: 20))
         // spacer
         pdf.addLineSpace(15)
         pdf.addText("Starting date : " + self.startingDateTextField.text!, font: .systemFont(ofSize: 20))
         // spacer
         pdf.addLineSpace(15)
         pdf.addText("Work type : " + self.workType, font: .systemFont(ofSize: 20))
         // spacer
         pdf.addLineSpace(15)
         pdf.addText("Description of work : " + self.descriptionOfWorkTxtView.text!, font: .systemFont(ofSize: 20))
         
         
         
         // -- check here for other charges *******
         
         
         if !self.otherChargesPriceTextField.text!.isEmpty {
         pdf.addLineSpace(15)
         pdf.addText("\(self.otherChargesTxtField.text!) : " + self.otherChargesPriceTextField.text!, font: .systemFont(ofSize: 20))
         }
         
         
         
         
         
         // -- check here for added materials *******
         
         if self.materialArr.count != 0 {
         pdf.addLineSpace(20)
         pdf.addText("Materials detail: ", font: .systemFont(ofSize: 20))
         let materialTblImg = self.tableToImg(self.materialTableView)
         pdf.addImage(materialTblImg)
         }
         
         
         
         
         pdf.addLineSpace(20)
         pdf.addText("Labor details : ", font: .systemFont(ofSize: 20))
         let laborTblImg = self.tableToImg(self.laborTableView)
         pdf.addImage(laborTblImg)
         
         pdf.addLineSpace(20)
         //pdf.addText("MATERIAL TOTAL : " + String(self.materialTotal), font: .boldSystemFont(ofSize: 20))
         //pdf.addLineSpace(15)
         pdf.addText("LABOR TOTAL : " + String(self.laborTotal), font: .boldSystemFont(ofSize: 20))
         pdf.addLineSpace(15)
         
         
         if self.otherChargesPriceTextField.text!.isEmpty {
         pdf.addText("OTHER CHARGES : 0", font: .boldSystemFont(ofSize: 20))
         } else {
         pdf.addText("OTHER CHARGES : " + self.otherChargesPriceTextField.text!, font: .boldSystemFont(ofSize: 20))
         }
         
         
         pdf.addLineSpace(15)
         
         /*
          GROSS TOTAL
          var total = Int()
          if self.otherChargesPriceTextField.text!.isEmpty {
          total = self.materialTotal + self.laborTotal
          } else {
          total = self.materialTotal + self.laborTotal + Int(self.otherChargesPriceTextField.text!)!
          }
          pdf.addText("GROSS TOTAL : " + String(total), font: .boldSystemFont(ofSize: 20))
          */
         
         
         
         if self.mainServiceTxtField.text?.lowercased() == "left in service" {
         pdf.addText("Fire sprinkler system left in service", font: .systemFont(ofSize: 20), textColor: .blue)
         } else {
         pdf.addText("Fire sprinkler system left off and out of service", font: .systemFont(ofSize: 20), textColor: .red)
         pdf.addLineSpace(10)
         pdf.addText("Any system that cannot be returned to active service in the same business day will require fire watch to be scheduled and provided by the building representative, maintenance company and or building owner. All CPVC systems that are cut into WILL be left off for a 24 hour period for proper glue cure time", font: .systemFont(ofSize: 20), textColor: .red)
         pdf.addLineSpace(10)
         pdf.addText("Description :", font: .systemFont(ofSize: 20), textColor: .black)
         let descriptionTextImg = self.txtViewToImg(self.mainServiceTextView)
         pdf.addImage(descriptionTextImg)
         
         
         }
         
         
         
         
         // spacer
         pdf.addLineSpace(15)
         pdf.addText("Work order by : " + self.workOrderByTextField.text!, font: .systemFont(ofSize: 20))
         
         // spacer & // image
         pdf.addLineSpace(15)
         pdf.addImage(self.signatureImage.image!)
         
         
         
         // Generate PDF data and save to a local file.
         if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
         
         let fileName = "invoice.pdf"
         let documentsFileName = documentDirectories + "/" + fileName
         let str:String = documentsFileName
         let url:URL = URL(fileURLWithPath: str)
         let pdfData = pdf.generatePDFdata()
         do{
         try pdfData.write(to: url , options: .atomic)
         print("\nThe generated pdf can be found at:")
         print(documentsFileName)
         self.pushOnly(controllerId: "InvoiceViewerViewController", animation: true)
         }catch{
         print(error)
         }
         }
         }
         
         
         
         }
         */
        
        
        
        submitBtn.actionBlock { [self] in
            self.view.endEditing(true)
            
            print(self.materialArr)
            print(self.laborArr)
            
            
            if self.checkData() {
                
                var descriptionTextImg1 = UIImage()
                var materialTblImg1 = UIImage()
                
                //MARK: previous work starts here of pdf text
                /*
                 //                var hyt = 0
                 //                if UIDevice.current.userInterfaceIdiom == .pad {
                 //                    hyt = 3100
                 //                } else {
                 //                    hyt = 2400
                 //                }
                 let A4paperSize = CGSize(width: 595, height: 840)
                 let pdf = SimplePDF(pageSize: A4paperSize)
                 
                 // spacer
                 pdf.addLineSpace(10)
                 pdf.addImage(UIImage(named: "Banner2")!)
                 pdf.addLineSpace(10)
                 // simple text
                 //pdf.addText("JOB INVOICE", font: .systemFont(ofSize: 25))
                 pdf.addText("WORK ORDER".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 25))
                 pdf.addText("(This is not final price)".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 15))
                 
                 // spacer
                 pdf.addLineSpace(5)
                 
                 // line
                 pdf.addLineSeparator(height: 2)
                 
                 // spacer
                 pdf.addLineSpace(15)
                 pdf.addText("To : ".localizeString(string: selectedLanguageFromToggle) + self.toTextField.text!, font: .systemFont(ofSize: 20))
                 // spacer
                 pdf.addLineSpace(10)
                 pdf.addText("Terms : ".localizeString(string: selectedLanguageFromToggle) + self.termsTextField.text!, font: .systemFont(ofSize: 20))
                 // spacer
                 pdf.addLineSpace(10)
                 pdf.addText("Order taken by : ".localizeString(string: selectedLanguageFromToggle) + self.orderTakenByTxtField.text!, font: .systemFont(ofSize: 20))
                 // spacer
                 pdf.addLineSpace(10)
                 pdf.addText("Customer's order number : ".localizeString(string: selectedLanguageFromToggle) + self.customersOrderNumberTxtField.text!, font: .systemFont(ofSize: 20))
                 // spacer
                 pdf.addLineSpace(10)
                 pdf.addText("Date of order : ".localizeString(string: selectedLanguageFromToggle) + self.dateOfOrderTextField.text!, font: .systemFont(ofSize: 20))
                 // spacer
                 pdf.addLineSpace(10)
                 pdf.addText("Phone : ".localizeString(string: selectedLanguageFromToggle) + self.phoneTextField.text!, font: .systemFont(ofSize: 20))
                 // spacer
                 pdf.addLineSpace(10)
                 pdf.addText("Job (Name/Number) : ".localizeString(string: selectedLanguageFromToggle) + self.jobNameTextField.text!, font: .systemFont(ofSize: 20))
                 // spacer
                 pdf.addLineSpace(10)
                 pdf.addText("Job location : ".localizeString(string: selectedLanguageFromToggle) + self.jobLocationTextField.text!, font: .systemFont(ofSize: 20))
                 // spacer
                 pdf.addLineSpace(10)
                 pdf.addText("Job phone : ".localizeString(string: selectedLanguageFromToggle) + self.jobPhoneTextField.text!, font: .systemFont(ofSize: 20))
                 // spacer
                 pdf.addLineSpace(10)
                 pdf.addText("Starting date : ".localizeString(string: selectedLanguageFromToggle) + self.startingDateTextField.text!, font: .systemFont(ofSize: 20))
                 // spacer
                 pdf.addLineSpace(10)
                 pdf.addText("Work type : ".localizeString(string: selectedLanguageFromToggle) + self.workType, font: .systemFont(ofSize: 20))
                 // spacer
                 pdf.addLineSpace(10)
                 pdf.addText("Description of work : ".localizeString(string: selectedLanguageFromToggle) + self.descriptionOfWorkTxtView.text!, font: .systemFont(ofSize: 20))
                 
                 
                 // -- check here for other charges *******
                 if !self.otherChargesPriceTextField.text!.isEmpty {
                 pdf.addLineSpace(10)
                 pdf.addText("\(self.otherChargesTxtField.text!) : " + self.otherChargesPriceTextField.text!, font: .systemFont(ofSize: 20))
                 }
                 
                 // pdf.beginNewPage()
                 // spacer
                 pdf.addLineSpace(15)
                 pdf.addText("Number of workers required : ".localizeString(string: selectedLanguageFromToggle) + self.numberOfWorkers.text!, font: .systemFont(ofSize: 20))
                 // spacer
                 pdf.addLineSpace(15)
                 pdf.addText("Work order by : ".localizeString(string: selectedLanguageFromToggle) + self.workOrderByTextField.text!, font: .systemFont(ofSize: 20))
                 
                 // spacer & // image
                 pdf.addLineSpace(10)
                 //   pdf.addImage2(self.signatureImage.image!, width: 350, height: 200)
                 pdf.addImage2(UIImage(named: "Bg")!, width: 0, height: 0)
                 
                 
                 
                 
                 //-*-*-*-*-*-*-*
                 
                 if self.mainServiceTextView.text == "" {
                 if self.mainServiceTxtField.text?.lowercased() == "left in service" {
                 pdf.addLineSpace(10)
                 pdf.addText("Fire sprinkler system left in service".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .blue)
                 } else {
                 pdf.addText("Fire sprinkler system left off and out of service".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .red)
                 pdf.addLineSpace(10)
                 pdf.addText("Any system that cannot be returned to active service in the same business day will require fire watch to be scheduled and provided by the building representative, maintenance company and or building owner. All CPVC systems that are cut into WILL be left off for a 24 hour period for proper glue cure time".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .red)
                 pdf.addLineSpace(10)
                 pdf.addText("Description :".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .black)
                 let descriptionTextImg = self.txtViewToImg(self.mainServiceTextView)
                 pdf.addImage(descriptionTextImg)
                 
                 }
                 } else {
                 pdf.addText("Fire sprinkler system left off and out of service".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .red)
                 pdf.addLineSpace(10)
                 pdf.addText("Any system that cannot be returned to active service in the same business day will require fire watch to be scheduled and provided by the building representative, maintenance company and or building owner. All CPVC systems that are cut into WILL be left off for a 24 hour period for proper glue cure time".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .red)
                 pdf.addLineSpace(10)
                 pdf.addText("Description :".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .black)
                 let descriptionTextImg = self.txtViewToImg(self.mainServiceTextView)
                 pdf.addImage(descriptionTextImg)
                 
                 }
                 
                 
                 
                 
                 //                pdf.addLineSpace(15)
                 //                pdf.addText("LABOR TOTAL : " + String(self.laborTotal), font: .boldSystemFont(ofSize: 20))
                 //                pdf.addLineSpace(15)
                 //
                 //
                 //                if self.otherChargesPriceTextField.text!.isEmpty {
                 //                    pdf.addText("OTHER CHARGES : 0", font: .boldSystemFont(ofSize: 20))
                 //                } else {
                 //                    pdf.addText("OTHER CHARGES : " + self.otherChargesPriceTextField.text!, font: .boldSystemFont(ofSize: 20))
                 //                }
                 //
                 //GROSS TOTAL
                 
                 //                var total = Int()
                 //                if self.otherChargesPriceTextField.text!.isEmpty {
                 //                    total = self.materialTotal + self.laborTotal
                 //                } else {
                 //                    total = self.materialTotal + self.laborTotal + Int(self.otherChargesPriceTextField.text!)!
                 //                }
                 
                 //                pdf.addLineSpace(15)
                 //                pdf.addText("GROSS TOTAL : $" + String(self.grossTotal), font: .boldSystemFont(ofSize: 20))
                 //                pdf.addLineSpace(10)
                 //                pdf.addText("( Detailed price structure is mentioned on next page )", font: .systemFont(ofSize: 15))
                 pdf.beginNewPage()
                 
                 // -- check here for added materials *******
                 
                 if self.materialArr.count != 0 {
                 pdf.addLineSpace(20)
                 pdf.addText("Materials detail: ".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20))
                 let materialTblImg = self.tableToImg(self.materialTableView)
                 pdf.addImage(materialTblImg)
                 }
                 
                 pdf.addLineSpace(35)
                 pdf.addText("Our Labor rates are as follows:".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20))
                 
                 pdf.addLineSpace(20)
                 pdf.addText("Straight Time M-F 7:00AM-3:30PM is 2 men 4 hr minimum.".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 15))
                 pdf.addLineSpace(5)
                 pdf.addText("$110 per hr per man, $85 flat rate for travel, material, plus tax.".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 15))
                 pdf.addLineSpace(5)
                 pdf.addText("Anything over the 4 hrs is additional.".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 15))
                 
                 
                 pdf.addLineSpace(20)
                 pdf.addText("Overtime M-F 3:31PM - 6:59AM. Saturday to 11:59PM is 2 men 4 hr minimum.".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 15))
                 pdf.addLineSpace(5)
                 pdf.addText("$165 per hr per man total is $1,320.00, $85 flat rate for travel, material, plus tax.".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 15))
                 pdf.addLineSpace(5)
                 pdf.addText("Anything over the 4 hrs is additional.".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 15))
                 
                 
                 pdf.addLineSpace(20)
                 pdf.addText("Double Time Sunday12:01AM-11:59 PMis 2 men 4 hr minimum.".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 15))
                 pdf.addLineSpace(5)
                 pdf.addText("$220 per hr each total is $1,760.00, $85 flat rate for travel, material, plus tax.", font: .systemFont(ofSize: 15))
                 pdf.addLineSpace(5)
                 pdf.addText("Anything over the 4 hrs is additional.".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 15))
                 
                 
                 
                 /* pdf.addLineSpace(20)
                  pdf.addText("Labor details : ", font: .systemFont(ofSize: 20))
                  let laborTblImg = self.tableToImg(self.laborTableView)
                  pdf.addImage(laborTblImg)
                  
                  //pdf.addLineSpace(20)
                  //pdf.beginNewPage()
                  //pdf.addText("MATERIAL TOTAL : " + String(self.materialTotal), font: .boldSystemFont(ofSize: 20))
                  
                  
                  
                  pdf.addLineSpace(15)
                  
                  */
                 
                 */
                //MARK: previous work ends here of pdf text
                
                // MARK: New work
                if self.mainServiceTextView.text == "" {
                    if self.mainServiceTxtField.text?.lowercased() == "left in service" {
                        //                        pdf.addLineSpace(10)
                        //                        pdf.addText("Fire sprinkler system left in service".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .blue)
                    } else {
                        //                        pdf.addText("Fire sprinkler system left off and out of service".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .red)
                        //                        pdf.addLineSpace(10)
                        //                        pdf.addText("Any system that cannot be returned to active service in the same business day will require fire watch to be scheduled and provided by the building representative, maintenance company and or building owner. All CPVC systems that are cut into WILL be left off for a 24 hour period for proper glue cure time".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .red)
                        //                        pdf.addLineSpace(10)
                        //                        pdf.addText("Description :".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .black)
                        let descriptionTextImg = self.txtViewToImg(self.mainServiceTextView)
                        descriptionTextImg1 = descriptionTextImg
                        //  pdf.addImage(descriptionTextImg)
                        
                    }
                } else {
                    //                    pdf.addText("Fire sprinkler system left off and out of service".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .red)
                    //                    pdf.addLineSpace(10)
                    //                    pdf.addText("Any system that cannot be returned to active service in the same business day will require fire watch to be scheduled and provided by the building representative, maintenance company and or building owner. All CPVC systems that are cut into WILL be left off for a 24 hour period for proper glue cure time".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .red)
                    //                    pdf.addLineSpace(10)
                    //                    pdf.addText("Description :".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20), textColor: .black)
                    let descriptionTextImg = self.txtViewToImg(self.mainServiceTextView)
                    descriptionTextImg1 = descriptionTextImg
                    //  pdf.addImage(descriptionTextImg)
                    
                }
                
                // -- check here for added materials *******
                
                if self.materialArr.count != 0 {
                    //                    pdf.addLineSpace(20)
                    //                    pdf.addText("Materials detail: ".localizeString(string: selectedLanguageFromToggle), font: .systemFont(ofSize: 20))
                    let materialTblImg = self.tableToImg(self.materialTableView)
                    materialTblImg1 = materialTblImg
                    //      pdf.addImage(materialTblImg)
                }
                
                
                // value for sending to next controller
                
                var dict = ["To":self.toTextField.text!,"Terms":self.termsTextField.text!,"Order_taken_by":self.orderTakenByTxtField.text!,"Customer's_order_number":self.customersOrderNumberTxtField.text!,"Date_of_order":self.dateOfOrderTextField.text!,"Phone":self.phoneTextField.text!,"Job_(Name/Number)":self.jobNameTextField.text!,"Job_location":self.jobLocationTextField.text!,"Job_phone":self.jobPhoneTextField.text!,"Starting_date":self.startingDateTextField.text!,"Work_type":self.workType,"Description_of_work":self.descriptionOfWorkTxtView.text!,"otherChargesPriceTextField":self.otherChargesPriceTextField.text!,"otherChargesTxtField":self.otherChargesTxtField.text!,"Number_of_workers_required":self.numberOfWorkers.text!,"Work_order_by":self.workOrderByTextField.text!,"mainServiceTextView":self.mainServiceTextView.text ?? "","mainServiceTxtField":self.mainServiceTxtField.text! ,"descriptionTextImg": descriptionTextImg1,"materialArr_count": self.materialArr.count,"materialTblImg1":materialTblImg1,"selectedLanguageFromToggle":self.selectedLanguageFromToggle,"signaturePopUpView":self.signaturePopUpView] as [String : Any]
                
                
                if OnOffSwitch.isOn == true {
                    
                    let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreditCard_VC") as! CreditCard_VC
                    VC.dataDict = dict
                    VC.jobName = self.jobNameTextField.text!
                    VC.jobId = jobId
                   // self.reset()
                    self.navigationController?.pushViewController(VC, animated: true)
                    return
                }
                else
                {
                    
                    // adding test to pdf here
                    //MARK: previous work starts here of pdf text
                    
                    //                var hyt = 0
                    //                if UIDevice.current.userInterfaceIdiom == .pad {
                    //                    hyt = 3100
                    //                } else {
                    //                    hyt = 2400
                    //                }
                    //        let dict = ["To":self.toTextField.text!,"Terms":self.termsTextField.text!,"Order_taken_by":self.orderTakenByTxtField.text!,"Customer's_order_number":self.customersOrderNumberTxtField.text!,"Date_of_order":self.dateOfOrderTextField.text!,"Phone":self.phoneTextField.text!,"Job_(Name/Number)":self.jobNameTextField.text!,"Job_location":self.jobLocationTextField.text!,"Job_phone":self.jobPhoneTextField.text!,"Starting_date":self.startingDateTextField.text!,"Work_type":self.workType,"Description_of_work":self.descriptionOfWorkTxtView.text!,"otherChargesPriceTextField":self.otherChargesPriceTextField.text!,"otherChargesTxtField":self.otherChargesTxtField.text!,"Number_of_workers_required":self.numberOfWorkers.text!,"Work_order_by":self.workOrderByTextField.text!,"mainServiceTextView":self.mainServiceTextView.text ?? "","descriptionTextImg": descriptionTextImg1,"materialArr_count": self.materialArr.count,"materialTblImg1":materialTblImg1] as [String : Any]
                    
                    let A4paperSize = CGSize(width: 595, height: 840)
                    let pdf = SimplePDF(pageSize: A4paperSize)
                    
                    // spacer
                    pdf.addLineSpace(10)
                    pdf.addImage(UIImage(named: "Banner2")!)
                    pdf.addLineSpace(10)
                    // simple text
                    //pdf.addText("JOB INVOICE", font: .systemFont(ofSize: 25))
                    pdf.addText("WORK ORDER".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 25))
                    pdf.addText("(This is not final price)".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 15))
                    
                    // spacer
                    pdf.addLineSpace(5)
                    
                    // line
                    pdf.addLineSeparator(height: 2)
                    
                    // spacer
                    pdf.addLineSpace(15)
                    pdf.addText("To : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["To"] as! String )", font: .systemFont(ofSize: 20))
                    // spacer
                    pdf.addLineSpace(10)
                    pdf.addText("Terms : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Terms"] as! String)", font: .systemFont(ofSize: 20))
                    // spacer
                    pdf.addLineSpace(10)
                    pdf.addText("Order taken by : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Order_taken_by"] as! String)", font: .systemFont(ofSize: 20))
                    // spacer
                    pdf.addLineSpace(10)
                    pdf.addText("Customer's order number : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Customer's_order_number"] as! String)", font: .systemFont(ofSize: 20))
                    // spacer
                    pdf.addLineSpace(10)
                    pdf.addText("Date of order : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Date_of_order"] as! String)", font: .systemFont(ofSize: 20))
                    // spacer
                    pdf.addLineSpace(10)
                    pdf.addText("Phone : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Phone"] as! String)", font: .systemFont(ofSize: 20))
                    // spacer
                    pdf.addLineSpace(10)
                    pdf.addText("Job (Name/Number) : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Job_(Name/Number)"] as! String)", font: .systemFont(ofSize: 20))
                    // spacer
                    pdf.addLineSpace(10)
                    pdf.addText("Job location : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Job_location"] as! String)", font: .systemFont(ofSize: 20))
                    // spacer
                    pdf.addLineSpace(10)
                    pdf.addText("Job phone : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Job_phone"] as! String)", font: .systemFont(ofSize: 20))
                    // spacer
                    pdf.addLineSpace(10)
                    pdf.addText("Starting date : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Starting_date"] as! String)", font: .systemFont(ofSize: 20))
                    // spacer
                    pdf.addLineSpace(10)
                    pdf.addText("Work type : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Work_type"] as! String)", font: .systemFont(ofSize: 20))
                    // spacer
                    pdf.addLineSpace(10)
                    pdf.addText("Description of work : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Description_of_work"] as! String)", font: .systemFont(ofSize: 20))
                    
                    
                    // -- check here for other charges *******
                    if (dict["otherChargesPriceTextField"] as! String).isEmpty {
                        pdf.addLineSpace(10)
                        pdf.addText("\(dict["otherChargesTxtField"] as! String) : " + "\(dict["otherChargesPriceTextField"] as! String)", font: .systemFont(ofSize: 20))
                    }
                    
                    // pdf.beginNewPage()
                    // spacer
                    pdf.addLineSpace(15)
                    pdf.addText("Number of workers required : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Number_of_workers_required"] as! String)", font: .systemFont(ofSize: 20))
                    // spacer
                    pdf.addLineSpace(15)
                    pdf.addText("Work order by : ".localizeString(string: dict["selectedLanguageFromToggle"] as! String) + "\(dict["Work_order_by"] as! String)", font: .systemFont(ofSize: 20))
                    
                    // spacer & // image
                    pdf.addLineSpace(15)
                    pdf.addText("Customer Signature: " , font: .systemFont(ofSize: 20))
                    pdf.addLineSpace(25)
                    pdf.addImage2(self.signatureImage.image ?? UIImage(), width: 350, height: 200)
                    pdf.addImage2(UIImage(named: "Bg")!, width: 0, height: 0)
                    
                    
                    
                    
                    //-*-*-*-*-*-*-*
                    
                    if (dict["mainServiceTextView"] as! String) == "" {
                        if (dict["mainServiceTxtField"] as! String).lowercased() == "left in service" {
                            pdf.addLineSpace(10)
                            pdf.addText("Fire sprinkler system left in service".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 20), textColor: .blue)
                        } else {
                            pdf.addText("Fire sprinkler system left off and out of service".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 20), textColor: .red)
                            pdf.addLineSpace(10)
                            pdf.addText("Any system that cannot be returned to active service in the same business day will require fire watch to be scheduled and provided by the building representative, maintenance company and or building owner. All CPVC systems that are cut into WILL be left off for a 24 hour period for proper glue cure time".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 20), textColor: .red)
                            pdf.addLineSpace(10)
                            pdf.addText("Description :".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 20), textColor: .black)
                            let descriptionTextImg = dict["descriptionTextImg"] as! UIImage//self.txtViewToImg(self.mainServiceTextView)
                            pdf.addImage(descriptionTextImg)
                            
                        }
                    } else {
                        pdf.addText("Fire sprinkler system left off and out of service".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 20), textColor: .red)
                        pdf.addLineSpace(10)
                        pdf.addText("Any system that cannot be returned to active service in the same business day will require fire watch to be scheduled and provided by the building representative, maintenance company and or building owner. All CPVC systems that are cut into WILL be left off for a 24 hour period for proper glue cure time".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 20), textColor: .red)
                        pdf.addLineSpace(10)
                        pdf.addText("Description :".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 20), textColor: .black)
                        let descriptionTextImg = dict["descriptionTextImg"] as! UIImage
                        pdf.addImage(descriptionTextImg)
                        
                    }
                    
                    
                    
                    //                pdf.addLineSpace(15)
                    //                pdf.addText("LABOR TOTAL : " + String(self.laborTotal), font: .boldSystemFont(ofSize: 20))
                    //                pdf.addLineSpace(15)
                    //
                    //
                    //                if self.otherChargesPriceTextField.text!.isEmpty {
                    //                    pdf.addText("OTHER CHARGES : 0", font: .boldSystemFont(ofSize: 20))
                    //                } else {
                    //                    pdf.addText("OTHER CHARGES : " + self.otherChargesPriceTextField.text!, font: .boldSystemFont(ofSize: 20))
                    //                }
                    //
                    //GROSS TOTAL
                    
                    //                var total = Int()
                    //                if self.otherChargesPriceTextField.text!.isEmpty {
                    //                    total = self.materialTotal + self.laborTotal
                    //                } else {
                    //                    total = self.materialTotal + self.laborTotal + Int(self.otherChargesPriceTextField.text!)!
                    //                }
                    
                    //                pdf.addLineSpace(15)
                    //                pdf.addText("GROSS TOTAL : $" + String(self.grossTotal), font: .boldSystemFont(ofSize: 20))
                    //                pdf.addLineSpace(10)
                    //                pdf.addText("( Detailed price structure is mentioned on next page )", font: .systemFont(ofSize: 15))
                    pdf.beginNewPage()
                    
                    // -- check here for added materials *******
                    
                    if (dict["materialArr_count"] as! Int) != 0 {
                        pdf.addLineSpace(20)
                        pdf.addText("Materials detail: ".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 20))
                        let materialTblImg =  dict["materialTblImg1"] as! UIImage //self.tableToImg(self.materialTableView)
                        pdf.addImage(materialTblImg)
                    }
                   
                    pdf.addLineSpace(50)
                    pdf.addText("            Time and Material Labor Rate Sheet".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .italicSystemFont(ofSize: 25))
                    pdf.addLineSpace(10)
                    pdf.addLineSeparator(height: 1)
                    pdf.addLineSpace(35)
                    pdf.addText("Emergency/Service Rates:".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .boldSystemFont(ofSize: 22))
                    // line
                    
                    pdf.addLineSpace(20)
                    pdf.addText("Straight Time (M-F 7:30AM-3:30PM):".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .boldSystemFont(ofSize: 20))
                    
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} 4-hour minimum each Technician".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} $120 per hour each.".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} Total: $960 (2T).".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} $85 flat rate for travel + material + tax".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} Anything over 4 hours is additional".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    
                    pdf.addLineSpace(20)
                    pdf.addText("Over Time (M-F 3:31PM - 7:29AM):".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .boldSystemFont(ofSize: 20))
                    
                    
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} 4-hour minimum each Technician".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} $180 per hour each".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} Total: $1,440.00 (2T)".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} $85 flat rate for travel + material + tax".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} Anything over 4 hours is additional".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    
                    
                    pdf.addLineSpace(20)
                    pdf.addText("Saturday (12:00AM - 11:59PM):".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .boldSystemFont(ofSize: 20))
                    
                    
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} 4-hour minimum each Technician".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} $180 per hour each".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} Total: $1,440.00 (2T)".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} $85 flat rate for travel + material + tax".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} Anything over 4 hours is additional".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    
                    
                    pdf.addLineSpace(20)
                    pdf.addText("Double Time (Sunday 12:01AM-11:59 PM):".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .boldSystemFont(ofSize: 20))
                    
                    
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} 4-hour minimum each Technician".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} $240 per hour each".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} Total: $1,920.00 (2T)".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} $85 flat rate for travel + material + tax".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{27A2} Anything over 4 hours is additional".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 18))
                    
                    pdf.addLineSpace(20)
                    pdf.addText("Notes:".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .boldSystemFont(ofSize: 20))
                    
                    
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{23FA} Emergency calls/inspections fall under overtime rates and must be COD.".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .boldSystemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{23FA} Any inspections or service/emergency calls attended but unable to gain access will incur a travel charge.".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .boldSystemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{23FA} Any changes or modifications to the work scope may result in adjustments to labor and material changes.".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .boldSystemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{23FA} In accordance with industry standards and for optimal safety and efficiency, our services consistently necessitate the presence of two technicians, ensuring thorough and precise execution under varying conditions.".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .boldSystemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{23FA} Anything over 4 hours is additional".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .boldSystemFont(ofSize: 18))
                    pdf.addLineSpace(5)
                    pdf.addText("     \u{23FA} All credit card payments are subject to 3% fee.".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .boldSystemFont(ofSize: 18))
                    
                    
                    
                    
//                    pdf.addLineSpace(5)
//                    pdf.addText("$165 per hr per man total is $1,320.00, $85 flat rate for travel, material, plus tax.".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 15))
//                    pdf.addLineSpace(5)
//                    pdf.addText("Anything over the 4 hrs is additional.".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 15))
//                    
//                    
//                    pdf.addLineSpace(20)
//                    pdf.addText("Double Time Sunday12:01AM-11:59 PMis 2 men 4 hr minimum.".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 15))
//                    pdf.addLineSpace(5)
//                    pdf.addText("$220 per hr each total is $1,760.00, $85 flat rate for travel, material, plus tax.", font: .systemFont(ofSize: 15))
//                    pdf.addLineSpace(5)
//                    pdf.addText("Anything over the 4 hrs is additional.".localizeString(string: dict["selectedLanguageFromToggle"] as! String), font: .systemFont(ofSize: 15))
                    
                    
                    
                    
                    
                    
                    // Generate PDF data and save to a local file.
                    if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
                        
                        let fileName = "invoice.pdf"
                        let documentsFileName = documentDirectories + "/" + fileName
                        let str:String = documentsFileName
                        let url:URL = URL(fileURLWithPath: str)
                        let pdfData = pdf.generatePDFdata()
                        do{
                            try pdfData.write(to: url , options: .atomic)
                            print("\nThe generated pdf can be found at:")
                            print(documentsFileName)
                            let VC = UIStoryboard(name: "WorkOrderView", bundle: nil).instantiateViewController(withIdentifier: "InvoiceViewerViewController") as! InvoiceViewerViewController
                            JobNameInstance.shared.jobName = self.jobNameTextField.text!
                            VC.jobId = jobId
                            self.reset()
                            self.navigationController?.pushViewController(VC, animated: true)
                            
                        }catch{
                            print(error)
                        }
                    }
                    
                    
                }
                //                {
                //                                    if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
                //
                //                                        let fileName = "invoice.pdf"
                //                                        let documentsFileName = documentDirectories + "/" + fileName
                //                                        let str:String = documentsFileName
                //                                        let url:URL = URL(fileURLWithPath: str)
                //                                        let pdfData = pdf.generatePDFdata()
                //                                        do{
                //                                            try pdfData.write(to: url , options: .atomic)
                //                                            print("\nThe generated pdf can be found at:")
                //                                            print(documentsFileName)
                //                                            let VC = UIStoryboard(name: "WorkOrderView", bundle: nil).instantiateViewController(withIdentifier: "InvoiceViewerViewController") as! InvoiceViewerViewController
                //                                            JobNameInstance.shared.jobName = self.jobNameTextField.text!
                //                                            VC.jobId = jobId
                //                                            self.navigationController?.pushViewController(VC, animated: true)
                //
                //                                        }catch{
                //                                            print(error)
                //                                        }
                //                                    }
                //                    print("----------pdf open screen ")
                //
                //                }
                
                
                
                
                
                
                //MARK: previous work
                // Generate PDF data and save to a local file.
                //                if let documentDirectories = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
                //
                //                    let fileName = "invoice.pdf"
                
                //                    let documentsFileName = documentDirectories + "/" + fileName
                //                    let str:String = documentsFileName
                //                    let url:URL = URL(fileURLWithPath: str)
                //                    let pdfData = pdf.generatePDFdata()
                //                    do{
                //                        try pdfData.write(to: url , options: .atomic)
                //                        print("\nThe generated pdf can be found at:")
                //                        print(documentsFileName)
                //                        let VC = UIStoryboard(name: "WorkOrderView", bundle: nil).instantiateViewController(withIdentifier: "InvoiceViewerViewController") as! InvoiceViewerViewController
                //                        JobNameInstance.shared.jobName = self.jobNameTextField.text!
                //                        VC.jobId = jobId
                //                        self.navigationController?.pushViewController(VC, animated: true)
                //
                //                    }catch{
                //                        print(error)
                //                    }
                //                }
                //MARK: Previous work
            }
            
            
            
            
        }
        
        //MARK: RESET BUTTON
        resetBtn.actionBlock {
            
            self.view.endEditing(true)
            
            let refreshAlert = UIAlertController(title: "Reset", message: "Are you sure you want to reset all fields".localizeString(string: self.selectedLanguageFromToggle), preferredStyle: UIAlertController.Style.alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Yes".localizeString(string: self.selectedLanguageFromToggle), style: .default, handler: { (action: UIAlertAction!) in
                
                self.reset()
                
            }))
            
            refreshAlert.addAction(UIAlertAction(title: "No".localizeString(string: self.selectedLanguageFromToggle), style: .cancel, handler: { (action: UIAlertAction!) in
                print("Cancelled")
            }))
            
            self.present(refreshAlert, animated: true, completion: nil)
            
        }
        
        //MARK: SIGNATURE
        addSignBtn.actionBlock {
            self.view.endEditing(true)
            self.signaturePopUpView.signaturePad.clear()
            self.viewTransition(self.signaturePopUpView)
        }
        
        //MARK: ADD SERVICE
        addServiceBtn.actionBlock {
            self.view.endEditing(true)
            self.serviceFields.forEach { txtField in
                txtField.text = ""
            }
            self.viewTransition(self.addServiceView)
            self.addServiceView.translatesAutoresizingMaskIntoConstraints = false
            var hyt = Double()
            if UIDevice.current.userInterfaceIdiom == .pad {
                hyt = 450
            } else {
                hyt = 245
            }
            self.customiseServicePopUpView(lblText: "", lblHeight: 0, txtViewHyt: 0, txtViewHideShow: true, mainViewHyt: hyt)
        }
    }
    
    func reset(){
        // clear user defaults
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
        
        let allTextField = self.getTextfield(view: self.view)
        for txtField in allTextField{
            txtField.text = ""
        }
        
        if self.materialArr.count != 0 {
            self.materialArr.removeAll()
            self.materialTableView.reloadData()
        }
        
        if self.laborArr.count != 0 {
            self.laborArr.removeAll()
            self.laborTableView.reloadData()
        }
        
        self.dayWorkCheckImage.image = #imageLiteral(resourceName: "check")
        self.contractWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
        self.extraWorkCheckImage.image = #imageLiteral(resourceName: "uncheck")
        self.workType = "day work"
        self.descriptionOfWorkTxtView.text = ""
        self.mainServiceTextView.text = ""
        
        self.materialTotal = 0
        self.laborTotal = 0
        self.otherTotal = 0
        self.showGrossTotal()
        
        self.signatureImage.image = UIImage()
        self.signatureImageHeight.constant = 0
        
        self.serviceViewHeight.constant = 0
        self.mainServiceView.isHidden = true
    }
    
    //MARK:- Validations
    func checkData() -> Bool {
        
        
        print("*******---------------------------------->>  ",selectedLanguageFromToggle)
        if (toTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "All fields are required".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (termsTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "All fields are required".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (orderTakenByTxtField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Add order taken by field".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (customersOrderNumberTxtField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter customer's order number".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (dateOfOrderTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter date of order".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (phoneTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Add phone number".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (jobNameTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter job name".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (jobLocationTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter job location".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (jobPhoneTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter job phone".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (startingDateTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter starting date".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (descriptionOfWorkTxtView.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter description of work".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        }
        /*
         else if materialArr.count == 0 {
         HUD.flash(.labeledError(title: "", subtitle: "Add materials"), delay: 1.0)
         }
         else if laborTotal == 0 {
         HUD.flash(.labeledError(title: "", subtitle: "Add labor"), delay: 1.0)
         }
         */
        else if (workOrderByTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter the work order by person name".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        }
        //         else if self.signatureImageHeight.constant == 0 {
        //            HUD.flash(.labeledError(title: "", subtitle: "Add Signature".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        //        }
        else if !self.phoneTextField.text!.validPhoneNumber {
            HUD.flash(.labeledError(title: "", subtitle: "Enter valid phone number".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        }
        else if !self.jobPhoneTextField.text!.validPhoneNumber {
            HUD.flash(.labeledError(title: "", subtitle: "Enter valid job phone number".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        }
        else if self.mainServiceTxtField.text!.isEmpty {
            HUD.flash(.labeledError(title: "", subtitle: "Add service details".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        }
        else {
            if checkOtherChargesData() {
                return true
            }
        }
        return false
    }
    
    func checkOtherChargesData() -> Bool {
        print("*******---------------------------------->>  ",selectedLanguageFromToggle)
        if !self.otherChargesPriceTextField.text!.isEmpty {
            if self.otherChargesTxtField.text!.isEmpty {
                HUD.flash(.labeledError(title: "", subtitle: "Enter other charges title".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
                return false
            }
        }
        else if !self.otherChargesTxtField.text!.isEmpty {
            if self.otherChargesPriceTextField.text!.isEmpty {
                HUD.flash(.labeledError(title: "", subtitle: "Enter other charges".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
                return false
            }
        } else {
            return true
        }
        return true
    }
    
    func checkMaterialPopUpData() -> Bool {
        print("*******---------------------------------->>  ",selectedLanguageFromToggle)
        if (addMaterialView.quantityTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter quantity".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (addMaterialView.materialTxtField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter materials".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        }
        //        else if (addMaterialView.priceTxtField.text?.isEmpty)! {
        //            HUD.flash(.labeledError(title: "", subtitle: "Enter price"), delay: 1.0)
        //        }
        else {
            return true
        }
        return false
    }
    
    func checkLaborPopUpData() -> Bool {
        print("*******---------------------------------->>  ",selectedLanguageFromToggle)
        if (addLaborView.hoursTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter hours".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (addLaborView.laborTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter labor".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else if (addLaborView.priceTextField.text?.isEmpty)! {
            HUD.flash(.labeledError(title: "", subtitle: "Enter price".localizeString(string: selectedLanguageFromToggle)), delay: 1.0)
        } else {
            return true
        }
        return false
    }
    
    func showGrossTotal() {
        print("*******---------------------------------->>  ",selectedLanguageFromToggle)
        
        print(self.workerCount)
        print(self.laborTotal)
        print(self.otherTotal)
        
        grossTotal = self.materialTotal + (workerCount * self.laborTotal) + otherTotal
        
        print(self.grossTotal)
        
        //self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
        //self.filledDataDict["grossTotal"] = grossTotal
        
        self.grossTotalAmount.text = "$" + String(grossTotal)
    }
    
    
    //MARK: POPUP__BUTTONS
    func setPopUpBtnActions() {
        print("*******---------------------------------->>  ",selectedLanguageFromToggle)
        
        // -- MATERIAL
        addMaterialView.addMaterialBtnView.actionBlock {
            if (self.addMaterialView.quantityTextField.text!.isEmpty ||
                self.addMaterialView.materialTxtField.text!.isEmpty ||
                self.addMaterialView.sizeTxtField.text!.isEmpty) {
                HUD.flash(.labeledError(title: "", subtitle: "All fields are required".localizeString(string: self.selectedLanguageFromToggle)), delay: 1.0)
            } else {
                
                if self.checkMaterialPopUpData() {
                    var tempDict            = [String:String]()
                    tempDict["quantity"]    = self.addMaterialView.quantityTextField.text!
                    tempDict["material"]    = self.addMaterialView.materialTxtField.text!
                    tempDict["size"]        = self.addMaterialView.sizeTxtField.text!
                    self.materialArr.append(tempDict)
                    self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
                    self.filledDataDict["materialArray"] = self.materialArr
                    UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
                    print("---***--->", self.filledDataDict)
                    self.removeView(self.addMaterialView)
                    self.materialTableView.reloadData()
                }
            }
        }
        
        // -- LABOR
        addLaborView.addLaborBtnView.actionBlock {
            if (self.addLaborView.hoursTextField.text!.isEmpty ||
                self.addLaborView.laborTextField.text!.isEmpty ||
                self.addLaborView.priceTextField.text!.isEmpty ||
                self.addLaborView.amountTextField.text!.isEmpty) {
                HUD.flash(.labeledError(title: "", subtitle: "All fields are required".localizeString(string: self.selectedLanguageFromToggle)), delay: 1.0)
            } else {
                if self.checkLaborPopUpData() {
                    var tempDict            = [String:String]()
                    tempDict["hours"]       = self.addLaborView.hoursTextField.text!
                    tempDict["labor"]       = self.addLaborView.laborTextField.text!
                    tempDict["laborPrice"]  = self.addLaborView.priceTextField.text!
                    tempDict["laborAmount"] = self.addLaborView.amountTextField.text!
                    
                    // -- add here
                    self.laborArr.append(tempDict)
                    self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
                    self.filledDataDict["laborArray"] = self.laborArr
                    UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
                    print("---***--->", self.filledDataDict)
                    self.removeView(self.addLaborView)
                    self.laborTableView.reloadData()
                }
            }
        }
        
        // -- SIGNATURE
        signaturePopUpView.addSignBtn.actionBlock {
            if self.signaturePopUpView.signaturePad.lines.count == 0 {
                HUD.flash(.labeledError(title: "", subtitle: "Please add signature".localizeString(string: self.selectedLanguageFromToggle)), delay: 1.0)
            }
            else {
                self.removeView(self.signaturePopUpView)
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                    let signImg : UIImage = self.convertViewToImage(view: self.signaturePopUpView.signaturePad)!
                    self.signatureImage.image = signImg
                    print ("" ,signImg)
                    self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
                    
                    self.filledDataDict["signatureImage"] = self.signatureImage.image!.jpegData(compressionQuality: 1.0)
                    print(self.signatureImage.image!.jpegData(compressionQuality: 1.0))
                    UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        self.signatureImageHeight.constant = 380
                    } else {
                        self.signatureImageHeight.constant = 200
                    }
                }
            }
        }
        signaturePopUpView.clearSignBtn.actionBlock {
            self.signaturePopUpView.signaturePad.clear()
        }
        
        // -- SERVICE
        addServiceView.addServiceBtn.actionBlock {
            if self.addServiceView.addServiceTextField.text!.isEmpty {
                HUD.flash(.labeledError(title: "", subtitle: "Please add service".localizeString(string: self.selectedLanguageFromToggle)), delay: 1.0)
            } else {
                if self.addServiceView.addServiceTextField.text?.lowercased() == "left in service" {
                    self.mainServiceDescriptionView.isHidden = true
                    
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        self.serviceViewHeight.constant = 140
                    } else {
                        self.serviceViewHeight.constant = 70
                    }
                    
                    self.mainServiceDescriptionLbl.isHidden = true
                    self.mainServiceTextView.isHidden = true
                    self.mainServiceTxtField.text = self.addServiceView.addServiceTextField.text
                    
                    self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
                    self.filledDataDict["serviceType"] = "leftIn"
                    self.filledDataDict["mainServiceTxtField"] = self.mainServiceTxtField.text
                    UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
                    print("---***--->", self.filledDataDict)
                    
                    self.removeView(self.addServiceView)
                }
                else {
                    self.mainServiceDescriptionView.isHidden = false
                    if self.addServiceView.descriptionTextView.text!.isEmpty {
                        HUD.flash(.labeledError(title: "", subtitle: "Please add description".localizeString(string: self.selectedLanguageFromToggle)), delay: 1.0)
                    } else {
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            self.serviceViewHeight.constant = 350
                        } else {
                            self.serviceViewHeight.constant = 220
                        }
                        
                        self.mainServiceDescriptionLbl.isHidden = false
                        self.mainServiceTextView.isHidden = false
                        self.mainServiceTxtField.text = self.addServiceView.addServiceTextField.text
                        self.mainServiceTextView.text = self.addServiceView.descriptionTextView.text
                        
                        self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
                        self.filledDataDict["serviceType"] = "leftOut"
                        self.filledDataDict["mainServiceTxtField"] = self.mainServiceTxtField.text
                        self.filledDataDict["mainServiceTextView"] = self.mainServiceTextView.text
                        UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
                        print("---***--->", self.filledDataDict)
                        
                        self.removeView(self.addServiceView)
                        
                    }
                }
                
                self.mainServiceView.isHidden = false
                self.updateViewConstraints()
            }
            
            
        }
    }
    
}

//MARK: CUSTOM__METHODS
extension WorkOrderView {
    //------- Animate PopUp
    func viewTransition(_ addView: UIView) {
        UIView.transition(with: view, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.view.addSubview(addView)
            self.viewConstraints(addView)
        })
    }
    
    
    //------- Remove View From SuperView
    func removeView(_ viewToRemove: UIView) {
        DispatchQueue.main.async {
            UIView.transition(with: self.view, duration: 0.5, options: .transitionCrossDissolve, animations: {
                viewToRemove.removeFromSuperview()
            })
        }
    }
    
    //------- Set PopUp View Constraints
    func viewConstraints(_ View: UIView) {
        View.translatesAutoresizingMaskIntoConstraints = false
        View.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        View.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        View.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        View.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        View.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 1.0, constant: 0).isActive = true
    }
    
    func convertViewToImage(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
    
    func tableToImg(_ tblView : UITableView) -> UIImage {
        UIGraphicsBeginImageContext(tblView.frame.size)
        tblView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    
    func txtViewToImg(_ tblView : UITextView) -> UIImage {
        UIGraphicsBeginImageContext(tblView.frame.size)
        tblView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    // -- get all text fields from a view
    func getTextfield(view: UIView) -> [UITextField] {
        var results = [UITextField]()
        for subview in view.subviews as [UIView] {
            if let textField = subview as? UITextField {
                results += [textField]
            } else {
                results += getTextfield(view: subview)
            }
        }
        return results
    }
    
    func pushOnly( controllerId: String,  animation: Bool) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: controllerId)
        self.navigationController?.pushViewController(vc!, animated: animation)
    }
    
    func isValidMobileNo(phone:String) -> Bool {
        let PHONE_REGEX = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", PHONE_REGEX)
        return  phoneTest.evaluate(with: phone)
    }
    
    func customiseServicePopUpView(lblText : String, lblHeight : Double, txtViewHyt : Double, txtViewHideShow : Bool, mainViewHyt: Double) {
        self.addServiceView.descriptionLbl.text = lblText
        self.addServiceView.descriptionLblHeight.constant = lblHeight
        self.addServiceView.descriptionTextView.text = ""
        self.addServiceView.descriptionTextView.isHidden = txtViewHideShow
        self.addServiceView.viewHeight.constant = mainViewHyt
        
        
        self.addServiceView.descriptionTextViewHeight.constant = txtViewHyt
        
        //        self.addServiceView.descriptionTextViewHeight = self.addServiceView.descriptionTextView.heightAnchor.constraint(equalToConstant: txtViewHyt)
        //        self.addServiceView.descriptionTextViewHeight.isActive = true
    }
}

//MARK: TABLE__VIEW__DELEGATES
extension WorkOrderView : UITableViewDelegate, UITableViewDataSource {
    
    //-------------------------------------
    //              Table tags
    //          100 -> material table view
    //          200 -> labor table view
    //-------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 100 {
            return materialArr.count
        } else {
            return laborArr.count
        }
    }
    
    // -- DETAIL CELL
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTableCell") as! DetailTableCell
        if tableView.tag == 100 {
            cell.quantityTxtField.text = self.materialArr[indexPath.row]["quantity"]
            cell.materialTextField.text = self.materialArr[indexPath.row]["material"]
            cell.amountTextField.text = self.materialArr[indexPath.row]["size"]
            cell.priceLblWidth.constant = 0
            //cell.amountTextField.text = self.materialArr[indexPath.row]["amount"]
        } else {
            cell.quantityTxtField.text = self.laborArr[indexPath.row]["hours"]
            cell.materialTextField.text = self.laborArr[indexPath.row]["labor"]
            cell.priceTextField.text = self.laborArr[indexPath.row]["laborPrice"]
            cell.amountTextField.text = self.laborArr[indexPath.row]["laborAmount"]
        }
        return cell
    }
    
    // -- HEADER CELL
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DetailHeaderCell") as! DetailHeaderCell
        if tableView.tag == 100 {
            headerView.backgroundColor = .black
            headerView.qtyLbl.text = "QTY"
            headerView.materialLbl.text = "MATERIAL"
            headerView.amountLbl.text = "SIZE"
            headerView.priceLblWidth.constant = 0
        } else {
            headerView.qtyLbl.text = "HRS"
            headerView.materialLbl.text = "LABOR"
            headerView.priceLbl.text = "RATE"
        }
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView.tag == 100 {
            if materialArr.count == 0 {
                return 0
            } else {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    return 80
                } else {
                    return 50
                }
            }
        } else {
            if laborArr.count == 0 {
                return 0
            } else {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    return 80
                } else {
                    return 50
                }
            }
        }
    }
    
    // -- FOOTER CELL
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "DetailFooterCell") as! DetailFooterCell
        
        if tableView.tag == 100 {
            //            var amountArr = [Int]()
            //            materialArr.forEach { materialDict in
            //                amountArr.append(Int(materialDict["amount"]!)!)
            //            }
            //            materialTotal = amountArr.sum()
            //            footerView.totalAmount.text = "$" + String(materialTotal)
        } else {
            var amountArr = [Int]()
            laborArr.forEach { laborDict in
                amountArr.append(Int(laborDict["laborAmount"]!)!)
            }
            laborTotal = amountArr.sum()
            footerView.totalAmount.text = "$" + String(laborTotal)
        }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView.tag == 100 {
            //            if materialArr.count == 0 {
            //                return 0
            //            } else {
            //                if UIDevice.current.userInterfaceIdiom == .pad {
            //                    return 100
            //                } else {
            //                    return 60
            //                }
            //            }
        } else {
            if laborArr.count == 0 {
                return 0
            } else {
                if UIDevice.current.userInterfaceIdiom == .pad {
                    return 100
                } else {
                    return 60
                }
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if tableView.tag == 100 {
                //materialTotal = materialTotal - Int(materialArr[indexPath.row]["amount"]!)!
                
                
                materialArr.remove(at: indexPath.row)
                
                self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
                
                self.filledDataDict["materialArray"] = materialArr
                
                UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
                
                materialTableView.deleteRows(at: [indexPath], with: .fade)
                materialTableView.reloadData()
            } else {
                laborTotal = laborTotal - Int(laborArr[indexPath.row]["laborAmount"]!)!
                laborArr.remove(at: indexPath.row)
                
                self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
                
                self.filledDataDict["laborArray"] = laborArr
                
                UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
                
                laborTableView.deleteRows(at: [indexPath], with: .fade)
                laborTableView.reloadData()
            }
            
        }
    }
}

//MARK: TEXT__FIELD__DELEGATES
extension WorkOrderView : UITextFieldDelegate {
    
    /*
     tag :
     506 -> Add material pop up :  material text field
     521 -> Add material pop up :  size text field
     531 -> Add service pop up : service text field
     
     501 -> Add labor pop up : amount text field
     511 -> Add labor pop up : hours text field
     512 -> Add labor pop up : labor text field
     513 -> Add labor pop up : price/rate text field
     
     502 -> Date of order
     503 -> Starting date
     504 -> other charges price text field
     */
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.tag == 512 {
            pickerType = "SelectLabor"
            //pickerData = ["Regular", "O.T", "Double", "Prevailing"]
            pickerData = ["Regular", "Overtime", "Double time", "NY Prevailing"]
            handlePickerData()
        } else if textField.tag == 506 {
            pickerType = "SelectMaterial"
            pickerData = ["CPVC Pipe", "Steel Pipe", "CPVC Fitting", "Steel Fitting", "S.R. Head", "CON. Head", "Dry Head", "Valves"]
            handlePickerData()
        } else if textField.tag == 521 {
            pickerType = "SelectSize"
            pickerData = ["0.5in", "0.75in", "1in", "1.25in", "1.50in", "2in", "2.5in", "3in", "4in", "6in", "8in"]
            handlePickerData()
        } else if textField.tag == 531 {
            pickerType = "SelectService"
            pickerData = ["Left in service", "Left off and out of service"]
            handlePickerData()
        }
        
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        switch textField {
        case dateOfOrderTextField:
            updateFilledDict(keyName: "dateOfOrderTextField", textField: textField)
        case startingDateTextField:
            updateFilledDict(keyName: "startingDateTextField", textField: textField)
        default:
            break
        }
    }
    
    func updateDictWithKey(keyName : String, textField: UITextField, range: NSRange, string: String) {
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            
            
            print(txtAfterUpdate)
            
            filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
            filledDataDict[keyName] = txtAfterUpdate
            UserDefaults.standard.set(filledDataDict, forKey: "filledDataDict")
            print("*-*-*>",filledDataDict)
            
            
            if textField == numberOfWorkers {
                self.workerCount = Int(txtAfterUpdate ?? "1") ?? 1
                self.showGrossTotal()
            }
        }
    }
    
    func updateFilledDict(keyName : String, textField: UITextField) {
        if let text = textField.text as NSString? {
            filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
            filledDataDict[keyName] = text
            UserDefaults.standard.set(filledDataDict, forKey: "filledDataDict")
            print("*-*-*>",filledDataDict)
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        switch textField {
        case toTextField:
            updateDictWithKey(keyName: "toTextField", textField: textField, range: range, string: string)
        case termsTextField:
            updateDictWithKey(keyName: "termsTextField", textField: textField, range: range, string: string)
        case orderTakenByTxtField:
            updateDictWithKey(keyName: "orderTakenByTxtField", textField: textField, range: range, string: string)
        case customersOrderNumberTxtField:
            updateDictWithKey(keyName: "customersOrderNumberTxtField", textField: textField, range: range, string: string)
        case phoneTextField:
            updateDictWithKey(keyName: "phoneTextField", textField: textField, range: range, string: string)
        case jobNameTextField:
            updateDictWithKey(keyName: "jobNameTextField", textField: textField, range: range, string: string)
        case jobLocationTextField:
            updateDictWithKey(keyName: "jobLocationTextField", textField: textField, range: range, string: string)
        case jobPhoneTextField:
            updateDictWithKey(keyName: "jobPhoneTextField", textField: textField, range: range, string: string)
        case otherChargesTxtField:
            updateDictWithKey(keyName: "otherChargesTxtField", textField: textField, range: range, string: string)
        case otherChargesPriceTextField:
            updateDictWithKey(keyName: "otherChargesPriceTextField", textField: textField, range: range, string: string)
        case numberOfWorkers:
            updateDictWithKey(keyName: "numberOfWorkers", textField: textField, range: range, string: string)
        case workOrderByTextField:
            updateDictWithKey(keyName: "workOrderByTextField", textField: textField, range: range, string: string)
        default:
            break
        }
        
        if (textField.tag == 501) || (textField.tag == 502) || (textField.tag == 503)  || (textField.tag == 512) || (textField.tag == 513) || (textField.tag == 531){
            return false
        }
        else if textField.tag == 511 {
            if let text = textField.text as NSString? {
                let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                if self.addLaborView.priceTextField.text != "" {
                    let qty = (txtAfterUpdate as NSString).doubleValue
                    let price = (self.addLaborView.priceTextField.text! as NSString).doubleValue
                    let amount = qty * price
                    self.addLaborView.amountTextField.text = String(format: "%.0f", amount)
                }
            }
            return true
        }
        
        else if textField.tag == 504 {
            if let text = textField.text as NSString? {
                let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
                print("3 -->",txtAfterUpdate)
                otherTotal = Int(txtAfterUpdate) ?? 0
                self.showGrossTotal()
            }
            return true
        } else {
            return true
        }
    }
    
}

extension Sequence where Element: AdditiveArithmetic {
    func sum() -> Element { reduce(.zero, +) }
}

//MARK: PICKER__VIEW
extension WorkOrderView : UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerType == "SelectLabor" {
            
            self.addLaborView.laborTextField.text = self.pickerData[row]
            
            /*
             if self.addLaborView.laborTextField.text == "Regular" {
             self.addLaborView.priceTextField.text = "105"
             } else if self.addLaborView.laborTextField.text == "O.T" {
             self.addLaborView.priceTextField.text = "157.50"
             } else if self.addLaborView.laborTextField.text == "Double" {
             self.addLaborView.priceTextField.text = "210"
             } else if self.addLaborView.laborTextField.text == "Prevailing" {
             self.addLaborView.priceTextField.text = "215"
             } else if self.pickerData[row] == "Regular" {
             self.addLaborView.priceTextField.text = "105"
             }
             */
            
            
            if self.addLaborView.laborTextField.text == "Regular" {
                //self.addLaborView.priceTextField.text = "105"
                self.addLaborView.priceTextField.text = "109"
            } else if self.addLaborView.laborTextField.text == "Overtime" {
                //self.addLaborView.priceTextField.text = "157.50"
                self.addLaborView.priceTextField.text = "163.50"
            } else if self.addLaborView.laborTextField.text == "Double time" {
                //self.addLaborView.priceTextField.text = "210"
                self.addLaborView.priceTextField.text = "218"
            } else if self.addLaborView.laborTextField.text == "NY Prevailing" {
                //self.addLaborView.priceTextField.text = "215"
                self.addLaborView.priceTextField.text = "117.23"
            } else if self.pickerData[row] == "Regular" {
                self.addLaborView.priceTextField.text = "109"
            }
            
            let qty = (self.addLaborView.hoursTextField.text! as NSString).doubleValue
            let price = (self.addLaborView.priceTextField.text! as NSString).doubleValue
            let amount = qty * price
            self.addLaborView.amountTextField.text = String(format: "%.0f", amount)
            
        }
        else if pickerType == "SelectMaterial" {
            self.addMaterialView.materialTxtField.text = self.pickerData[row]
        }
        else if pickerType == "SelectSize" {
            self.addMaterialView.sizeTxtField.text = self.pickerData[row]
        }
        else if pickerType == "SelectService" {
            
            self.addServiceView.addServiceTextField.text = self.pickerData[row]
            self.addServiceView.translatesAutoresizingMaskIntoConstraints = false
            
            if self.pickerData[row] == self.pickerData[1] {
                var hyt = Double()
                var txtViewHyt = Double()
                var lblHeight = Double()
                
                if UIDevice.current.userInterfaceIdiom == .pad {
                    hyt = 650
                    txtViewHyt = 120
                    lblHeight = 50
                } else {
                    hyt = 350
                    txtViewHyt = 60
                    lblHeight = 25
                }
                
                self.customiseServicePopUpView(lblText: "Description", lblHeight: lblHeight, txtViewHyt: txtViewHyt, txtViewHideShow: false, mainViewHyt: hyt)
            } else {
                var hyt = Double()
                if UIDevice.current.userInterfaceIdiom == .pad {
                    hyt = 450
                } else {
                    hyt = 245
                }
                self.customiseServicePopUpView(lblText: "", lblHeight: 0, txtViewHyt: 0, txtViewHideShow: true, mainViewHyt: hyt)
            }
        }
    }
    
}

extension WorkOrderView: ToolbarPickerViewDelegate {
    
    func didTapDone() {
        if pickerType == "SelectLabor" {
            let row = self.dataPickerView.selectedRow(inComponent: 0)
            self.dataPickerView.selectRow(row, inComponent: 0, animated: false)
            
            
            
            /*
             if self.addLaborView.laborTextField.text == "Regular" {
             self.addLaborView.priceTextField.text = "105"
             } else if self.addLaborView.laborTextField.text == "O.T" {
             self.addLaborView.priceTextField.text = "157.50"
             } else if self.addLaborView.laborTextField.text == "Double" {
             self.addLaborView.priceTextField.text = "210"
             } else if self.addLaborView.laborTextField.text == "Prevailing" {
             self.addLaborView.priceTextField.text = "215"
             } else if self.pickerData[row] == "Regular" {
             self.addLaborView.priceTextField.text = "105"
             }
             */
            
            
            if self.addLaborView.laborTextField.text == "Regular" {
                //self.addLaborView.priceTextField.text = "105"
                self.addLaborView.priceTextField.text = "109"
            } else if self.addLaborView.laborTextField.text == "Overtime" {
                //self.addLaborView.priceTextField.text = "157.50"
                self.addLaborView.priceTextField.text = "163.50"
            } else if self.addLaborView.laborTextField.text == "Double time" {
                //self.addLaborView.priceTextField.text = "210"
                self.addLaborView.priceTextField.text = "218"
            } else if self.addLaborView.laborTextField.text == "NY Prevailing" {
                //self.addLaborView.priceTextField.text = "215"
                self.addLaborView.priceTextField.text = "117.23"
            } else if self.pickerData[row] == "Regular" {
                self.addLaborView.priceTextField.text = "109"
            }
            
            self.addLaborView.laborTextField.text = self.pickerData[row]
            let qty = (self.addLaborView.hoursTextField.text! as NSString).doubleValue
            let price = (self.addLaborView.priceTextField.text! as NSString).doubleValue
            let amount = qty * price
            self.addLaborView.amountTextField.text = String(format: "%.0f", amount)
            self.addLaborView.laborTextField.resignFirstResponder()
            self.dataPickerView.reloadAllComponents()
        } else if pickerType == "SelectMaterial" {
            let row = self.dataPickerView.selectedRow(inComponent: 0)
            self.dataPickerView.selectRow(row, inComponent: 0, animated: false)
            self.addMaterialView.materialTxtField.text = self.pickerData[row]
            self.addMaterialView.materialTxtField.resignFirstResponder()
            self.dataPickerView.reloadAllComponents()
        } else if pickerType == "SelectSize" {
            let row = self.dataPickerView.selectedRow(inComponent: 0)
            self.dataPickerView.selectRow(row, inComponent: 0, animated: false)
            self.addMaterialView.sizeTxtField.text = self.pickerData[row]
            self.addMaterialView.sizeTxtField.resignFirstResponder()
            self.dataPickerView.reloadAllComponents()
        } else if pickerType == "SelectService" {
            let row = self.dataPickerView.selectedRow(inComponent: 0)
            self.dataPickerView.selectRow(row, inComponent: 0, animated: false)
            self.addServiceView.addServiceTextField.text = self.pickerData[row]
            self.addServiceView.addServiceTextField.resignFirstResponder()
            self.dataPickerView.reloadAllComponents()
        }
        self.dataPickerView.selectRow(0, inComponent: 0, animated: true)
        self.dataPickerView.reloadAllComponents()
    }
    
    func didTapCancel() {
        if pickerType == "SelectLabor" {
            self.addLaborView.laborTextField.resignFirstResponder()
        } else if pickerType == "SelectMaterial" {
            self.addMaterialView.materialTxtField.resignFirstResponder()
        } else if pickerType == "SelectSize" {
            self.addMaterialView.sizeTxtField.resignFirstResponder()
        } else if pickerType == "SelectService" {
            self.addServiceView.addServiceTextField.resignFirstResponder()
        }
    }
}

//MARK: TEXT_VIEW_DELEGATE
extension WorkOrderView : UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if textView == self.descriptionOfWorkTxtView {
            
            let txt = (textView.text as NSString).replacingCharacters(in: range, with: text)
            
            filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
            filledDataDict["descriptionOfWorkTxtView"] = txt
            UserDefaults.standard.set(filledDataDict, forKey: "filledDataDict")
            
        }
        
        return true
    }
}

// MARK: - LOCAL STORE HELPER
extension UserDefaults {
    func imageForKey(key: String) -> UIImage? {
        var image: UIImage?
        if let imageData = data(forKey: key) {
            image = NSKeyedUnarchiver.unarchiveObject(with: imageData) as? UIImage
        }
        return image
    }
    func setImage(image: UIImage?, forKey key: String) {
        var imageData: NSData?
        if let image = image {
            imageData = NSKeyedArchiver.archivedData(withRootObject: image) as NSData?
        }
        set(imageData, forKey: key)
    }
}

// MARK: - LANUGAGE TOGGLE
extension WorkOrderView {
    func toggleLanguageSegment(_ selectedLanguage : String) {
        /// -------------- VIEW TEXTS
        welcomeTextLabel.text = "Welcome".localizeString(string: selectedLanguage)
        resetTextLabel.text = "RESET".localizeString(string: selectedLanguage)
        toTextLabel.text = "To".localizeString(string: selectedLanguage)
        termsTextLabel.text = "Terms".localizeString(string: selectedLanguage)
        jobInvoiceTextLabel.text = "JOB INVOICE".localizeString(string: selectedLanguage)
        orderTakenByTextLabel.text = "Order taken by".localizeString(string: selectedLanguage)
        customerOrderNumberTextLabel.text = "Customer order number".localizeString(string: selectedLanguage)
        dateOfOrderTextLabel.text = "Date of order".localizeString(string: selectedLanguage)
        phoneTextLabel.text = "Phone".localizeString(string: selectedLanguage)
        jobNameTextLabel.text = "Job (Name / Number)".localizeString(string: selectedLanguage)
        jobLocationTextLabel.text = "Job location".localizeString(string: selectedLanguage)
        jobPhoneTextLabel.text = "Job phone".localizeString(string: selectedLanguage)
        startingDateTextLabel.text = "Starting date".localizeString(string: selectedLanguage)
        dayWorkTextLabel.text = "Day work".localizeString(string: selectedLanguage)
        contractTextLabel.text = "Contract".localizeString(string: selectedLanguage)
        extraTextLabel.text = "Extra".localizeString(string: selectedLanguage)
        descriptionOfWorkTextLabel.text = "DESCRIPTION OF WORK".localizeString(string: selectedLanguage)
        otherChargesTextLabel.text = "OTHER CHARGES".localizeString(string: selectedLanguage)
        totalMaterialTextLabel.text = "TOTAL MATERIALS".localizeString(string: selectedLanguage)
        addMaterialTextLabel.text = "Add Material".localizeString(string: selectedLanguage)
        numberOfWorkerTextLabel.text = "Number of workers".localizeString(string: selectedLanguage)
        grossTotalTextLabel.text = "GROSS TOTAL".localizeString(string: selectedLanguage)
        priceIncludeOtherChargesTextLabel.text = "Price include other charges".localizeString(string: selectedLanguage)
        serviceTextLabel.text = "SERVICE".localizeString(string: selectedLanguage)
        fireSprinklerTextLabel.text = "Fire sprinkler system".localizeString(string: selectedLanguage)
        descriptionTextLabel.text = "Description".localizeString(string: selectedLanguage)
        addServiceTextLabel.text = "Add Service".localizeString(string: selectedLanguage)
        signatureTextLabel.text = "Signature".localizeString(string: selectedLanguage)
        workOrderByTextLabel.text = "Work order by".localizeString(string: selectedLanguage)
        signatureTextLabel2.text = "Signature".localizeString(string: selectedLanguage)
        addSignTextLabel.text = "Add Sign".localizeString(string: selectedLanguage)
        submitTextLabel.text = "SUBMIT".localizeString(string: selectedLanguage)
        
        /// -------------- MATERIAL POPUP
        addMaterialView.addMaterialTextLabel.text = "Add Material".localizeString(string: selectedLanguage)
        addMaterialView.quantityTextLabel.text = "Quantity".localizeString(string: selectedLanguage)
        addMaterialView.materialTextLabel.text = "Material".localizeString(string: selectedLanguage)
        addMaterialView.sizeTextLabel.text = "Size".localizeString(string: selectedLanguage)
        addMaterialView.addTextLabel.text = "Add".localizeString(string: selectedLanguage)
        
        /// -------------- SERVICE POPUP
        addServiceView.serviceTextLabel.text = "SERVICE".localizeString(string: selectedLanguage)
        addServiceView.fireSprinklerTextLabel.text = "Fire sprinkler system".localizeString(string: selectedLanguage)
        addServiceView.descriptionTextLabel.text = "Description".localizeString(string: selectedLanguage)
        addServiceView.addTextLabel.text = "Add".localizeString(string: selectedLanguage)
    }
}

extension String {
    func localizeString(string: String) -> String {
        let path = Bundle.main.path(forResource: string, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
    public var validPhoneNumber: Bool {
        let types: NSTextCheckingResult.CheckingType = [.phoneNumber]
        guard let detector = try? NSDataDetector(types: types.rawValue) else { return false }
        if let match = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count)).first?.phoneNumber {
            return match == self
        } else {
            return false
        }
    }
}

class JobNameInstance : NSObject {
    static let shared = JobNameInstance()
    var jobName = String()
}

extension UIViewController{
    
    //    func dateToLocal(date : Date) -> Date{
    //        let format = DateFormatter()
    //
    //        // 2) Set the current timezone to .current, or America/Chicago.
    //        format.timeZone = .current
    //
    //        // 3) Set the format of the altered date.
    //        format.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    //
    //        // 4) Set the current date, altered by timezone.
    //        let dateString = format.string(from: date)
    //
    //          dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
    //          dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    //          let date = dateFormatter.date(from:isoDate)!
    //
    //    }
}
