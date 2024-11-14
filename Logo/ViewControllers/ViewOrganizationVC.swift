//
//  ViewOrganizationVC.swift
//  Logo
//
//  Created by Vishal on 12/06/24.
//

import UIKit

class ViewOrganizationVC: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var headerVw2: UIView!
    @IBOutlet weak var headerVw1: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var addSubjectBtn: UIImageView!
    
    @IBOutlet weak var baseVw: UIView!
    @IBOutlet weak var bgImgVw: UIImageView!
    
    var nameorg = ""
    //popup
    
    
    @IBOutlet weak var imag_Alpha: UIImageView!
    @IBOutlet weak var pop_Vw: UIView!
    @IBOutlet weak var search_Name: UISearchBar!
    @IBOutlet weak var btnhide: UIButton!
    
    @IBOutlet weak var txtfld_Address: UITextField!
    @IBOutlet weak var txtfld_PostalCode: UITextField!
    @IBOutlet weak var txtfld_State: UITextField!
    @IBOutlet weak var txtfld_City: UITextField!
    var profileImg : UIImage = UIImage(named: "user")!
    var filteredNotesArr: [Address] = []
    var isSearching: Bool = false
    var notesArr : [Address] = []
    var selectedIndexPath = IndexPath()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LoadData()
        
        
    }
    
    func LoadData() {
        self.pop_Vw.isHidden = true
        imag_Alpha.isHidden = true
        search_Name.delegate = self
        pop_Vw.layer.cornerRadius =  30
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.separatorStyle = .none
        ViewOrganizationTVC.registerTableCell(for: tblVw)
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
        
        ViewAddressApi()
    }
    func ViewAddressApi() {
        ApiFunc.shared.ViewListApi(self.view) { [self] responseModel in
            Indicator.sharedInstance.hideIndicator()
            let requestData = responseModel.data
            notesArr = requestData.address
            
            if responseModel.data.address.isEmpty {
                AlertControl.shared.showOnlyAlert("", message: "Data not found")
            }else{
                
            }
            tblVw.reloadData()
        }
    }
    
    @IBAction func btnhide_Action(_ sender: Any) {
        self.pop_Vw.isHidden = true
        self.imag_Alpha.isHidden = true
        self.imag_Alpha.isUserInteractionEnabled = false
        self.headerVw1.backgroundColor = .none
        self.headerVw2.backgroundColor = .none
    }
    
    @IBAction func btnSubmit(_ sender: Any) {
        
        if txtfld_Address.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill Address.")
        }else if txtfld_State.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill State.")
            
        }else if txtfld_City.text == ""{
            showOnlyAlert("Poseidon", message: "Please fill City.")
            
        }else if txtfld_PostalCode.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill Postal Code.")
        }else{
            
            
            ApiFunc.shared.AddressAddApi(self.view, city: txtfld_City.text ?? "", state: txtfld_State.text ?? "", postalCode: txtfld_PostalCode.text ?? "", AddressLine: txtfld_Address.text ?? "") { [self] responseModel in
                if responseModel.status == true {
                    self.pop_Vw.isHidden = true
                    self.imag_Alpha.isHidden = true
                    self.imag_Alpha.isUserInteractionEnabled = false
                    self.headerVw1.backgroundColor = .none
                    self.headerVw2.backgroundColor = .none
                    txtfld_Address.text = nil
                    txtfld_PostalCode.text = nil
                    txtfld_State.text = nil
                    txtfld_City.text = nil
                    ViewAddressApi()
                }else{
                    if responseModel.message == "Address already exist" {
                        AlertControl.shared.showOnlyAlert("Poseidon", message: "Address already exist")
                    }else{
                        print("Not Added Address")
                    }
                }
            }
        }
    }
    
}
extension ViewOrganizationVC : UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return notesArr.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tblVw.dequeueReusableCell(withIdentifier: "ViewOrganizationTVC", for: indexPath) as! ViewOrganizationTVC
//        cell.selectionStyle = .none
//        tblVw.showsVerticalScrollIndicator = false
//        cell.Base_View.backgroundColor = ThemeColor.lightThemeViewBGColor
//        cell.lbl_Name.text =  notesArr[indexPath.row].addressLine
//        cell.lbl_Email.text = notesArr[indexPath.row].state
//        cell.lbl_Number.text = notesArr[indexPath.row].city
//        cell.postalCode.text = notesArr[indexPath.row].postalCode
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
            let cell = tblVw.dequeueReusableCell(withIdentifier: "ViewOrganizationTVC", for: indexPath) as! ViewOrganizationTVC
            cell.selectionStyle = .none
            tblVw.showsVerticalScrollIndicator = false
            cell.Base_View.backgroundColor = ThemeColor.lightThemeViewBGColor
            let address: Address
            if isSearching {
                address = filteredNotesArr[indexPath.row]
            } else {
                address = notesArr[indexPath.row]
            }
            
               cell.lbl_Name.text =  address.addressLine
                cell.lbl_Email.text = address.state
                cell.lbl_Number.text = address.city
                 cell.postalCode.text = address.postalCode
    
    
    
            view.setNeedsDisplay()
    
    
    
            return cell
        }
   
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected indexPath:", indexPath)
        selectedIndexPath = indexPath
        SingleTon.shared.addressId =  self.notesArr[indexPath.row].id
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "buildingViewListVC") as! buildingViewListVC
        VC.nameorg = nameorg
        VC.addressLine = notesArr[indexPath.row].addressLine
        VC.selectedIndexPath = selectedIndexPath
        print("nameorg" , nameorg)
        print("addressLine" , notesArr[indexPath.row].addressLine)
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    
}
extension  ViewOrganizationVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredNotesArr = notesArr.filter { $0.addressLine.lowercased().contains(searchText.lowercased()) }
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
