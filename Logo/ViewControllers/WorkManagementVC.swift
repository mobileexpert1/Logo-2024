//
//  WorkManagementVC.swift
//  Logo
//
//  Created by Vishal on 15/05/24.
//

import UIKit

import UIKit
import MSCircularSlider
import iOSDropDown
import SDWebImage
import CoreLocation
import PKHUD
import SevenSwitch

class WorkManagementVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var sixth_custom_view: UIView!
    @IBOutlet weak var user_Img: UIImageView!
       
       @IBOutlet weak var bg_img: UIImageView!
       
       @IBOutlet weak var lbl_Name: UILabel!
       
       @IBOutlet weak var lbl_Welcome: UILabel!
       
       @IBOutlet weak var bg_View: UIView!
       
       @IBOutlet weak var btn_Noti: UIImageView!
       
       @IBOutlet weak var btn_logout: UIImageView!
       
       @IBOutlet weak var view_Top: UIView!
       
       @IBOutlet weak var vw_Second: UIView!
       
       @IBOutlet weak var vw_First: UIView!
       
       @IBOutlet weak var vw_Three: UIView!
       
       @IBOutlet weak var vw_Four: UIView!
    @IBOutlet weak var vw_Five: UIView!
    
    @IBOutlet weak var lbl_Org: UILabel!
    @IBOutlet weak var img_AddOrg: UIImageView!
    @IBOutlet weak var img_WorkOrder: UIImageView!
    
    @IBOutlet weak var img_Safety: UIImageView!
    @IBOutlet weak var img_ScheduleReq: UIImageView!
    @IBOutlet weak var img_AddProject: UIImageView!
    
    
    @IBOutlet weak var lbl_AddProject: UILabel!
    @IBOutlet weak var lbl_WorkOrder: UILabel!
    @IBOutlet weak var lbl_Safety: UILabel!
    @IBOutlet weak var lbl_ScheduleReq: UILabel!
    

    var loginrequest = [Request]()
    var expenseCategoryArr : [ExpenseDatum] = []
    var expenseCattId = 0
    var locManager : CLLocationManager?
    var lat = ""
    var long = ""
   
    var isOpenCameraForExpense = false
    var imagePicker = UIImagePickerController()
    var isCheckedForExpense = false
    var allProjectsArray : [String] = []
    var allProjectsIdArray : [String] = []
    var profileImg : UIImage = UIImage(named: "user")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didLoadMethods()
        user_Img.clipsToBounds = true
        user_Img.layer.cornerRadius = 20
        
        user_Img.contentMode = .scaleToFill

        user_Img.alpha = 1.0
    }
    func didLoadMethods(){
      
        LocationDidloadRequirements()
        actionBlocks()
        applyStyling(to: vw_Second)
        applyStyling(to: vw_First)
        applyStyling(to: vw_Three)
        applyStyling(to: vw_Four)
        applyStyling(to: vw_Five)
        applyStyling(to: sixth_custom_view)
  
        dashboardDataAPI()
    }
    func LocationDidloadRequirements(){
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager!.requestWhenInUseAuthorization()
        locManager?.requestAlwaysAuthorization()
      

    }
    
    
    func dashboardDataAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.DashboardDataUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : DashboardModel?) in
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

            
          
        
        }
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

       
        vw_Four.actionBlock {
            self.addHapticFeedback()
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateProjectVC") as! CreateProjectVC
            self.navigationController?.pushViewController(VC, animated: true)
        }
        vw_First.actionBlock {
            print("Work Order Tapped")
          //  openWorkOrder()
            self.addHapticFeedback()
            self.openWorkOrderHome()
        }
        vw_Five.actionBlock {
            print("Work org Tapped")
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrganizationListVC") as! OrganizationListVC
            self.navigationController?.pushViewController(VC, animated: true)
            
        }
        vw_Second.actionBlock {
            
                
            self.addHapticFeedback()
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScheduleRequestsVC") as! ScheduleRequestsVC
            VC.forMeetingPdf = true
            VC.headerText = "Safety Meetings"
            self.navigationController?.pushViewController(VC, animated: true)
            
        }
      
        vw_Three.actionBlock {
            self.addHapticFeedback()
            self.openScheduleRequestVC()
        }
    btn_Noti.actionBlock {
            print("lkgbnfkgjdfgn")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllRequestsVC") as! AllRequestsVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        sixth_custom_view.actionBlock {
            self.addHapticFeedback()
            
                      let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstallationHomeVC") as! InstallationHomeVC
                      self.navigationController?.pushViewController(VC, animated: true)
        }
       
    }
    // MARK: - EXECUTE_LOGOUT_API
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
    func openWorkOrderHome(){
    //  let VC = UIStoryboard(name: "WorkOrde rView", bundle: nil).instantiateViewController(withIdentifier: "WorkOrderView")
        let VC = UIStoryboard(name: "WorkOrderView", bundle: nil).instantiateViewController(withIdentifier: "EmergencyWorkOrderVC")
       
        self.navigationController?.pushViewController(VC, animated: true)
    //    self.pushOnly(controllerId: "EmergencyWorkOrderVC", animation: true)
    }
    func executeLogin() {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
        UIApplication.shared.currentWindow?.rootViewController = loginVC
        UIApplication.shared.currentWindow?.makeKeyAndVisible()
    }
    
    func openScheduleRequestVC(){
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ScheduleRequestsVC") as! ScheduleRequestsVC
        VC.forMeetingPdf = false
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    
    
    func applyStyling(to view: UIView) {
           
           view.layer.cornerRadius = 12
           //view.backgroundColor = UIColor.white
           view.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
           view.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
           view.layer.shadowOpacity = 1.5
           view.layer.shadowRadius = 4
        view_Top.roundCorners(corners: [.topLeft, .topRight], radius: 30, newWidth: self.view.frame.width)
       }

    }
 

   


