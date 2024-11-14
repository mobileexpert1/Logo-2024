//
//  buildingViewListVC.swift
//  Logo
//
//  Created by Vishal on 12/06/24.
//

import UIKit

class buildingViewListVC: UIViewController {
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var headerVw2: UIView!
    @IBOutlet weak var headerVw1: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var addSubjectBtn: UIImageView!
    
    @IBOutlet weak var baseVw: UIView!
    @IBOutlet weak var bgImgVw: UIImageView!
    
    //popup
    
    
     @IBOutlet weak var imag_Alpha: UIImageView!
     @IBOutlet weak var pop_Vw: UIView!
     
    
    
     @IBOutlet weak var org_Name: UITextField!
    
    //second Pop
   
    @IBOutlet weak var pop_Vw2: UIView!
    
   @IBOutlet weak var btnhide2: UIButton!
   
    @IBOutlet weak var txtfld_Billto: UITextField!
    @IBOutlet weak var txtfld_inspectionType: UITextField!
    @IBOutlet weak var txtfld_date: DatePickerField!
    @IBOutlet weak var txtfld_Time: DatePickerField!
     
    @IBOutlet weak var txtViewnotes: UITextView!
    @IBOutlet weak var search_Name: UISearchBar!
    var filteredNotesArr: [Building] = []
    var isSearching: Bool = false
    var notesArr : [Building] = []
   var addressLine = ""
    var nameorg = ""
    var BuildingNme = ""
    var selectedIndexPath = IndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()
       
        LoadData()
    }
    
    func LoadData(){
        search_Name.delegate = self
        self.pop_Vw.isHidden = true
        self.pop_Vw2.isHidden = true
        imag_Alpha.isHidden = true
        pop_Vw.layer.cornerRadius =  30
        pop_Vw2.layer.cornerRadius =  30
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.separatorStyle = .none
        txtfld_date.setSimpleDatePicker()
        txtfld_Time.setTimePicker()
        txtfld_inspectionType.delegate = self
        txtViewnotes.layer.borderColor = UIColor(red: 237/255, green: 237/255, blue: 237/255, alpha: 1.0).cgColor
               txtViewnotes.layer.borderWidth = 1.0
        txtViewnotes.layer.cornerRadius = 8.0
        
        txtViewnotes.text = "Notes"
        txtViewnotes.textColor = UIColor.lightGray; txtViewnotes.delegate = self
        BuildingViewListCell.registerTableCell(for: tblVw)
        backBtn.actionBlock {
            self.navigationController?.popViewController(animated: true)
        }
        
        addSubjectBtn.actionBlock {
            self.pop_Vw.isHidden = false
            self.imag_Alpha.isHidden = false
            self.imag_Alpha.isUserInteractionEnabled = true
            self.headerVw1.backgroundColor = .clear
            self.headerVw2.backgroundColor = .clear
          
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       
        ApiBuildingList()
    }
    func ApiBuildingList(){
        ApiFunc.shared.ViewBuildApi(self.view) { [self] responseModel in
            Indicator.sharedInstance.hideIndicator()
            let requestData = responseModel.data
            notesArr = requestData.buildings
           
            if responseModel.data.buildings.isEmpty {
                AlertControl.shared.showOnlyAlert("", message: "Data not found")
            }else{
               
            }
            tblVw.reloadData()
        }
    }
    
    @IBAction func btnHideAction(_ sender: Any) {
        self.pop_Vw.isHidden = true
        self.imag_Alpha.isHidden = true
        self.imag_Alpha.isUserInteractionEnabled = false
        self.headerVw1.backgroundColor = .none
        self.headerVw2.backgroundColor = .none
    }
    @IBAction func btnBuildAction(_ sender: Any) {
        
        if org_Name.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill Organization Name.")
            
        }else{
            
            ApiFunc.shared.BulidingAddApi(self.view, Name: org_Name.text ?? "") { responseModel in
                if responseModel.status == true {
                    self.pop_Vw.isHidden = true
                    self.imag_Alpha.isHidden = true
                    self.imag_Alpha.isUserInteractionEnabled = false
                    self.headerVw1.backgroundColor = .none
                    self.headerVw2.backgroundColor = .none
                    self.org_Name.text = nil
                    self.ApiBuildingList()
                }else{
                    if responseModel.message == "Building already exist" {
                        AlertControl.shared.showOnlyAlert("Poseidon", message: "Building already exist")
                    }else{
                        print("not Added Building")
                    }
                }
                
            }
            
        }
    }

    
    @IBAction func btnSave(_ sender: Any) {
        if txtfld_Billto.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill Bill to.")
        }else if txtfld_inspectionType.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill inspection Type.")
            
        }else if txtfld_date.text == ""{
            showOnlyAlert("Poseidon", message: "Please fill date.")
            
        }else if txtfld_Time.text == ""{
            showOnlyAlert("Poseidon", message: "Please fill Time.")
        }else if txtViewnotes.text == ""{
            showOnlyAlert("Poseidon", message: "Please fill notes.")
            
        }else{
            ApiFunc.shared.addRequestSystemApi(self.view, billTo: txtfld_Billto.text ?? "", assignDate: txtfld_date.text ?? "", assignTime: txtfld_Time.text ?? "", inspectionType: txtfld_inspectionType.text ?? "", notes: txtViewnotes.text ?? "") { responseModel in
                if responseModel.status == true {
                    self.executHome()
                }else{
                    if responseModel.message == "" {
                        
                    }
                }
            }
            
        }
    }
    func executHome() {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "Dashboard_Nav")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    
    }
    @IBAction func btnHide2(_ sender: Any) {
        self.pop_Vw2.isHidden = true
        self.imag_Alpha.isHidden = true
        self.imag_Alpha.isUserInteractionEnabled = false
        txtfld_Billto.text = nil
        txtfld_date.text = nil
        txtfld_Time.text = nil
        txtViewnotes.text = nil
        txtfld_inspectionType.text = nil
    }
    
}
extension buildingViewListVC : UITableViewDelegate, UITableViewDataSource{
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return notesArr.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tblVw.dequeueReusableCell(withIdentifier: "BuildingViewListCell", for: indexPath) as! BuildingViewListCell
//        cell.selectionStyle = .none
//        tblVw.showsVerticalScrollIndicator = false
//        cell.baseView.backgroundColor = ThemeColor.lightThemeViewBGColor
//        cell.buildingListName.text =  notesArr[indexPath.row].name
//        view.setNeedsDisplay()
//        return cell
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredNotesArr.count
        } else {
            return notesArr.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tblVw.dequeueReusableCell(withIdentifier: "BuildingViewListCell", for: indexPath) as! BuildingViewListCell
               cell.selectionStyle = .none
               tblVw.showsVerticalScrollIndicator = false
               cell.baseView.backgroundColor = ThemeColor.lightThemeViewBGColor
        let building: Building
        if isSearching {
            building = filteredNotesArr[indexPath.row]
        } else {
            building = notesArr[indexPath.row]
        }
        cell.buildingListName.text =  building.name
               view.setNeedsDisplay()
               return cell
       

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SingleTon.shared.buildingId =  self.notesArr[indexPath.row].id
        
        BuildingNme = notesArr[indexPath.row].name
        AlertPopUp()
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func AlertPopUp() {
        let alert = UIAlertController(title: "Select", message: "Please Select an option", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Add Request", style: .default, handler: { (_) in
            print("add request tapped")
            self.pop_Vw2.isHidden = false
            self.imag_Alpha.isHidden = false
            self.imag_Alpha.isUserInteractionEnabled = true
        }))
        alert.addAction(UIAlertAction(title: "System Management", style: .default, handler: { [self] (_) in
            print("cancel request tapped")
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SystemManagmentVC") as! SystemManagmentVC
            VC.addressLine = self.addressLine
            VC.nameorg = nameorg
            VC.selectedIndexPath = selectedIndexPath
            VC.BuildingNme = BuildingNme
                   self.navigationController?.pushViewController(VC, animated: true)
           // self.dismiss(animated: true)
        }))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }
}
extension buildingViewListVC:  UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        txtfld_inspectionType.loadDropdownData2(data: ["1st Quarterly", "2nd Quarterly",  "3rd Quarterly", "Quarterly" ,"Semi-Annuall" ,"Annual" ,"Standpipe", "Dry Valve","Preaction","Dry Valve","Fire Extinguishers","5 Year","Annual Inspection/Extinguishers"])
        print("Text field did begin editing")
        
    }
    
    
}
extension buildingViewListVC: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
            // Check if the text is the placeholder text
            if textView.textColor == UIColor.lightGray {
                textView.text = ""
                textView.textColor = UIColor.black
            }
        }
        
        func textViewDidEndEditing(_ textView: UITextView) {
           
            if textView.text.isEmpty {
                textView.text = "Notes"
                textView.textColor = UIColor.lightGray
            }
        }
}
extension buildingViewListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNotesArr = notesArr.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        isSearching = !searchText.isEmpty
        tblVw.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filteredNotesArr.removeAll()
        isSearching = false
        tblVw.reloadData()
        searchBar.resignFirstResponder()
    }
}
