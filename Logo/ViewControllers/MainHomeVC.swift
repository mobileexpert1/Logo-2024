//
//  MainHomeVC.swift
//  Logo
//
//  Created by Mobile on 24/03/23.
//


import UIKit
import PKHUD
import CoreLocation
import iOSDropDown
import SideMenu
import FSCalendar


class MainHomeVC: UIViewController, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate, menuBtnActionDelegate, FSCalendarDelegateAppearance, UITextViewDelegate {
    func ActionCall(Action: Int) {
        switch Action{
        case 1:
            print("Holidays")
            alphaImgVw.isHidden = false
            GlobalCalendrVw.isHidden = false
            dismiss(animated: true)
        case 2:
            print("Expenses")
            dismiss(animated: true)
            isOpenCameraForExpense = true
            self.openCamera(tag: 0)
        case 3:
            print("Logout")
            dismiss(animated: true)
        default :
            print("Nothing")
            dismiss(animated: true)
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if SingleTon.shared.onRequest{
            return clockInListArray.count
        }
        else{
            return tblArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if SingleTon.shared.onRequest{
            let cell = mainTblVw.dequeueReusableCell(withIdentifier: "ClockListTableViewCell", for: indexPath) as! ClockListTableViewCell
            cell.selectionStyle = .none
            cell.projectNameLbl.text = clockInListArray[indexPath.row].fullName
            cell.projectAddressLbl.text = clockInListArray[indexPath.row].address
            if clockInListArray[indexPath.row].clockedInStatus == 0{
                cell.punchSwitch.setOn(false, animated: true)
            }
            else{
                cell.punchSwitch.setOn(true, animated: false)
            }
            cell.punchSwitch.tag = indexPath.row
            
            cell.punchSwitch.addTarget(self, action: #selector(swtchAction), for: .valueChanged)
            
            
            //            cell.companyNameLbl.text = clockInListArray[indexPath.row].projectName
            //            cell.clockInLbl.text = clockInListArray[indexPath.row].clockInTime
            //            cell.clockOutLbl.text = clockInListArray[indexPath.row].clockOutTime
            //            cell.clockDateLbl.text = clockInListArray[indexPath.row].date
            //            if clockInListArray[indexPath.row].approvedStatus == "0"{
            //                cell.statusLbl.textColor = .red
            //                cell.statusLbl.text = "Rejected"
            //            }
            //            else{
            //                cell.statusLbl.textColor = .green
            //                cell.statusLbl.text = "Approved"
            //            }
            return cell
        }
        else{
            let cell = mainTblVw.dequeueReusableCell(withIdentifier: "AppProfileTableViewCell", for: indexPath) as! AppProfileTableViewCell
            cell.appProfileLbl.text = tblArray[indexPath.row]
            cell.selectionStyle = .none
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if SingleTon.shared.onRequest{
        }
        else{
            switch indexPath.row {
            case 0:
                openClock()
            case 1:
                openWorkOrder()
            case 2:
                openPoseidon()
            default:
                print("Nothing")
            }
        }
    }
    
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        
        if explainTxtVw.text.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Kindly explain the injury")
        }
        else{
            self.PunchDayAPI()
        }
    }
    @objc func swtchAction(_ swtch:UISwitch){
        SingleTon.shared.forRequest = true
        isOpenCameraForExpense = false
        openCamera(tag: swtch.tag)
        requestedIndex = swtch.tag.description
    }
    
    func openCamera(tag:Int){
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
                if isOpenCameraForExpense == false{
                    if SingleTon.shared.forRequest{
                        mainTblVw.reloadData()
                        let indxPath = IndexPath(row: tag, section: 0)
                        mainTblVw.scrollToRow(at: indxPath, at: .bottom, animated: false)
                    }
                    else{
                        self.punchSwitch.setOn(SingleTon.shared.isClockedIn, animated: false)
                    }
                }
                
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
                if isOpenCameraForExpense{
                    recieptImgVw.image = pickedImage
                    expenseVw.isHidden = false
                    alphaImgVw.isHidden = false
                }
                else{
                    setUserPhoto(UserPhoto: pickedImage)
                }
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(picker: UIImagePickerController!) {
        if isOpenCameraForExpense{
            
        }
        else{
            if SingleTon.shared.forRequest{
                mainTblVw.reloadData()
                let indxPath = IndexPath(row: Int(requestedIndex)!, section: 0)
                mainTblVw.scrollToRow(at: indxPath, at: .bottom, animated: false)
            }
            else{
                self.punchSwitch.setOn(SingleTon.shared.isClockedIn, animated: false)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUserPhoto(UserPhoto : UIImage){
        let imgData = UserPhoto.jpegData(compressionQuality: 0.5)
        let base64Data = imgData?.base64EncodedString()
        SingleTon.shared.punchImage = base64Data!
        
        if SingleTon.shared.forRequest{
            DispatchQueue.main.asyncAfter(wallDeadline: .now()+1.0) {
                self.PunchAPI()
            }
        }
        else{
            if SingleTon.shared.isClockedIn{
                self.injuryPopUp.isHidden = false
                self.alphaImgVw.isHidden = false
            }
            else{
                explainTxtVw.text = ""
                PunchDayAPI()
            }
        }
        
        
    }
    
    //MARK: PUNCH_API
    func PunchAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.PunchUrl, method: .post, parameters: ["sessionToken" : SingleTon.shared.userToken,"lat" : lat,"long" : long,"image" :SingleTon.shared.punchImage,"project" : clockInListArray[Int(requestedIndex)!].id.description]) { [self] (success : PunchModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            punchInListAPI()
            
            let indxPath = IndexPath(row: Int(requestedIndex)!, section: 0)
            mainTblVw.scrollToRow(at: indxPath, at: .bottom, animated: false)
        }
    }
    
    
    func openClock(){
        //        SingleTon.shared.onRequest = true
        //        backBtn.isHidden = false
        //        punchSwitch.isHidden = false
        
        self.punchInListAPI()
        
    }
    
    func openPoseidon(){
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Home_VC")
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    func openWorkOrder(){
        let VC = UIStoryboard(name: "WorkOrderView", bundle: nil).instantiateViewController(withIdentifier: "WorkOrderView")
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    @IBOutlet weak var logoutBtn: UIImageView!
    @IBOutlet weak var mainTblVw: UITableView!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var topTitleLbl: UILabel!
    @IBOutlet weak var punchSwitch: UISwitch!
    @IBOutlet weak var injuryPopUp: UIView!
    @IBOutlet weak var explainVw: UIView!
    @IBOutlet weak var explainTxtVw: UITextView!
    //  @IBOutlet weak var injuryTxtFld: DropDown!
    
    
    @IBOutlet weak var expenseVw: UIView!
    @IBOutlet weak var GlobalCalendrVw: UIView!
    @IBOutlet weak var calendr: FSCalendar!
    @IBOutlet weak var alphaImgVw: UIImageView!
    @IBOutlet weak var injuryTxtFld: DropDown!
    @IBOutlet weak var calendrReasonVw: UIView!
    @IBOutlet weak var calndrReasonImgVw: UIImageView!
    @IBOutlet weak var reasonTxtVw: UITextView!
    @IBOutlet weak var okReasonBtn: UIButton!
    @IBOutlet weak var recieptImgVw: UIImageView!
    @IBOutlet weak var expenseTitleTxtFld: UITextField!
    @IBOutlet weak var expensePriceTxtFld: UITextField!
    @IBOutlet weak var expenseCategoryTxtFld: DropDown!
    
    
    var tblArray : [String] = []
    var appProfileArr : [String] = []
    var loginrequest = [Request]()
    var lat = ""
    var long = ""
    var locManager : CLLocationManager?
    var window: UIWindow?
    var imagePicker = UIImagePickerController()
    var clockInListArray = [ClockInListData]()
    var completedRequestListArray = [CompletedRequest]()
    var requestedIndex = "0"
    let optionArr = ["Yes","No"]
    let categoryArr = ["1","2","3","4"]
    var holidaysArr : [String] = []
    var isOpenCameraForExpense = false
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager!.requestWhenInUseAuthorization()
        locManager?.requestAlwaysAuthorization()
        
        SingleTon.shared.onRequest = false
        mainTblVw.delegate = self
        mainTblVw.dataSource = self
        injuryTxtFld.delegate = self
        expenseCategoryTxtFld.delegate = self
        expenseTitleTxtFld.delegate = self
        expensePriceTxtFld.delegate = self
        reasonTxtVw.delegate = self
        
        GlobalCalendrVw.isHidden = true
        expenseVw.isHidden = true
        self.calendrReasonVw.isHidden = true
        self.alphaImgVw.isHidden = true
        injuryPopUp.isHidden = true
        explainVw.isHidden = true
        
        GlobalCalendrVw.clipsToBounds = true
        GlobalCalendrVw.layer.cornerRadius = 10.0
        expenseVw.clipsToBounds = true
        expenseVw.layer.cornerRadius = 10.0
        recieptImgVw.clipsToBounds = true
        recieptImgVw.layer.cornerRadius = 50.0
       
        reasonTxtVw.clipsToBounds = true
        reasonTxtVw.layer.borderWidth = 1.0
        reasonTxtVw.layer.borderColor = UIColor.darkGray.cgColor
       
        let nibAppProfileTblVwCell = UINib(nibName: "AppProfileTableViewCell", bundle: nil)
        mainTblVw.register(nibAppProfileTblVwCell, forCellReuseIdentifier: "AppProfileTableViewCell")
        
        let nibClockTableViewCell = UINib(nibName: "ClockListTableViewCell", bundle: nil)
        mainTblVw.register(nibClockTableViewCell, forCellReuseIdentifier: "ClockListTableViewCell")
        mainTblVw.rowHeight = 180
        Actions()
        injuryTxtFld.optionArray = optionArr
        expenseCategoryTxtFld.optionArray = categoryArr
        
        injuryTxtFld.didSelect { selectedText, index, id in
            if selectedText == "No"{
                self.PunchDayAPI()
                self.injuryPopUp.isHidden = true
                self.alphaImgVw.isHidden = true
            }
            else if selectedText == "Yes"{
                self.explainVw.isHidden = false
                
            }
        }
        
        expenseCategoryTxtFld.didSelect { selectedText, index, id in
            print("Selected Text \(selectedText)")
        }
        
        calendr.allowsMultipleSelection = true
    }
    
    func menuBtnAction(){
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        let menu = SideMenuNavigationController(rootViewController: vc)
        vc.menuDelegate = self
        present(menu, animated: true, completion: nil)
    }
    
    func sideMenuSetup(){
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "MenuVC") as! MenuVC
        vc.menuDelegate = self
        let leftMenuNavigationController = SideMenuNavigationController(rootViewController: vc)
        SideMenuManager.default.leftMenuNavigationController = leftMenuNavigationController
        
        // If you need your SideMenu to appear from the right side
        let rightMenuNavigationController = SideMenuNavigationController(rootViewController: vc)
        SideMenuManager.default.rightMenuNavigationController = rightMenuNavigationController
        
        //(Optional) Prevent status bar area from turning black when menu appears:
        leftMenuNavigationController.statusBarEndAlpha = 0
        
        //Copy all settings to the other menu
        rightMenuNavigationController.settings = leftMenuNavigationController.settings
        
        SideMenuManager.default.addPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.addScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
    }
  
    func Actions(){
        self.backBtn.actionBlock {
            SingleTon.shared.onRequest = false
            self.mainTblVw.rowHeight = 180
            self.topTitleLbl.text = ""
            self.backBtn.isHidden = true
            self.logoutBtn.isHidden = false
            self.tblArray = self.appProfileArr
            self.mainTblVw.reloadData()
        }
        //      NotificationCenter.default.addObserver(self, selector: #selector(openForNotification), name: Notification.Name("Accept"), object: nil)
        self.logoutBtn.actionBlock {
            //    self.logoutAlert()
            self.menuBtnAction()
        }
        
        self.calndrReasonImgVw.actionBlock {
            self.calendrReasonVw.isHidden = true
            self.okReasonBtn.setTitle("OK", for: .normal)
        }
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.injuryTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.injuryTxtFld.showList()
            return false
        }
        
        else if textField == self.expenseCategoryTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.expenseCategoryTxtFld.showList()
            return false
        }
        
        return true
    }
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        punchSwitch.setOn(SingleTon.shared.isClockedIn, animated: false)
       
        topTitleLbl.text = ""
        
        appProfileArr = SingleTon.shared.appProfileArr
        tblArray = self.appProfileArr
        //    SingleTon.shared.onRequest = false
        backBtn.isHidden = !SingleTon.shared.onRequest
        if SingleTon.shared.notificationType{
            
        }
    }
    
    @objc func openForNotification(){
        openPoseidon()
    }
    
    
    @IBAction func punchSwitchAction(_ sender: UISwitch) {
        SingleTon.shared.forRequest = false
        openCamera(tag: sender.tag)
    }
    
    
    
    func logoutAlert() {
        let alert = UIAlertController(title: "", message: "Are you want to logout", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action -> Void in
            self.logOutApi()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    
    
    func punchInListAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ClockInListUrl, method: .post, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : ClockInListModel?) in
            self.clockInListArray = success!.data.projects
            DispatchQueue.main.async {
                self.mainTblVw.rowHeight = 80
                SingleTon.shared.onRequest = true
                self.mainTblVw.reloadData()
                self.topTitleLbl.text = "Clock In/Out"
                self.backBtn.isHidden = false
                self.logoutBtn.isHidden = true
            }
        }
    }
    
    func CompletedRequestListAPI(){
        ApiFunc.shared.APIHeaderMethod(url: (ApiUrl.CompltedReqListUrl + SingleTon.shared.userToken.description), method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : CompletedRequestModel?) in
            self.completedRequestListArray = success!.data.completedRequest
            //            DispatchQueue.main.async {
            //                self.mainTblVw.rowHeight = 80
            //                SingleTon.shared.onRequest = true
            //                self.mainTblVw.reloadData()
            //                self.topTitleLbl.text = "Clock In/Out"
            //                self.backBtn.isHidden = false
            //                self.logoutBtn.isHidden = true
            //            }
        }
    }
    
    
    func PunchDayAPI(){
        let params = ["sessionToken" : SingleTon.shared.userToken,"lat" : lat,"long" : long,"image" :SingleTon.shared.punchImage,"injured" : explainTxtVw.text!] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.PunchDayUrl, method: .post, parameters: params) { [self] (success : PunchDayModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            SingleTon.shared.isClockedIn = ((success?.data.punch) != nil)
            SingleTon.shared.isClockedIn = success!.data.punch!
            punchSwitch.setOn(SingleTon.shared.isClockedIn, animated: true)
            injuryPopUp.isHidden = true
            self.alphaImgVw.isHidden = true
            explainVw.isHidden = true
            explainTxtVw.text = ""
            injuryTxtFld.text = ""
        }
    }
    
    
    
    
    @IBAction func okCalndrAction(_ sender: UIButton) {
        
        if sender.title(for: .normal) == "OK"{
            if calendr.selectedDates.count<1{
                AlertControl.shared.showOnlyAlert("Poseidon", message: "Kindly select dates for holidays")
            }
            else{
                holidaysArr.removeAll()
                for holiday in calendr.selectedDates{
                    let mydate = DateFormatter()
                    mydate.dateFormat = "yyyy/MM/dd"
                    let strDate = mydate.string(from: holiday)
                    holidaysArr.append(strDate)
                }
                calendrReasonVw.isHidden = false
                sender.setTitle("Apply", for: .normal)
            }
        }
        else{
            
        }
        
    }
    
    @IBAction func cancelCalendrAction(_ sender: UIButton) {
        GlobalCalendrVw.isHidden = true
        calendrReasonVw.isHidden = true
        alphaImgVw.isHidden = true
        okReasonBtn.setTitle("OK", for: .normal)
        for date in calendr.selectedDates{
            calendr.deselect(date)
        }
    }
    
    @IBAction func expenseSubmitBtnAction(_ sender: UIButton) {
        
        expenseVw.isHidden = true
        alphaImgVw.isHidden = true
        
    }
    
    @IBAction func expenseCancelBtnAction(_ sender: UIButton) {
        expenseTitleTxtFld.text = ""
        expensePriceTxtFld.text = ""
        expenseCategoryTxtFld.text = ""
        expenseVw.isHidden = true
        alphaImgVw.isHidden = true
    }
    
    
    
    
}

