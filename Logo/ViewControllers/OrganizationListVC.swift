//
//  OrganizationListVC.swift
//  Logo
//
//  Created by Vishal on 11/06/24.
//

import UIKit
import Alamofire
import PKHUD
class OrganizationListVC: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var headerVw2: UIView!
    @IBOutlet weak var headerVw1: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var addSubjectBtn: UIImageView!
    @IBOutlet weak var bgImgVw: UIImageView!
    //popup
    @IBOutlet weak var imgView: LazyImageView!
    @IBOutlet weak var baseVw: UIView!
    @IBOutlet weak var imag_Alpha: UIImageView!
    @IBOutlet weak var pop_Vw: UIView!
    @IBOutlet weak var img_Camera: UIImageView!
    @IBOutlet weak var org_Name: UITextField!
    @IBOutlet weak var org_Email: UITextField!
    @IBOutlet weak var org_PhoneNo: UITextField!
    @IBOutlet weak var org_ReqName: UITextField!
    
    @IBOutlet weak var search_Name: UISearchBar!
    var nameorg = ""
    var isSearching: Bool = false
    var filteredNotesArr: [Organization] = []
    var notesArr : [Organization] = []
    var profileImg : UIImage = UIImage(named: "user")!
    var dataimg : UIImage = UIImage(named: "user")!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetData()
        self.pop_Vw.isHidden = true
        imag_Alpha.isHidden = true
        imgView.layer.cornerRadius = imgView.bounds.width / 2
        imgView.clipsToBounds = true
        imgView.contentMode = .scaleAspectFill
        pop_Vw.layer.cornerRadius =  30
        search_Name.delegate = self
    }
    func SetData(){
        self.navigationController?.navigationBar.isHidden = true
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.separatorStyle = .none
        OrganizationListTVC.registerTableCell(for: tblVw)
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
        img_Camera.actionBlock {
            ImagePickerManager().pickImage(self){ image in
                self.imgView.image = image
            }
        }
    }
    @IBAction func btn_hide(_ sender: Any) {
        self.pop_Vw.isHidden = true
        self.imag_Alpha.isHidden = true
        self.imag_Alpha.isUserInteractionEnabled = false
        self.headerVw1.backgroundColor = .none
        self.headerVw2.backgroundColor = .none
    }
    
    @IBAction func action_Submit(_ sender: Any) {
        if org_Name.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill Organization Name.")
        }else if org_ReqName.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill Requested Name.")
            
        }else if org_Email.text == ""{
            showOnlyAlert("Poseidon", message: "enter Email Address")
        }else if !org_Email.text!.isValidEmail(){
            showOnlyAlert("Poseidon", message: "enter Valid Email Address")
        }else if org_PhoneNo.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill Requested Name.")
            
        }
        else{
            uploadDataWithImage()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        organizationapi()
        
    }
    func organizationapi() {
        ApiFunc.shared.OrganizationListApi(self.view) { [self] responseModel in
            Indicator.sharedInstance.hideIndicator()
            let requestData = responseModel.data
            notesArr = requestData.organizations
            tblVw.reloadData()
            if responseModel.status == true {
                print("status-->", responseModel.status)
            }else{
                
            }
        }
    }
    
    func uploadDataWithImage() {
        
        let url = "https://247.poseidons.io/api/inspector/addOrganization"
        Indicator.sharedInstance.showIndicator()
        guard let image = self.imgView.image else {
            print("No image found in the imageView")
            return
        }
        
        AF.upload(multipartFormData: { [self] multipartFormData in
            // Convert image to data
            guard let imageData = image.jpegData(compressionQuality: 0.5) else {
                print("Failed to convert image to data")
                return
            }
            // Add image data
            multipartFormData.append(imageData, withName: "profileImage", fileName: "image.jpeg", mimeType: "image/jpeg")
            
            // Add other parameters
            let parameters = [
                "organizationName": self.org_Name.text,
                "fullName":  self.org_ReqName.text,
                "emailAddress": self.org_Email.text,
                "phoneNumber": org_PhoneNo.text
            ]
            for (key, value) in parameters {
                if let data = value?.data(using: .utf8) {
                    multipartFormData.append(data, withName: key)
                }
            }
        }, to: url)
        .response { response in
            // Handle response
            if let error = response.error {
                print("Error: \(error)")
                return
            }
            
            
            
            if let data = response.data {
                do {
                    // Decode the response data into NewOrganizationModel
                    let decoder = JSONDecoder()
                    let newOrganization = try decoder.decode(NewOrganizationModel.self, from: data)
                    
                    // Process the decoded data
                    if newOrganization.status == true {
                        self.pop_Vw.isHidden = true
                        self.imag_Alpha.isHidden = true
                        self.imag_Alpha.isUserInteractionEnabled = false
                        self.headerVw1.backgroundColor = .none
                        self.headerVw2.backgroundColor = .none
                        Indicator.sharedInstance.hideIndicator()
                        self.org_Name.text = nil
                        self.org_Email.text = nil
                        self.org_ReqName.text = nil
                        self.org_PhoneNo.text = nil
                        self.imgView.image = self.dataimg
                        self.organizationapi()
                        self.tblVw.reloadData()
                    } else {
                        Indicator.sharedInstance.hideIndicator()
                        if newOrganization.message == "Organization already exist" {
                            AlertControl.shared.showOnlyAlert("", message: newOrganization.message ?? "Organization already exist")
                        }else{
                            print("Organization Not")
                        }
                    }
                } catch {
                    print("Failed to decode response: \(error)")
                }
            }
        }
    }
    
}
extension OrganizationListVC : UITableViewDelegate, UITableViewDataSource{
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return notesArr.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tblVw.dequeueReusableCell(withIdentifier: "OrganizationListTVC", for: indexPath) as! OrganizationListTVC
//        cell.selectionStyle = .none
//        tblVw.showsVerticalScrollIndicator = false
//        cell.Base_View.backgroundColor = ThemeColor.lightThemeViewBGColor
//        cell.lbl_Name.text =  notesArr[indexPath.row].name
//        cell.lbl_Email.text = notesArr[indexPath.row].requestEmail
//        cell.lbl_Number.text = notesArr[indexPath.row].requestPhoneNumber
//        cell.img_organization.sd_setImage(with: URL(string: ApiUrl.ProfileImgBase + notesArr[indexPath.row].image), placeholderImage: UIImage(named: "building"))
//        profileImg =  cell.img_organization.image!
//        
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
        let cell = tblVw.dequeueReusableCell(withIdentifier: "OrganizationListTVC", for: indexPath) as! OrganizationListTVC
        cell.selectionStyle = .none
        tblVw.showsVerticalScrollIndicator = false
        cell.Base_View.backgroundColor = ThemeColor.lightThemeViewBGColor
        
        let organization: Organization
        if isSearching {
            organization = filteredNotesArr[indexPath.row]
        } else {
            organization = notesArr[indexPath.row]
        }
        
        cell.lbl_Name.text = organization.name
        cell.lbl_Email.text = organization.requestEmail
        cell.lbl_Number.text = organization.requestPhoneNumber
        cell.img_organization.sd_setImage(with: URL(string: ApiUrl.ProfileImgBase + organization.image), placeholderImage: UIImage(named: "building"))
        profileImg = cell.img_organization.image!
        
        view.setNeedsDisplay()
        return cell
    }


    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        SingleTon.shared.organizationsIds =  self.notesArr[indexPath.row].id
        nameorg = self.notesArr[indexPath.row].name
        print(SingleTon.shared.organizationsIds)
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewOrganizationVC") as! ViewOrganizationVC
        VC.nameorg = self.notesArr[indexPath.row].name
        print( "VC.nameorg " , VC.nameorg )
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
}
extension OrganizationListVC: UISearchBarDelegate {
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
