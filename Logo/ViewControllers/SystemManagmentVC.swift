//
//  SystemManagmentVC.swift
//  Logo
//
//  Created by Vishal on 13/06/24.
//

import UIKit

class SystemManagmentVC: UIViewController {
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var headerVw2: UIView!
    @IBOutlet weak var headerVw1: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var addSubjectBtn: UIImageView!
    
    @IBOutlet weak var baseVw: UIView!
    @IBOutlet weak var bgImgVw: UIImageView!
  
    @IBOutlet weak var imag_Alpha: UIImageView!
    @IBOutlet weak var pop_Vw: UIView!
    @IBOutlet weak var search_Name: UISearchBar!
    @IBOutlet weak var btnhide: UIButton!
    
    @IBOutlet weak var txtfld_SystemId: UITextField!
    @IBOutlet weak var txtfld_SystemName: UITextField!
    @IBOutlet weak var txtfld_SystemLocation: UITextField!
    var profileImg : UIImage = UIImage(named: "user")!
    var filteredNotesArr: [SystemLocation] = []
    var notesArr : [SystemLocation] = []
    var addressLine = ""
    var nameorg = ""
    var BuildingNme = ""
    var isSearching: Bool = false
    var selectedIndexPath = IndexPath()
    //var systemNames = ["Fire pump", "Extinguishers",  "Fire Hydrants", "Flow Test" ,"Tanks" ,"Wet System" ,"Dry Systen", "Anti- Freeze"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print ("mutidata---->" , addressLine + nameorg + BuildingNme  )
        LoadData()
    }
    func LoadData(){
        search_Name.delegate = self
        self.pop_Vw.isHidden = true
        imag_Alpha.isHidden = true
        let multiData = "\(nameorg) \(selectedIndexPath.row + 1) \(BuildingNme) "
        txtfld_SystemId.isUserInteractionEnabled = false
        txtfld_SystemId.text = multiData
        pop_Vw.layer.cornerRadius =  30
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.separatorStyle = .none
        txtfld_SystemName.delegate = self
        
        SystemManagmentTVC.registerTableCell(for: tblVw)
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
        
        btnhide.actionBlock { [self] in
            self.pop_Vw.isHidden = true
            self.imag_Alpha.isHidden = true
            self.imag_Alpha.isUserInteractionEnabled = false
            self.headerVw1.backgroundColor = .none;
            self.headerVw2.backgroundColor = .none
            txtfld_SystemName.text = ""
        }
        
    }
    
    @IBAction func btnSubmitPopup(_ sender: Any) {
        
        if txtfld_SystemId.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill System Id.")
        }else if txtfld_SystemName.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill System Name.")
            
        }else if txtfld_SystemLocation.text == ""{
            showOnlyAlert("Poseidon", message: "Please fill System Location.")
            
            
        }else{
            ApiFunc.shared.AddNewSystemIdApi(self.view, systemId: txtfld_SystemId.text ?? "", systemDescription: txtfld_SystemLocation.text ?? "", assignedQuestion: "\(systemNameSelectedId ?? 0)") { responseModel in
                if responseModel.status == true {
                    self.pop_Vw.isHidden = true
                    self.imag_Alpha.isHidden = true
                    self.imag_Alpha.isUserInteractionEnabled = false
                    self.headerVw1.backgroundColor = .none
                    self.headerVw2.backgroundColor = .none
                    // self.txtfld_SystemId.text = nil
                    self.txtfld_SystemLocation.text = nil
                    self.txtfld_SystemName.text = nil
                    self.ApiSystemManagemetList()
                }else{
                    if responseModel.message == "Building already exist" {
                        AlertControl.shared.showOnlyAlert("Poseidon", message: "Building already exist")
                    }else{
                        print("Not Added Building")
                    }
                }
            }
            
        }
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        
        ApiSystemManagemetList()
    }
    func ApiSystemManagemetList(){
        ApiFunc.shared.SystemManagementApi(self.view) { [self] responseModel in
            Indicator.sharedInstance.hideIndicator()
            let requestData = responseModel.data
            notesArr = requestData.systemLocation
            
            if responseModel.data.systemLocation.isEmpty {
                AlertControl.shared.showOnlyAlert("", message: "Data not found")
            }else{
                
            }
            tblVw.reloadData()
        }
    }
    
}
extension SystemManagmentVC : UITableViewDelegate, UITableViewDataSource{
    
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return notesArr.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tblVw.dequeueReusableCell(withIdentifier: "SystemManagmentTVC", for: indexPath) as! SystemManagmentTVC
//        cell.selectionStyle = .none
//        tblVw.showsVerticalScrollIndicator = false
//        cell.Base_View.backgroundColor = ThemeColor.lightThemeViewBGColor
//        cell.lbl_SystemID.text =  notesArr[indexPath.row].systemID
//        cell.lbl_SystemName.text = notesArr[indexPath.row].sectionName
//        cell.lbl_SystemLocation.text = notesArr[indexPath.row].systemDescription
//        
//        
//        
//        
//        
//        view.setNeedsDisplay()
//        
//        
//        
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
        let cell = tblVw.dequeueReusableCell(withIdentifier: "SystemManagmentTVC", for: indexPath) as! SystemManagmentTVC
                cell.selectionStyle = .none
                tblVw.showsVerticalScrollIndicator = false
                cell.Base_View.backgroundColor = ThemeColor.lightThemeViewBGColor
        let systemLocation: SystemLocation
        if isSearching {
            systemLocation = filteredNotesArr[indexPath.row]
        } else {
            systemLocation = notesArr[indexPath.row]
        }
        cell.lbl_SystemID.text =  systemLocation.systemID
             cell.lbl_SystemName.text = systemLocation.sectionName
             cell.lbl_SystemLocation.text = systemLocation.systemDescription
        view.setNeedsDisplay()
        
        
        
                return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}
extension SystemManagmentVC:  UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        txtfld_SystemName.loadDropdownData2(data: ["Fire pump", "Extinguishers",  "Fire Hydrants", "Flow Test" ,"Tanks" ,"Wet System" ,"Dry Systen", "Anti- Freeze" ,"Standpipe" , "Sprinkler Heads"])
        print("Text field did begin editing")
        
    }
    
    
}
extension SystemManagmentVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNotesArr = notesArr.filter { $0.sectionName.lowercased().contains(searchText.lowercased()) }
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
