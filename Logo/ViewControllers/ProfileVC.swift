//
//  ProfileVC.swift
//  Logo
//
//  Created by Vishal on 15/05/24.
//

import UIKit
import PKHUD

class ProfileVC: UIViewController, UITabBarControllerDelegate {
    @IBOutlet weak var user_Img: UIImageView!
    
    @IBOutlet weak var bg_img: UIImageView!
    
    @IBOutlet weak var lbl_Name: UILabel!
    
    @IBOutlet weak var lbl_Welcome: UILabel!
    
    @IBOutlet weak var bg_View: UIView!
    
    @IBOutlet weak var btn_Noti: UIImageView!
    
    @IBOutlet weak var btn_logout: UIImageView!
    
    @IBOutlet weak var view_Top: UIView!
    
    @IBOutlet weak var nameview: UIView!
    
    
    @IBOutlet weak var txt_FldName: UITextField!
    @IBOutlet weak var txt_FldGenderName: UITextField!
    @IBOutlet weak var txt_FldPrice: UITextField!
    @IBOutlet weak var txt_FldRoll: UITextField!
    
    @IBOutlet weak var imgVwProfile: UIImageView!
    @IBOutlet weak var txt_FldTotalLeaves: UITextField!
    @IBOutlet weak var txt_FldLeavesTaken: UITextField!
    
    @IBOutlet weak var btn_ChangePass: UIButton!
    
    @IBOutlet weak var back_Img: UIImageView!
    @IBOutlet weak var baseVw: UIView!
    
    @IBOutlet weak var genderVw: UIView!
    
    @IBOutlet weak var priceVw: UIView!
    
    @IBOutlet weak var roleVw: UIView!
    
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var leavesVw: UIView!
    @IBOutlet weak var totalVw: UIView!
    @IBOutlet weak var lbl_Namedata: UILabel!
    @IBOutlet weak var lbl_GenderName: UILabel!
    @IBOutlet weak var lbl_Price: UILabel!
    @IBOutlet weak var lbl_TotalLeaves: UILabel!
    @IBOutlet weak var lbl_LeavesTaken: UILabel!
    @IBOutlet weak var lbl_NameRoll: UILabel!
    
    //popup
    
    @IBOutlet weak var imgAlpha: UIImageView!
    @IBOutlet weak var vwPopup: UIView!
    
    @IBOutlet weak var popSave: UIButton!
    @IBOutlet weak var txtFld_OldPassword: UITextField!
    
    @IBOutlet weak var txtFld_NewPass: UITextField!
    var myDataArray = [UserData]()
    var sectionsModel : ProfileDataModel!
    var profileImg : UIImage = UIImage(named: "user")!
    var loginrequest = [Request]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        if let tabBarController = self.tabBarController {
        //                    tabBarController.delegate = self
        //                }
        setDataLoad()
        
        
    }
    func setDataLoad(){
        
        vwPopup.isHidden = true
        imgAlpha.isHidden = true
        btn_ChangePass.layer.cornerRadius = 25
        
        
        applyStyling(to: nameview)
        applyStyling(to: leavesVw)
        applyStyling(to: totalVw)
        applyStyling(to: roleVw)
        applyStyling(to: priceVw)
        applyStyling(to: genderVw)
        view_Top.roundCorners(corners: [.topLeft, .topRight], radius: 30, newWidth: self.view.frame.width)
        user_Img.clipsToBounds = true
        user_Img.layer.cornerRadius = 17.5
        user_Img.contentMode = .scaleToFill
        
        user_Img.alpha = 1.0
        
        imgVwProfile.clipsToBounds = true
        imgVwProfile.layer.cornerRadius = 30
        imgVwProfile.contentMode = .scaleToFill
        
        imgVwProfile.alpha = 1.0
        self.txtFld_OldPassword.setLeftPaddingPoints(20)
        self.txtFld_NewPass.setLeftPaddingPoints(20)
        applyStylingfld(to: txtFld_OldPassword)
        applyStylingfld(to: txtFld_NewPass)
        popSave.layer.cornerRadius = 25
        btnCancel.layer.cornerRadius = 25
        vwPopup.layer.cornerRadius = 25
        txtFld_OldPassword.layer.cornerRadius = 25
        actionBlocks()
    }
    
    func actionBlocks(){
        
        
        
        btn_logout.actionBlock { [self] in
            AlertControl.shared.showAlert("Poseidon", message: "Are you sure to logout?", buttons: ["Cancel","OK"]) { value in
                if value == 1{
                    self.addHapticFeedback()
                    self.logOutApi()
                }
            }
        }
        
        btn_Noti.actionBlock {
            print("lkgbnfkgjdfgn")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllRequestsVC") as! AllRequestsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
    }
    
    func logOutApi() {
        loginrequest = [Request]()
        ApiFunc.shared.logoutApi(self.view) { responseModel in
            if responseModel.status == true {
                SingleTon.shared.userToken = ""
                self.executeLogin()
            } else {
                HUD.flash(.labeledError(title: "", subtitle: responseModel.message), delay: 1.0)
            }
        }
    }
    // MARK: - Functions
    func executeLogin() {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
        UIApplication.shared.currentWindow?.rootViewController = loginVC
        UIApplication.shared.currentWindow?.makeKeyAndVisible()
    }
    
    
    
    
    @IBAction func actionCancel(_ sender: Any) {
        vwPopup.isHidden = true
        imgAlpha.isHidden = true
        btn_logout.isUserInteractionEnabled = true
        btn_Noti.isUserInteractionEnabled = true
    }
    
    @IBAction func actionSavePOp(_ sender: Any) {
        if txtFld_OldPassword.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "please fill old password.")
        } else if txtFld_NewPass.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "please fill new password.")
        }
        else{
            resetApi()
            
        }
        
        
        
        
        
    }
    
    
    func resetApi() {
        // executWorkOrderHome()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            PKHUD.sharedHUD.show()
        }
        ApiFunc.shared.Changepassword(self.view, password: self.txtFld_NewPass.text!) { [self] responseModel in
            if responseModel.status == true {
                let token = responseModel.data
                
                print("responseModel.data", responseModel.data)
                
                
                
                vwPopup.isHidden = true
                imgAlpha.isHidden = true
                btn_logout.isUserInteractionEnabled = true
                btn_Noti.isUserInteractionEnabled = true
                
                DispatchQueue.main.async {
                    
                    PKHUD.sharedHUD.hide()
                }
            } else {
                PKHUD.sharedHUD.hide()
                HUD.flash(.labeledError(title: "", subtitle: responseModel.message), delay: 1.0)
                self.showOnlyAlert("Alert", message: responseModel.message ?? "Empty User Profile Data")
            }
        }
    }
    
    
    
    func ProfleDataAPI(){
        ApiFunc.shared.allSectionsprofie(self.view) { [self] responseModel in
            if responseModel.status == true {
                Indicator.sharedInstance.hideIndicator()
                lbl_Namedata.text = responseModel.data.userData.userName
                lbl_GenderName.text = responseModel.data.userData.gender
                lbl_TotalLeaves.text = responseModel.data.userData.deleteStatus
                lbl_LeavesTaken.text = responseModel.data.userData.noOfVacation
                lbl_Price.text = responseModel.data.userData.hourlyPrice
                imgVwProfile.sd_setImage(with: URL(string: ApiUrl.ProfileImgBase + responseModel.data.userData.profileImage), placeholderImage: UIImage(named: "user"))
                profileImg = imgVwProfile.image!
                
                
                
                if let roleValue = responseModel.data.userData.role as? String {
                    var roleName: String
                    
                    switch roleValue {
                    case "3":
                        roleName = "Inspector"
                    case "4":
                        roleName = "Field"
                    case "5":
                        roleName = "Office"
                    case "6":
                        roleName = "Project Manager"
                    case "7":
                        roleName = "Design"
                    default:
                        roleName = ""
                    }
                    
                    
                    print("Role: \(roleName)")
                    lbl_NameRoll.text = roleName
                }
                
                
            }else {
                Indicator.sharedInstance.hideIndicator()
                HUD.flash(.labeledError(title: "", subtitle: responseModel.message), delay: 1.0)
            }
        }
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        dashboardDataAPI()
        
        ProfleDataAPI()
    }
    
    
    
    
    @IBAction func action_ChangePass(_ sender: Any) {
        vwPopup.isHidden = false
        btn_logout.isUserInteractionEnabled = false
        btn_Noti.isUserInteractionEnabled = false
        imgAlpha.isHidden = false
    }
    
    func dashboardDataAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.DashboardDataUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self]
            (success : DashboardModel?) in
            Indicator.sharedInstance.hideIndicator()
            let dashboardData = success!.data
            
            
            if dashboardData.punchData == 0{
                SingleTon.shared.isPunchedIn = false
            }
            else{
                SingleTon.shared.isPunchedIn = true
            }
            
            user_Img.sd_setImage(with: URL(string: ApiUrl.ProfileImgBase + dashboardData.profilePic), placeholderImage: UIImage(named: "user"))
            profileImg = user_Img.image!
            lbl_Name.text = dashboardData.userName
            //  imgVwProfile.image = profileImg
            
            
            
        }
    }
    
    func applyStyling(to view: UIView) {
        
        view.layer.cornerRadius = 25
        view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
        view.layer.shadowOpacity = 1.5
        view.layer.shadowRadius = 4
        
    }
    func applyStylingfld(to textfld: UITextField) {
        
        textfld.layer.cornerRadius = 25
        textfld.backgroundColor = UIColor.white
        textfld.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
        textfld.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
        textfld.layer.shadowOpacity = 1.5
        textfld.layer.shadowRadius = 4
        
    }
    //    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    //        // Show an alert when a tab bar item is clicked
    //        if let index = tabBarController.viewControllers?.firstIndex(of: viewController) {
    //            if index == 4 {
    //                let alertController = UIAlertController(title: "", message: "Under Progress", preferredStyle: .alert)
    //                let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
    //                alertController.addAction(okAction)
    //                self.present(alertController, animated: true, completion: nil)
    //            } else {
    //                print("data")
    //            }
    //        }
    //    }
    
}
