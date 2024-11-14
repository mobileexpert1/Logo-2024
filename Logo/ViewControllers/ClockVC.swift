//
//  ClockVC.swift
//  Logo
//
//  Created by Mobile on 18/05/23.
//

import UIKit
import MSCircularSlider
import CoreLocation
import iOSDropDown

class ClockVC: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate, CLLocationManagerDelegate, UITextFieldDelegate {

    @IBOutlet weak var timerVw: MSCircularSlider!
    @IBOutlet weak var requestTblVw: UITableView!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var punchTimerLbl: UILabel!
    
    @IBOutlet weak var explainVw: UIView!
    @IBOutlet weak var explainTxtVw: UITextView!
    @IBOutlet weak var injuryPopUp: UIView!
    @IBOutlet weak var injuryTxtFld: DropDown!
    @IBOutlet weak var alphaImgVw: UIImageView!
    @IBOutlet weak var instructionVw: UIView!
    @IBOutlet weak var instructionCheckBoxVw: UIImageView!
    @IBOutlet weak var instructionNextBtn: UIButton!
    @IBOutlet weak var nextBtnVw: UIView!
    @IBOutlet weak var searchVw: UIView!
    @IBOutlet weak var searchTxtFld: DropDown!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var suggestedHideVw: UIView!
    
    @IBOutlet weak var bgImgVw: UIImageView!
    
    
    

    
    var clockInListArray = [ClockInListData]()
    var clockInListMainArray = [ClockInListData]()
    var imagePicker = UIImagePickerController()
    var lat = ""
    var long = ""
    var locManager : CLLocationManager?
    var requestedIndex = "0"
    var timer:Timer?
    var timeCount = 0
    var check = true
    let optionArr = ["Yes","No"]
    let suggArr = ["Suggested"]
    var projctId = 0
    var clockedInIdArray : [Int] = []
    var clockInType = "0"
    let distanceThreshold: CLLocationDistance = 1000 // 1 kilometer
    let updateInterval: TimeInterval = 600 // 10 minutes
    var locTimer:Timer?
    var isSuggested = false
    var iconView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateBackgroundColor()
        
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager!.requestWhenInUseAuthorization()
        locManager?.requestAlwaysAuthorization()
        
                // Configure location manager settings
        locManager!.distanceFilter = kCLDistanceFilterNone
        locManager!.desiredAccuracy = kCLLocationAccuracyBest
                
                // Start location updates with the specified time interval
        locManager!.startUpdatingLocation()
       locTimer = Timer.scheduledTimer(timeInterval: updateInterval, target: self, selector: #selector(updateLocation), userInfo: nil, repeats: true)

        iconView = UIImageView(frame:
                          CGRect(x: 10, y: 5, width: 20, height: 20))
           iconView.image = UIImage(named: "search")
           let iconContainerView: UIView = UIView(frame:
                          CGRect(x: 20, y: 0, width: 40, height: 30))
           iconContainerView.addSubview(iconView)
        searchTxtFld.leftView = iconContainerView
        searchTxtFld.leftViewMode = .always
               
               // Add the text field to the view
        requestTblVw.delegate = self
        requestTblVw.dataSource = self
        let nibClockTableViewCell = UINib(nibName: "ClockListTableViewCell", bundle: nil)
        requestTblVw.register(nibClockTableViewCell, forCellReuseIdentifier: "ClockListTableViewCell")
        requestTblVw.rowHeight = 90
        actionBlocks()
        injuryPopUp.clipsToBounds = true
        injuryPopUp.layer.cornerRadius = 10.0
        instructionVw.clipsToBounds = true
        instructionVw.layer.cornerRadius = 10.0
        instructionNextBtn.clipsToBounds = true
        instructionNextBtn.layer.cornerRadius = 5.0
        searchVw.clipsToBounds = true
        searchVw.layer.cornerRadius = 10.0
        searchTxtFld.delegate = self
        searchTxtFld.attributedPlaceholder = NSAttributedString(
            string: "Search",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white]
        )
        hideViews()
        suggestedHideVw.isHidden = true
        instructionNextBtn.setTitleColor(.lightGray, for: .disabled)
        instructionNextBtn.isEnabled = false
        
        injuryTxtFld.optionArray = optionArr
        
        injuryTxtFld.didSelect { selectedText, index, id in
            if selectedText == "No"{
                self.PunchAPI()
                self.injuryPopUp.isHidden = true
                self.alphaImgVw.isHidden = true
            }
            else if selectedText == "Yes"{
                self.explainVw.isHidden = false
            }
        }
        
        
        searchTxtFld.optionArray = suggArr
        searchTxtFld.didSelect { selectedText, index, id in
            print("Selected Text \(selectedText)")
            self.clockInType = "1"
            self.suggestedHideVw.isHidden = true
            self.punchInListAPI(type: "1")
            self.isSuggested = true
        }
    }
    
   
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        updateBackgroundColor()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        var currentLocation: CLLocation!
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager?.location
            lat = currentLocation.coordinate.latitude.description
            long = currentLocation.coordinate.longitude.description
            punchInListAPI(type: clockInType)
        }
    }
    
    
    
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
           super.traitCollectionDidChange(previousTraitCollection)

           // Update the background color when appearance mode changes
           updateBackgroundColor()
       }

    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
               
                if traitCollection.userInterfaceStyle == .dark {
              // Dark mode is enabled
                    searchVw.backgroundColor = ThemeColor.darkThemeCellBGColor
                    headerLbl.textColor = ThemeColor.darkThemeTextColor
                    backBtn.tintColor = ThemeColor.darkThemeImageTintColor
                    punchTimerLbl.textColor = ThemeColor.darkThemeTextColor
                    searchTxtFld.attributedPlaceholder = NSAttributedString(
                        string: "Search",
                        attributes: [NSAttributedString.Key.foregroundColor: ThemeColor.darkThemeTextColor]
                    )
                    searchTxtFld.textColor = ThemeColor.darkThemeTextColor
                    timerVw.unfilledColor = ThemeColor.lightThemeImageTintColor
                    iconView.tintColor = ThemeColor.darkThemeImageTintColor
                    bgImgVw.image = UIImage(named: "Dashboard2")
                    requestTblVw.reloadData()
                } else {
                    searchTxtFld.textColor = ThemeColor.lightThemeTextColor
                    searchVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                    punchTimerLbl.textColor = ThemeColor.lightThemeImageTintColor
                    headerLbl.textColor = ThemeColor.lightThemeImageTintColor
                    backBtn.tintColor = ThemeColor.lightThemeImageTintColor
                    iconView.tintColor = ThemeColor.lightThemeImageTintColor
                    timerVw.unfilledColor = .lightGray
                    searchTxtFld.attributedPlaceholder = NSAttributedString(
                        string: "Search",
                        attributes: [NSAttributedString.Key.foregroundColor: UIColor.black]
                    )
                    bgImgVw.image = UIImage(named: "Dashboard2Light")
                    requestTblVw.reloadData()
                }
            } else {
                // Fallback for earlier versions
            //    UIView.appearance().backgroundColor = .white
            }

            // Refresh the view hierarchy to apply the new background color
            view.setNeedsDisplay()
        }
    
    
    
    
    
    @objc func updateLocation() {
        locManager!.startUpdatingLocation()
        }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == searchTxtFld{
            suggestedHideVw.isHidden = false
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == searchTxtFld{
            suggestedHideVw.isHidden = true
            searchTxtFld.hideList()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var searchText = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        searchText = String(searchText.filter { !" \n\t\r".contains($0) })
        if searchText == ""{
            if isSuggested{
                punchInListAPI(type: "0")
            }
            else{
                clockInListArray = clockInListMainArray
                self.requestTblVw.reloadData()
            }
        }
        else{
            clockInListArray = clockInListMainArray.filter({ $0.fullName.lowercased().contains(searchText.lowercased()) })
            self.requestTblVw.reloadData()
        }
        
        return true
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
            self.timerVw.currentValue = Double(self.timeCount)
        }
    }

    
    func actionBlocks(){
        backBtn.actionBlock {
            if self.timer != nil{
                self.timer?.invalidate()
            }
            self.navigationController?.popViewController(animated: true)
        }
        alphaImgVw.actionBlock { [self] in
            hideViews()
            requestTblVw.reloadData()
            instructionNextBtn.isEnabled = false
            instructionCheckBoxVw.image = UIImage(named: "uncheckB")
        }
        
        instructionCheckBoxVw.actionBlock { [self] in
            if check{
                instructionCheckBoxVw.image = UIImage(named: "checkB")
                check = false
                instructionNextBtn.isEnabled = true
            }
            else{
                instructionCheckBoxVw.image = UIImage(named: "uncheckB")
                check = true
                instructionNextBtn.isEnabled = false
            }
        }
    }
    
    func hideViews(){
        alphaImgVw.isHidden = true
        injuryPopUp.isHidden = true
        instructionVw.isHidden = true
        check = true
        instructionNextBtn.isEnabled = false
        instructionCheckBoxVw.image = UIImage(named: "uncheckB")
        
    }
    
    func HideViewsExcept(Vw:UIView){
        alphaImgVw.isHidden = false
        injuryPopUp.isHidden = true
        instructionVw.isHidden = true
        Vw.isHidden = false
    }
    
    @objc func swtchAction(_ swtch:UISwitch){
        if SingleTon.shared.isPunchedIn{
            requestedIndex = swtch.tag.description
            if clockedInIdArray.count > 0{
                if SingleTon.shared.isClockedIn{
                    if swtch.isOn{
                        swtch.setOn(false, animated: true)
                    }
                    else{
                        HideViewsExcept(Vw: injuryPopUp)
                    }
                }
            }
            else{
                if SingleTon.shared.isClockedIn{
                    HideViewsExcept(Vw: injuryPopUp)
                }
                else{
                    HideViewsExcept(Vw: instructionVw)
                }
            }
        }
        else{
            if swtch.isOn{
                swtch.setOn(false, animated: true)
                AlertControl.shared.showOnlyAlert("Alert", message: "Kindly day login first then start your project clock In")
            }
            else{
                swtch.setOn(true, animated: true)
            }
        }
    }
    
    
    @IBAction func nextAction(_ sender: UIButton) {
        print("Next Tapped")
        instructionVw.isHidden = true
//        openCamera(tag: Int(requestedIndex)!)
        var currentLocation: CLLocation!
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = locManager?.location
            lat = currentLocation.coordinate.latitude.description
            long = currentLocation.coordinate.longitude.description
        }
        
        DispatchQueue.main.asyncAfter(wallDeadline: .now()+1.0) {
            self.explainTxtVw.text = ""
            self.PunchAPI()
        }
    }
    
    
    
    func openCamera(tag:Int){
        if(UIImagePickerController .isSourceTypeAvailable(.camera)){
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true, completion: nil)
            var currentLocation: CLLocation!
//                if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
//                        CLLocationManager.authorizationStatus() ==  .authorizedAlways
//                {
//                    currentLocation = locManager?.location
//                    lat = currentLocation.coordinate.latitude.description
//                    long = currentLocation.coordinate.longitude.description
//                }
            
        } else {
            let alertController: UIAlertController = {
                let controller = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .default)
                controller.addAction(action)
                hideViews()
                requestTblVw.reloadData()
                let indxPath = IndexPath(row: tag, section: 0)
                requestTblVw.scrollToRow(at: indxPath, at: .bottom, animated: false)
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
                requestTblVw.reloadData()
                let indxPath = IndexPath(row: Int(requestedIndex)!, section: 0)
                requestTblVw.scrollToRow(at: indxPath, at: .bottom, animated: false)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setUserPhoto(UserPhoto : UIImage){
        let imgData = UserPhoto.jpegData(compressionQuality: 0.5)
        let base64Data = imgData?.base64EncodedString()
        SingleTon.shared.punchImage = base64Data!
            DispatchQueue.main.asyncAfter(wallDeadline: .now()+1.0) {
                if SingleTon.shared.isClockedIn{
                    self.injuryPopUp.isHidden = false
                    self.alphaImgVw.isHidden = false
                }
                else{
                    self.explainTxtVw.text = ""
                    self.PunchAPI()
                }
        }
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {

        if explainTxtVw.text.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Kindly explain the injury")
        }
        else{
            var currentLocation: CLLocation!
            if CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                    CLLocationManager.authorizationStatus() ==  .authorizedAlways
            {
                currentLocation = locManager?.location
                lat = currentLocation.coordinate.latitude.description
                long = currentLocation.coordinate.longitude.description
            }
            
            DispatchQueue.main.asyncAfter(wallDeadline: .now()+1.0) {
                self.PunchAPI()
            }
        }
    }
    
    
    //MARK: PUNCH_API
    func PunchAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.PunchUrl, method: .post, parameters: ["sessionToken" : SingleTon.shared.userToken,"lat" : lat,"long" : long,"project" : clockInListArray[Int(requestedIndex)!].id.description]) { [self] (success : PunchModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            SingleTon.shared.Lat = CLLocationDegrees(lat)!
            SingleTon.shared.Long = CLLocationDegrees(long)!
            punchInListAPI(type: clockInType)
            hideViews()
            if (success?.status)!{
                SingleTon.shared.isClockedIn = success!.data.punch!
                if SingleTon.shared.isClockedIn == false{
                    locTimer?.invalidate()
                    if self.timer != nil{
                        self.timer?.invalidate()
                    }
                }
                
                if clockedInIdArray.contains(Int(clockInListArray[Int(requestedIndex)!].id)!) == false{
                    clockedInIdArray.append(Int(clockInListArray[Int(requestedIndex)!].id)!)
                }
                else{
                    clockedInIdArray.removeAll()
                    
                    timer?.invalidate()
                    punchTimerLbl.text = "00:00"
                    timerVw.currentValue = 0
                }
                
                let indxPath = IndexPath(row: Int(requestedIndex)!, section: 0)
                requestTblVw.scrollToRow(at: indxPath, at: .bottom, animated: false)
            }
            else{
                AlertControl.shared.showOnlyAlert("Poseidon", message: success!.message!)
            }
        }
    }
    
    
    
    func punchInListAPI(type : String){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ClockInListUrl, method: .post, parameters: ["sessionToken" : SingleTon.shared.userToken,"lat" : lat,"long" : long, "type" : type]) { [self] (success : ClockInListModel?) in
            self.clockInListArray = success!.data.projects
            self.clockInListMainArray = self.clockInListArray
            projctId = (success?.data.projectColockIn.projectId)!
            if projctId == 0{
                SingleTon.shared.isClockedIn = false
            }
            else{
                SingleTon.shared.isClockedIn = true
                clockedInIdArray.append(projctId)
                timeCount = (success?.data.projectColockIn.timeDifferece)!
                timerMethod()
            }
            
            DispatchQueue.main.async {
                self.requestTblVw.reloadData()
            }
        }
    }
    
    
    func UpdateLocationAPI(latt : CLLocationDegrees, longg : CLLocationDegrees){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.UpdateLocationUrl, method: .post, parameters: ["sessionToken" : SingleTon.shared.userToken,"lat" : lat,"long" : long]) { [self] (success : UpdateLocationModel?) in
            self.punchInListAPI(type: clockInType)
      //      AlertControl.shared.showOnlyAlert("Poseidon", message: success!.message)
       
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           guard let currentLocation = locations.last else { return }
           
           // Perform the desired action with the updated location
           print("Updated location: \(currentLocation.coordinate.latitude), \(currentLocation.coordinate.longitude)")
        UpdateLocationAPI(latt: currentLocation.coordinate.latitude, longg: currentLocation.coordinate.longitude)
           // Stop location updates if needed
        locManager!.stopUpdatingLocation()
       }
}

extension ClockVC:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clockInListArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = requestTblVw.dequeueReusableCell(withIdentifier: "ClockListTableViewCell", for: indexPath) as! ClockListTableViewCell
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        if traitCollection.userInterfaceStyle == .dark {
            cell.cellVw.backgroundColor = ThemeColor.darkThemeCellBGColor
            cell.projectNameLbl.textColor = ThemeColor.darkThemeTextColor
            cell.projectAddressLbl.textColor = ThemeColor.darkThemeTextColor
            cell.distanceLbl.textColor = ThemeColor.darkThemeTextColor
            cell.punchSwitch.thumbTintColor = ThemeColor.darkThemeTextColor
        }
        else{
            cell.cellVw.backgroundColor = ThemeColor.lightThemeCellBGColor
            cell.projectNameLbl.textColor = ThemeColor.lightThemeImageTintColor
            cell.projectAddressLbl.textColor = ThemeColor.lightThemeImageTintColor
            cell.distanceLbl.textColor = ThemeColor.lightThemeImageTintColor
            cell.punchSwitch.thumbTintColor = ThemeColor.lightThemeImageTintColor
        }
        
        cell.projectNameLbl.text = clockInListArray[indexPath.row].fullName
        cell.projectAddressLbl.text = clockInListArray[indexPath.row].address
        cell.distanceLbl.text = clockInListArray[indexPath.row].distance
        if clockInListArray[indexPath.row].clockedInStatus == 0{
            cell.punchSwitch.setOn(false, animated: true)
        }
        else{
            cell.punchSwitch.setOn(true, animated: false)
        }
        cell.punchSwitch.tag = indexPath.row
        cell.punchSwitch.addTarget(self, action: #selector(swtchAction), for: .valueChanged)
        
        return cell
    }
    
    
}
