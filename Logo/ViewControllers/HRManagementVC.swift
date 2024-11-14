//
//  HRManagementVC.swift
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
class HRManagementVC: UIViewController,CLLocationManagerDelegate  {
 
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
    
    @IBOutlet weak var img_Vacations: UIImageView!
    
    @IBOutlet weak var img_Timesheet: UIImageView!
    @IBOutlet weak var img_Expense: UIImageView!
   
    
    
    
    @IBOutlet weak var lbl_Vacations: UILabel!
    @IBOutlet weak var lbl_Timesheet: UILabel!
    @IBOutlet weak var lbl_Expense: UILabel!
    
    @IBOutlet weak var alphaImgVw: UIImageView!
    @IBOutlet weak var expenseTitleTxtFld: UITextField!
    @IBOutlet weak var expensePriceTxtFld: UITextField!
  
    @IBOutlet weak var expenseCategoryTxtFld: DropDown!
    
    @IBOutlet weak var expenseProjectTxtFld: DropDown!
  
    @IBOutlet weak var recieptImgVw: UIImageView!
   
    @IBOutlet weak var expenseCheckBox: UIImageView!
    @IBOutlet weak var expenseView: UIView!
    @IBOutlet weak var expenseVw: UIView!
    var categoryArr : [String] = []
    var expenseCategoryArr : [ExpenseDatum] = []
    var expenseCattId = 0
    var locManager : CLLocationManager?
    var lat = ""
    var long = ""
    var loginrequest = [Request]()
    var isOpenCameraForExpense = false
    var imagePicker = UIImagePickerController()
    var isCheckedForExpense = false
    var allProjectsArray : [String] = []
    var allProjectsIdArray : [String] = []
    var profileImg : UIImage = UIImage(named: "user")!
    override func viewDidLoad() {
        super.viewDidLoad()
        SetUI()
    }
    
    
    func SetUI(){
        
        alphaImgVw.isHidden = true
        applyStyling(to: vw_Second)
        applyStyling(to: vw_First)
        applyStyling(to: vw_Three)
        applyStyling(to: vw_Four)
        HideViews()
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager?.requestAlwaysAuthorization()
        didLoadMethods()
        dashboardDataAPI()
        user_Img.clipsToBounds = true
        user_Img.layer.cornerRadius = 20
        user_Img.contentMode = .scaleToFill

        user_Img.alpha = 1.0
        alphaImgVw.isUserInteractionEnabled = true
        recieptImgVw.clipsToBounds = true
        recieptImgVw.layer.cornerRadius = 50.0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        var currentLocation: CLLocation!
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager?.location
            lat = currentLocation.coordinate.latitude.description
            long = currentLocation.coordinate.longitude.description
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
        expenseCheckBox.actionBlock { [self] in
            self.addHapticFeedback()
            if isCheckedForExpense{
                isCheckedForExpense = false
                expenseCheckBox.image = UIImage(named: "uncheckB")
            }
            else{
                isCheckedForExpense = true
                expenseCheckBox.image = UIImage(named: "checkB")
            }
        }

        
        
        vw_Second.actionBlock {
            self.addHapticFeedback()
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "EEEE" // OR "dd-MM-yyyy"
            let currentDateString: String = dateFormatter.string(from: date)
            print("Current date is \(currentDateString)")
            print("Current date is \(currentDateString)")
                let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FSCalendarVC") as! FSCalendarVC
            // VC.isTimesheetAdded = isTimesheetAdded
            self.navigationController?.pushViewController(VC, animated: true)
        }
        vw_First.actionBlock {
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "VacationsVC") as! VacationsVC
            self.navigationController?.pushViewController(VC, animated: true)
        }
      
     
        vw_Three.actionBlock {
            
            
            
            
            print("expenseView Tapped")
            self.addHapticFeedback()
            self.expenseCheckBox.image = UIImage(named: "uncheckB")
            self.isOpenCameraForExpense = true
            self.openCamera()
            
        }
        
        vw_Four.actionBlock {
            
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SubjectDiscussVC") as! SubjectDiscussVC
            self.navigationController?.pushViewController(VC, animated: true)
            
            
            
            
        }
        
        btn_Noti.actionBlock {
                print("lkgbnfkgjdfgn")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllRequestsVC") as! AllRequestsVC
                self.navigationController?.pushViewController(vc, animated: true)
            }
     
    }
    
    
    
    
    func dashboardDataAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.DashboardDataUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : DashboardModel?) in
            let dashboardData = success!.data
            categoryArr.removeAll()
            self.expenseCategoryArr = dashboardData.expenseData
            if dashboardData.punchData == 0{
                SingleTon.shared.isPunchedIn = false
            }
            else{
                SingleTon.shared.isPunchedIn = true
            }
            for i in 0..<self.expenseCategoryArr.count{
                categoryArr.append(self.expenseCategoryArr[i].name)
            }
            expenseCategoryTxtFld.optionArray = categoryArr
           
            user_Img.sd_setImage(with: URL(string: ApiUrl.ProfileImgBase + dashboardData.profilePic), placeholderImage: UIImage(named: "user"))
            profileImg = user_Img.image!
            lbl_Name.text = dashboardData.userName

                punchInListAPI(type : "0")
          
        
        }
    }
    
    
    // MARK: - ALL_PROJECTS_API
    func punchInListAPI(type : String){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ClockInListUrl, method: .post, parameters: ["sessionToken" : SingleTon.shared.userToken,"lat" : lat,"long" : long, "type" : type]) { [self] (success : ClockInListModel?) in
            let myProjectsArr = success!.data.projects
            self.allProjectsArray.removeAll()
           myProjectsArr.forEach({ data in
                self.allProjectsArray.append(data.fullName)
               self.allProjectsIdArray.append(data.id)
            })
            expenseProjectTxtFld.optionArray = allProjectsArray
        }
    }
    
    
    @IBAction func expenseSubmitBtnAction(_ sender: UIButton) {
        if expenseTitleTxtFld.text!.isEmpty || expensePriceTxtFld.text!.isEmpty || expenseCategoryTxtFld.text!.isEmpty || expenseProjectTxtFld.text!.isEmpty {
            showOnlyAlert("Poseidon", message: "Kindly fill all fields.")
        }
        else{
           AddExpensesAPI()
        }
    }
    // MARK: - ADD_EXEPENSES_API
    func AddExpensesAPI(){
        
        var check = 0
        if isCheckedForExpense{
            check = 1
        }
        else{
            check = 0
        }
        
        
        
        let params = ["sessionToken" : SingleTon.shared.userToken,"title" : expenseTitleTxtFld.text!,"category" : expenseCattId,"price" : expensePriceTxtFld.text!,"image" : SingleTon.shared.punchImage, "reimbursement" : check.description, "projectId" : allProjectsIdArray[expenseProjectTxtFld.selectedIndex!]] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.AddExpensesUrl, method: .post, parameters:  params) { [self] (success : AddExpenseModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            HideViews()
        }
    }
    @IBAction func cancelBtnExpenseAction(_ sender: UIButton) {
        expenseTitleTxtFld.text = nil
        expenseCategoryTxtFld.text = nil
        expensePriceTxtFld.text = nil
        expenseProjectTxtFld.text = nil
        isCheckedForExpense = false
        HideViews()
    }
    
    func HideViews(){
        alphaImgVw.isHidden = true
        expenseVw.isHidden = true
//        injuryPopUp.isHidden = true
//        StartDate = nil
//        EndDate = nil
//        applyLeavesArray.removeAll()
       
        expenseTitleTxtFld.text = nil
        expenseCategoryTxtFld.text = nil
        
        
        expensePriceTxtFld.text = nil
        expensePriceTxtFld.text = nil
      
      
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
    func executeLogin() {
        let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
        UIApplication.shared.currentWindow?.rootViewController = loginVC
        UIApplication.shared.currentWindow?.makeKeyAndVisible()
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
    
    func didLoadMethods(){
        //        NotificationCenter.default.addObserver(self, selector: #selector(openForSchedule), name: Notification.Name("Schedule"), object: nil)
        //        NotificationCenter.default.addObserver(self, selector: #selector(openForNotification), name: Notification.Name("Accept"), object: nil)
        LocationDidloadRequirements()
        actionBlocks()
       
        delegates()
        HideViews()
        expenseCategoryTxtFld.didSelect { selectedText, index, id in
            print("Selected Text \(selectedText)")
            self.expenseCattId = Int(self.expenseCategoryArr[index].id)!
            self.expenseProjectTxtFld.didSelect { selectedText, index, id in
                print("Selected Text \(selectedText)")
                
            }
            
        }
      
        expenseProjectTxtFld.didSelect { selectedText, index, id in
            print("Selected Text \(selectedText)")
        }
        
    }
    func LocationDidloadRequirements(){
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager!.requestWhenInUseAuthorization()
        locManager?.requestAlwaysAuthorization()
      

    }
        // MARK: - DELEGATES_SELF
        func delegates(){
          
            expenseCategoryTxtFld.delegate = self
          
            expenseProjectTxtFld.delegate = self
         
            
        }

    }
 


extension HRManagementVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
            if isOpenCameraForExpense == false{
                var currentLocation: CLLocation!
                if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                    CLLocationManager.authorizationStatus() ==  .authorizedAlways
                {
                    currentLocation = locManager?.location
                    lat = currentLocation.coordinate.latitude.description
                    long = currentLocation.coordinate.longitude.description
                }
            }
            
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
               // dayPunchSwitch.setOn(SingleTon.shared.isPunchedIn, animated: true)
                return controller
            }()
            self.present(alertController, animated: true)
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.editedImage] as? UIImage {
            // imageViewPic.contentMode = .scaleToFill
            if imagePicker.sourceType == .camera{
                UIImageWriteToSavedPhotosAlbum(pickedImage, self, nil, nil)
                setUserPhoto(UserPhoto: pickedImage)
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUserPhoto(UserPhoto : UIImage){
        let imgData = UserPhoto.jpegData(compressionQuality: 0.5)
        let base64Data = imgData?.base64EncodedString()
        SingleTon.shared.punchImage = base64Data!
        if isOpenCameraForExpense{
            DispatchQueue.main.asyncAfter(wallDeadline: .now()+1.0) {
                self.isCheckedForExpense = false
                self.HideViewsExcept(Vw: self.expenseVw)
               self.recieptImgVw.image = UserPhoto
            }
        }
        else{
          // PunchDayAPI()
        }
    }
    
    // MARK: - HIDE_ALL_VIEWS_EXCEPT_A_VIEW
    func HideViewsExcept(Vw:UIView){
       alphaImgVw.isHidden = false
       expenseVw.isHidden = true
//            GlobalCalendrVw.isHidden = true
//            createProjectPopUpVw.isHidden = true
        UIView.transition(with: Vw, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            Vw.isHidden = false
                      })
    }
   
    
    
    
    
}
extension HRManagementVC : UITextFieldDelegate{
    // MARK: - TEXTFIELD_DELEGATES
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.expenseCategoryTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.expenseCategoryTxtFld.showList()
            return false
        }
      
        else if textField == self.expenseProjectTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.expenseProjectTxtFld.showList()
            return false
        }
        
        
//       else if textField == self.injuryTxtFld{
//            textField.endEditing(true)
//            self.isEditing = false
//            self.injuryTxtFld.showList()
//            return false
//        }
        
        return true
    }
}
