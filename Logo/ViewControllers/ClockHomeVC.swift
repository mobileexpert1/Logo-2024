//
//  ClockHomeVC.swift
//  Logo
//
//  Created by Vishal on 16/05/24.
//

import UIKit
import MSCircularSlider
import CoreLocation
import PKHUD
import iOSDropDown

class ClockHomeVC: UIViewController, CLLocationManagerDelegate {
    @IBOutlet weak var profileImgVw: UIImageView!
    @IBOutlet weak var logoutBtn: UIImageView!
    
    
    @IBOutlet weak var super_VW: UIView!
    @IBOutlet weak var switch_Top: UISwitch!
    
    @IBOutlet weak var vwtop: UIView!
    
    @IBOutlet weak var btn_Noti: UIImageView!
    
    @IBOutlet weak var punchTimerLbl: UILabel!
    @IBOutlet weak var circllarSlider: MSCircularSlider!
    
    //topvw
    @IBOutlet weak var timer_TopVw: UIView!
    @IBOutlet weak var noOfProjectsLbl: UILabel!
    
    @IBOutlet weak var lbl_Welcome: UILabel!
    
    @IBOutlet weak var lbl_TitleName: UILabel!
    
    //Backbtn
    
    @IBOutlet weak var btn_Back: UIButton!
    
    @IBOutlet weak var pinchday: UILabel!
    
    //imgvwarrowbtn
    
    @IBOutlet weak var vw_ProjectNo: UIView!
    
    @IBOutlet weak var img_ExpArrow: UIButton!
    
    
    @IBOutlet weak var clockIn: UILabel!
    
    
    @IBOutlet weak var alphaImgVw: UIImageView!
    
    
    @IBOutlet weak var slider_Img: UIImageView!
    
    @IBOutlet weak var injuryTxtFld: DropDown!
    
    @IBOutlet weak var injuryPopUp: UIView!
    
    
    @IBOutlet weak var injuryTxtVw: UITextView!
    @IBOutlet weak var explainVw: UIView!
    
    
    var StartDate : Date?
    var EndDate : Date?
    
    let optionArr = ["Yes","No"]
    var timer:Timer?
    var timeCount = 0
    var clockedInIdArray : [Int] = []
    var profileImg : UIImage = UIImage(named: "user")!
    var locManager : CLLocationManager?
    var lat = ""
    var long = ""
    var loginrequest = [Request]()
    var imagePicker = UIImagePickerController()
    let testView = RoundBeveledView()
    var isOpenCameraForExpense = false
    let labelTime = UILabel()
    let StartTimeLabel = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        didLoadMethods()
        injuryTxtFld.delegate = self
        injuryPopUp.clipsToBounds = true
        injuryPopUp.layer.cornerRadius = 10.0
        HideViews()
    
        
        
    }
    
    
    // MARK: - VIEW_WILL_APPEAR
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
        dashboardDataAPI()
        
        setUiSlider()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
     //   setUiSlider()
    }
    
    func setUiSlider(){
        labelTime.textColor = .black
        labelTime.textAlignment = .center
        
        testView.addSubview(labelTime)
        SetUI()
        UIViewSetting()
        labelTime.font = UIFont.systemFont(ofSize: 25)
        labelTime.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelTime.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            labelTime.centerYAnchor.constraint(equalTo: testView.centerYAnchor)
        ])
        testView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(testView)
        
        let topConstraint = NSLayoutConstraint(item: testView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 164)
        //let topConstraint = NSLayoutConstraint(item: testView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1.0, constant: 170)
        topConstraint.isActive = false
        let g = circllarSlider.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
           
            testView.heightAnchor.constraint(equalTo: testView.widthAnchor),
            testView.centerXAnchor.constraint(equalTo: g.centerXAnchor),
            testView.centerYAnchor.constraint(equalTo: g.centerYAnchor),
           
        ])
        
        StartTimeLabel.text = "Start"
        StartTimeLabel.textColor = .black
        StartTimeLabel.textAlignment = .center
        StartTimeLabel.font = UIFont.systemFont(ofSize: 18)
        StartTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        testView.addSubview(StartTimeLabel)
        
        
        NSLayoutConstraint.activate([
            StartTimeLabel.centerXAnchor.constraint(equalTo: testView.centerXAnchor),
            StartTimeLabel.topAnchor.constraint(equalTo: labelTime.bottomAnchor, constant: 10)
            
        ])
    }
    
    func actionBlocks(){
        
        circllarSlider.actionBlock { [self] in
            isOpenCameraForExpense = false
            if SingleTon.shared.isPunchedIn{
                HideViewsExcept(Vw: injuryPopUp)
                //  pinchday.text = "End"
            }
            else{
                openCamera()
                //                if isOpenCameraForExpense == false {
                //                    pinchday.text = "Start"
                //                }else{
                //                    print ("not open camer")
                //                }
            }
        }
        testView.actionBlock { [self] in
            isOpenCameraForExpense = false
            if SingleTon.shared.isPunchedIn{
                HideViewsExcept(Vw: injuryPopUp)
                //  pinchday.text = "End"
            }
            else{
                openCamera()
                
            }
        }
        
        clockIn.actionBlock {
            self.openClockInVC()
            self.addHapticFeedback()
            print("clockInOutVw Tapped")
        }
        logoutBtn.actionBlock { [self] in
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
    
    // MARK: - HIDE_ALL_VIEWS_EXCEPT_A_VIEW
    func HideViewsExcept(Vw:UIView){
        alphaImgVw.isHidden = false
        testView.isHidden = true
        //  expenseVw.isHidden = true
        //            GlobalCalendrVw.isHidden = true
        //            createProjectPopUpVw.isHidden = true
        UIView.transition(with: Vw, duration: 0.4,
                          options: .transitionCrossDissolve,
                          animations: {
            Vw.isHidden = false
        })
    }
    
    
    func openClockInVC(){
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ClockVC") as! ClockVC
        if self.timer != nil{
            self.timer?.invalidate()
        }
        self.navigationController?.pushViewController(VC, animated: true)
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
    
    func LocationDidloadRequirements(){
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager!.requestWhenInUseAuthorization()
        locManager?.requestAlwaysAuthorization()
        
    }
    
    
    @IBAction func submitInjuryBtnAction(_ sender: UIButton) {
        
        if injuryTxtVw.text.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Kindly explain the injury")
        }
        else{
            self.PunchDayAPI()
        }
    }
    // MARK: - PUNCH_DAY_API
    func PunchDayAPI(){
        
        if SingleTon.shared.punchImage.isEmpty{
            let img = UIImage(named: "user")
            let imgData = img!.jpegData(compressionQuality: 0.5)
            let base64Data = imgData?.base64EncodedString()
            SingleTon.shared.punchImage = base64Data!
        }
        let params = ["sessionToken" : SingleTon.shared.userToken,"lat" : lat,"long" : long,"image" :SingleTon.shared.punchImage,"injured" : ""] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.PunchDayUrl, method: .post, parameters: params) { [self] (success : PunchDayModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            if success?.message == "Can't clockout before one hour"{
                //dayPunchSwitch.setOn(true, animated: true)
                timerMethod()
                //pinchday.text = "End"
                StartTimeLabel.text = "End"
                return
            }
            print("success?.data.punch", success?.data.punch)
            SingleTon.shared.isPunchedIn = ((success?.data.punch) != nil)
            SingleTon.shared.isPunchedIn = ((success?.data.punch) != nil)
            // SingleTon.shared.isPunchedIn = success!.data.punch!
            // print("success!.data.punch!--->", success!.data.punch!)
            //   dayPunchSwitch.setOn(SingleTon.shared.isPunchedIn, animated: true)
            
            if SingleTon.shared.isPunchedIn{
                timerMethod()
                //   pinchday.text = "End"
                StartTimeLabel.text = "End"
            }
            else{
                timer?.invalidate()
                punchTimerLbl.text = "00:00"
                self.labelTime.text = "00:00"
                circllarSlider.currentValue = 0
            }
        }
    }
    func HideViews(){
        alphaImgVw.isHidden = true
        testView.isHidden = false
        
        injuryPopUp.isHidden = true
        StartDate = nil
        EndDate = nil
        
        
        
    }
    
    
    
    // MARK: - VIEW_DID_LOAD_CALLING_METHODS
    func didLoadMethods(){
        
        LocationDidloadRequirements()
        actionBlocks()
        profileImgVw.clipsToBounds = true
        profileImgVw.layer.cornerRadius = 20
        profileImgVw.contentMode = .scaleToFill
        applyStyling(to: vw_ProjectNo)
        
        self.injuryTxtFld.optionArray = self.optionArr
        self.injuryTxtFld.didSelect { selectedText, index, id in
            if selectedText == "No"{
                self.PunchDayAPI()
                self.injuryPopUp.isHidden = true
                self.alphaImgVw.isHidden = true
                self.testView.isHidden = false
            }
            else if selectedText == "Yes"{
                self.explainVw.isHidden = false
                
            }
        }
        
        
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
            
            
            profileImgVw.sd_setImage(with: URL(string: ApiUrl.ProfileImgBase + dashboardData.profilePic), placeholderImage: UIImage(named: "user"))
            profileImg = profileImgVw.image!
            lbl_TitleName.text = dashboardData.userName
            
            noOfProjectsLbl.text = dashboardData.projectCount.description
           
            if dashboardData.punchData == 0{
                //  dayPunchSwitch.setOn(false, animated: false)
                punchTimerLbl.text = "00:00"
                labelTime.text = "00:00"
                timeCount = 0
                if timer != nil{
                    timer?.invalidate()
                }
            }
            else{
                //  dayPunchSwitch.setOn(true, animated: true)
                timeCount = dashboardData.punchData
                timerMethod()
                // pinchday.text = "End"
                StartTimeLabel.text = "End"
            }
        }
    }
    
    
    
    
    // MARK: - CLOCK_TIMER_METHOD
    func timerMethod(){
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            
            self.timeCount += 1
            print("Timer fired! \(timeCount)")
            let hourValue = self.timeCount/3600
            let hourRemValue = self.timeCount%3600
            let minValue = hourRemValue/60
            let minRemValue = hourRemValue%60
            
            var hourValueStr = ""
            var minValueStr = ""
            
            if hourValue<10{
                hourValueStr = "0\(hourValue.description)"
            }
            else{
                hourValueStr = hourValue.description
            }
            if minValue<10{
                minValueStr = "0\(minValue.description)"
            }
            else{
                minValueStr = minValue.description
            }
            self.punchTimerLbl.text = "\(hourValueStr):\(minValueStr)"
            self.labelTime.text = "\(hourValueStr):\(minValueStr)"
            self.circllarSlider.currentValue = Double(self.timeCount)
            
        }
    }
    func applyStyling(to view: UIView) {
        
        view.layer.cornerRadius = 12
        //view.backgroundColor = UIColor.white
        view.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
        view.layer.shadowOpacity = 1.5
        view.layer.shadowRadius = 4
        vwtop.roundCorners(corners: [.topLeft, .topRight], radius: 30, newWidth: self.view.frame.width)
    }
    
    
    
}
extension ClockHomeVC:UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
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
    
    func UIViewSetting() {
        circllarSlider.unfilledColor = UIColor(red: 197/255, green: 204/255, blue: 221/255, alpha: 1.0)
        //circllarSlider.unfilledColor = .gray
    }
    
    
    // MARK: - VIEW_DID_LOAD_CALLING_METHODS
    func SetUI(){
        circllarSlider.handleType = .mediumCircle
        circllarSlider.handleColor = UIColor(red: 30/255, green: 46/255, blue: 134/255, alpha: 1.0)
        circllarSlider.filledColor = UIColor(red: 30/255, green: 46/255, blue: 134/255, alpha: 1.0)
        circllarSlider.currentValue = Double(timeCount)
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
                
                //  self.HideViewsExcept(Vw: self.expenseVw)
                // self.recieptImgVw.image = UserPhoto
            }
        }
        else{
            PunchDayAPI()
        }
    }
    
    
    
    
}
extension ClockHomeVC : UITextFieldDelegate{
    // MARK: - TEXTFIELD_DELEGATES
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.injuryTxtFld{
            textField.endEditing(true)
            self.isEditing = false
            self.injuryTxtFld.showList()
            return false
        }
        
        return true
    }
}
