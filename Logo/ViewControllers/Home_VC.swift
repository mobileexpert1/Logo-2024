//
//  Home_VC.swift
//  Logo
//
//  Created by Nihal kamboj on 04/03/22.
//

import UIKit
import Alamofire
import YYCalendar
import PKHUD
import CoreLocation

class Home_VC: UIViewController, CLLocationManagerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Variables
    var newImage = UIImage()
    var selectedDate = String()
    let blrView = UIView()
    var mainView = UIView()
    var loginrequest = [Request]()
    var selectedIndex = 0
    var dateForRequest = ""
    var AcceptIndex = 0
    
    //MARK: - Home_VC OUTLETS
    @IBOutlet weak var inspectionType: UILabel!
    @IBOutlet weak var noReqLbl: UILabel!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var logOutBtn: UIButton!
    @IBOutlet weak var refreshBtn: UIButton!
    
    @IBOutlet weak var notes: UITextView!
  
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var roundCornerView: UIView!
    @IBOutlet weak var homeTableView: UITableView!
    
    //MARK: - popUP Outlets
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var popContent_VW: UIView!
    @IBOutlet weak var popRemoveBtn: UIButton!
    @IBOutlet weak var popUserImage: LazyImageView!
    @IBOutlet weak var makeReportBtn: UIButton!
    
    @IBOutlet weak var agreeStackVw: UIStackView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejecttBtn: UIButton!
    
    
    @IBOutlet weak var userTxtLabel_pop: PaddingLabel!
    @IBOutlet weak var numberTxtLabel_pop: PaddingLabel!
    @IBOutlet weak var locationTxtLabel_pop: PaddingLabel!
    
    @IBOutlet weak var allListBtn: UIImageView!
    @IBOutlet weak var calendarBtn: UIImageView!
    @IBOutlet weak var downHEaderVw: UIView!
    
    
 //   @IBOutlet weak var punchSwitch: UISwitch!
//    @IBOutlet weak var punchLbl: UILabel!
    
    var lat = ""
    var long = ""
    var locManager : CLLocationManager?
    var window: UIWindow?
    var imagePicker = UIImagePickerController()
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("Accept"), object: nil)
    }
    
    var inspectTypePopUp:InspectionTypePopup!
    //MARK: - VIEW DIDLOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        // -- Register Table Cells
    //    punchLbl.text = ""
        makeReportBtn.isHidden = true
        locManager = CLLocationManager()
        locManager!.delegate = self
        locManager!.requestWhenInUseAuthorization()
        locManager?.requestAlwaysAuthorization()
        SectionDataHandler.shared.isFormCompletelyFilledForIndexes.removeAll()
     
        homeTableView.estimatedRowHeight = 120
        homeTableView.rowHeight = UITableView.automaticDimension
        Home_TBlVwCell.registerTableCell(for: homeTableView)
       
        // -- Calendar Button
        calendarBtn.actionBlock {
            let calendar = YYCalendar(normalCalendarLangType: .ENG, date: Date().toString(dateFormat: "yyyy-MM-dd"), format: "yyyy-MM-dd") { [self] date in
                print(date)
              //  self.requestApi(date)
                self.allRequestApi()
                dateForRequest = date
            }
            calendar.show()
        }
        
        // -- All List Data Button














        allListBtn.actionBlock {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "AllListHomeVC")as! AllListHomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.isNavigationBarHidden = true
        updateBackgroundColor()
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        print("at home will appear :: userToken -> ",SingleTon.shared.userToken)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let str = dateFormatter.string(from: Date())
        print(str)
        dateForRequest = str
  //      self.requestApi(str)
        self.allRequestApi()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setUI()
    }
    
    
    
    
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                downHEaderVw.backgroundColor = ThemeColor.darkThemeCellBGColor
                homeTableView.backgroundColor = ThemeColor.darkThemeCellBGColor
                homeTableView.reloadData()
                refreshBtn.tintColor = .red
                calendarBtn.tintColor = .white
                allListBtn.tintColor = .white
                self.view.backgroundColor = ThemeColor.darkThemeCellBGColor
                popContent_VW.backgroundColor = ThemeColor.darkThemeCellBGColor
            }
            else{
                allListBtn.tintColor = ThemeColor.lightThemeImageTintColor
                calendarBtn.tintColor = ThemeColor.lightThemeImageTintColor
                refreshBtn.tintColor = ThemeColor.lightThemeImageTintColor
                downHEaderVw.backgroundColor = .white
                homeTableView.backgroundColor = .white
                homeTableView.reloadData()
                self.view.backgroundColor = .white
                refreshBtn.tintColor = .black
                
            }
        }
        }
    
    
    
//MARK: - New Added on 28 Oct (AK)
    @IBAction func makrReportBtn(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "MenualReportVC") as!  MenualReportVC
        SingleTon.shared.isMakeMenualReport = false
//        ClearDataClass.removeAllValues()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func backBtn(_ sender: Any) {
            self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func acceptAction(_ sender: UIButton) {
        self.ChageRequestStatusAPI(index: AcceptIndex, status: "1")
        
    }
    
    @IBAction func rejectAction(_ sender: UIButton) {
        
        self.ChageRequestStatusAPI(index: AcceptIndex, status: "2")
    }
    
    
    
    
    @IBAction func home_Vc_BtnAction(_ sender: UIButton) {
        switch sender.tag {
        case 0://--logout Button
            logoutAlert()
            //            self.PopToViewControllert(vc: Home_VC.self)
            //            self.navigationController?.popToRootViewController(animated: true)
        case 1://-- NotificationBurtton
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "Notification_VC")as! Notification_VC
            self.navigationController?.pushViewController(vc, animated: true)
        case 2://-- REFRESH BUTTON
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let str = dateFormatter.string(from: Date())
            print(str)
          //  self.requestApi(str)
            self.allRequestApi()
        case 3://-- POP REMOVE BUTTON
            UIView.transition(with: self.view, duration: 1, options: [.transitionCrossDissolve], animations: {
                self.popUpView.removeFromSuperview()
            }, completion: nil)
        case 4://-- MAKE REPORT BUTTON
            
//            var requestDict = [String:Any]()
//
//            requestDict["index"] = selectedIndex
//            requestDict["model"] = loginrequest[selectedIndex]
//            requestDict["clientName"] = SingleTon.shared.clientName
//            requestDict["inspectorName"] = SingleTon.shared.inspectorName
//            print(requestDict)
//            Indicator.sharedInstance.showIndicator()
            //self.pushWithData("Form_VC", requestDict)
            ClearDataClass.removeAllValues()
            //showInspectPopUp()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SectionTitlesViewController") as! SectionTitlesViewController
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    
    func showInspectPopUp(){
        inspectTypePopUp = InspectionTypePopup()
        inspectTypePopUp?.cancelButton.actionBlock { [weak self] in
            guard let self = self else { return }
            self.inspectTypePopUp.removeFromSuperview()
        }
        inspectTypePopUp?.nextBtn.actionBlock { [weak self] in
            guard let self = self else { return }
            //Indicator.sharedInstance.showIndicator()
            //let vc = self.storyboard?.instantiateViewController(withIdentifier: "Form_VC") as! Form_VC
           
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SectionTitlesViewController") as! SectionTitlesViewController
            self.navigationController?.pushViewController(vc, animated: true)
             self.inspectTypePopUp?.removeFromSuperview()
            self.inspectTypePopUp = nil
           }
        self.navigationController?.view.addSubview(self.inspectTypePopUp)
        self.inspectTypePopUp.frame = (self.navigationController?.view.frame)!
        //self.tabBarController?.view.addSubview(self.completeKyc)
       
    }
    
    
    
    
    
    func setUI() {
        homeTableView.separatorStyle = .none
        homeTableView.separatorColor = .blue
        //--POP UI SET
        userTxtLabel_pop.layer.cornerRadius = 5
        numberTxtLabel_pop.layer.cornerRadius = 5
        locationTxtLabel_pop.layer.cornerRadius = 5
        //---------
        //baseView.backgroundColor = UIColor(named: "Main_Color")
        baseView.backgroundColor = UIColor(red: 0/255, green: 66/255, blue: 138/255, alpha: 1.0)
        self.capsuleButton(makeReportBtn)
        makeReportBtn.clipsToBounds = true
        self.setButtonImage(image: UIImage(named: "cross")!, Btn: popRemoveBtn)
        self.setButtonImage(image: UIImage(named: "bell")!, Btn: notificationBtn)
        self.setButtonImage(image: UIImage(named: "logout_white") ?? UIImage(), Btn: logOutBtn)
        self.setButtonImage(image: UIImage(named: "reload")!, Btn: refreshBtn)
        
        popUserImage.layer.cornerRadius = 10
        popUserImage.clipsToBounds = true
        roundCornerView.roundCorners([.topRight,.topLeft], radius: 40)
        popContent_VW.roundCorners([.topRight,.topLeft], radius: 40)
    }
    
    func setButtonImage(image: UIImage, Btn:UIButton) {
        Btn.setImage (image, for: .normal)
        Btn.imageView?.contentMode = .scaleAspectFit
        Btn.contentHorizontalAlignment = .fill
        Btn.contentVerticalAlignment = .fill
    }
    
    func logoutAlert() {
        let alert = UIAlertController(title: "", message: "Are you want to logout", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action -> Void in
            self.logOutApi()
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        self.present(alert, animated: true, completion: nil)
    } 
}

//MARK: - TABLE VIEW
extension Home_VC: UITableViewDelegate,UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loginrequest.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = homeTableView.dequeueReusableCell(withIdentifier: "Home_TBlVwCell", for: indexPath)as! Home_TBlVwCell
        if traitCollection.userInterfaceStyle == .dark {
            cell.backgroundColor = ThemeColor.darkThemeCellBGColor
            cell.baseView_HomeCell.backgroundColor = ThemeColor.lightThemeImageTintColor
        }
        else{
            cell.backgroundColor = .white
        }
        cell.selectionStyle = .none
        cell.dateLbl.text = loginrequest[indexPath.row].assignedDate + "  " + loginrequest[indexPath.row].assignedTime
        cell.nameLabel_HomeCell.text = loginrequest[indexPath.row].fullName
        cell.lbladdress.text = loginrequest[indexPath.row].addressLine1
        cell.locationLabel_HomeCell.text = loginrequest[indexPath.row].addressLine1 + ", " + loginrequest[indexPath.row].city + ", " + loginrequest[indexPath.row].state
        cell.inspectionTypeLbl.text = loginrequest[indexPath.row].inspectionType
        
        cell.leftImg_HomeCell.circleView(view: cell.leftImg_HomeCell)
        if loginrequest[indexPath.row].profileImage != "" {
            cell.leftImg_HomeCell.setNetworkImage(cell.leftImg_HomeCell, ApiUrl.ProfileImgBase + loginrequest[indexPath.row].profileImage)
        } else {
            cell.leftImg_HomeCell.setNetworkImage(cell.leftImg_HomeCell, ApiUrl.ProfileImgBase + "userImages/defaultImage.png")
        }
        
//        let myImg = ApiUrl.ProfileImgBase + loginrequest[indexPath.row].profileImage
//        let imageUrl = URL(string: myImg)!
//        cell.leftImg_HomeCell.loadImage(fromURL: imageUrl, placeHolderImage: "user")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //        switch UIDevice.current.userInterfaceIdiom {
        //        case .phone:
        //            return 120
        //        case .pad:
        //            return 180
        //        default:
        //            return 100
        //        }
        
        return UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (indexPath.row)
        
        if loginrequest[indexPath.row].inspectorInspectionStatus == "0"{
          //  openActionSheet(index: indexPath.row)
            agreeStackVw.isHidden = false
            AcceptIndex = indexPath.row
            makeReportBtn.isHidden = true
        }
        else{
            agreeStackVw.isHidden = true
            makeReportBtn.isHidden = false
        }
            
//            let filtered = loginrequest.filter { $0.id == SingleTon.shared.reqesedtUserId }
//            print(filtered)
            
            
            SingleTon.shared.reqesedtUserId = loginrequest[indexPath.row].id
            
            
            
            selectedIndex = indexPath.row
            
            
            UIView.transition(with: self.view, duration: 1, options: [.curveEaseIn], animations: {
                self.view.addSubview(self.popUpView)
            }, completion: nil)
            
            popUpView.updatePopUpViewConstraints(Of: popUpView, to: self.view)
            userTxtLabel_pop.text = loginrequest[indexPath.row].fullName
            inspectionType.text = loginrequest[indexPath.row].inspectionType
            numberTxtLabel_pop.text = loginrequest[indexPath.row].mobileNumber
            locationTxtLabel_pop.text = loginrequest[indexPath.row].addressLine1 + ", " + loginrequest[indexPath.row].city + ", " + loginrequest[indexPath.row].state
        notes.text = "    "+loginrequest[indexPath.row].notes
        print(loginrequest[indexPath.row].notes)
            let myImg = ApiUrl.ProfileImgBase + loginrequest[indexPath.row].profileImage
            let imageUrl = URL(string: myImg)!
            
            SingleTon.shared.clientName = loginrequest[indexPath.row].fullName
            SingleTon.shared.requestStreetNuber = loginrequest[indexPath.row].streetNumber
            SingleTon.shared.requestAddressLine1 = loginrequest[indexPath.row].addressLine1
            SingleTon.shared.requestAddressLine2 = loginrequest[indexPath.row].addressLine2
            SingleTon.shared.requestCity = loginrequest[indexPath.row].city
            SingleTon.shared.requestState = loginrequest[indexPath.row].state
            SingleTon.shared.postalCode = loginrequest[indexPath.row].postalCode
    
            
            popUserImage.loadImage(fromURL: imageUrl, placeHolderImage: "user")
        
    }
    
    
    
    func openReportPopUp(index:Int){
        selectedIndex = index
        UIView.transition(with: self.view, duration: 1, options: [.curveEaseIn], animations: {
            self.view.addSubview(self.popUpView)
        }, completion: nil)
        
        popUpView.updatePopUpViewConstraints(Of: popUpView, to: self.view)
        userTxtLabel_pop.text = loginrequest[index].fullName
        inspectionType.text = loginrequest[index].inspectionType
        numberTxtLabel_pop.text = loginrequest[index].mobileNumber
        locationTxtLabel_pop.text = loginrequest[index].addressLine1 + ", " + loginrequest[index].city + ", " + loginrequest[index].state
        let myImg = ApiUrl.ProfileImgBase + loginrequest[index].profileImage
        let imageUrl = URL(string: myImg)!
        
        SingleTon.shared.clientName = loginrequest[index].fullName
        SingleTon.shared.requestStreetNuber = loginrequest[index].streetNumber
        SingleTon.shared.requestAddressLine1 = loginrequest[index].addressLine1
        SingleTon.shared.requestAddressLine2 = loginrequest[index].addressLine2
        SingleTon.shared.requestCity = loginrequest[index].city
        SingleTon.shared.requestState = loginrequest[index].state
        SingleTon.shared.postalCode = loginrequest[index].postalCode
        
        popUserImage.loadImage(fromURL: imageUrl, placeHolderImage: "user")
    }
    
    // MARK: - ActionSheet
    func openActionSheet(index:Int) {
        let alertController = UIAlertController(title: "Poseidon", message: nil, preferredStyle: .actionSheet)
        let sendButton = UIAlertAction(title: "Accept", style: .default, handler: { (action) -> Void in
            self.ChageRequestStatusAPI(index: index, status: "1")
        })
        
        let  deleteButton = UIAlertAction(title: "Reject", style: .default, handler: { (action) -> Void in
            self.ChageRequestStatusAPI(index: index, status: "2")
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            self.acceptRejectAPI(index: index)
        })
        alertController.addAction(sendButton)
        alertController.addAction(deleteButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    @objc func acceptRejectAPI(index:Int){
       print("Tapped")
        
        
    }
    
    // MARK: - Webservices
    func requestApi(_ selectedDate: String) {
        SingleTon.shared.clientName = ""
        loginrequest = [Request]()
        ApiFunc.shared.requestApi(self.view, selectedDate: selectedDate) { responseModel in
            if responseModel.status == true {
                SingleTon.shared.inspectorName = responseModel.data.inspectorName//responseModel.inspectorName
                self.loginrequest = responseModel.data.requests
                if responseModel.data.requests.count == 0 {
                    self.noReqLbl.isHidden = false
                } else {
                    self.noReqLbl.isHidden = true
                }
                self.homeTableView.dataSource = self
                self.homeTableView.delegate = self
                self.homeTableView.reloadData()
                if SingleTon.shared.notificationType{
                    SingleTon.shared.notificationType = false
           //         let filtered = self.loginrequest.filter { $0.id == SingleTon.shared.reqesedtUserId }
                    for i in 0..<self.loginrequest.count{
                        if SingleTon.shared.reqesedtUserId == self.loginrequest[i].id{
                            self.openReportPopUp(index: i)
                            self.AcceptIndex = i
                            return
                        }
                    }
                }
            } else {
                HUD.flash(.labeledError(title: "", subtitle: responseModel.message), delay: 1.0)
            }
        }
    }
    
    
    //MARK: CHANGEREQUESTSTATUS_API
    @objc func ChageRequestStatusAPI(index:Int,status:String){
        print("Tapped")
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ChageRequestStatusUrl, method: .post, parameters: ["sessionToken" : SingleTon.shared.userToken,"type" : status,"requestId" : loginrequest[index].id]) { [self] (success : ChageRequestStatusModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            self.allRequestApi()
            let indxPath = IndexPath(row: index, section: 0)
            self.homeTableView.scrollToRow(at: indxPath, at: .bottom, animated: false)
            UIView.transition(with: self.view, duration: 1, options: [.transitionCrossDissolve], animations: {
                self.popUpView.removeFromSuperview()
            }, completion: nil)
            if status == "1"{
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    let vc = storyboard?.instantiateViewController(withIdentifier: "SectionTitlesViewController") as!  SectionTitlesViewController
                    SingleTon.shared.isMakeMenualReport = false
            //        ClearDataClass.removeAllValues()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    
    func allRequestApi() {
        SingleTon.shared.clientName = ""
        loginrequest = [Request]()
        ApiFunc.shared.allRequestsApi(self.view) { responseModel in
            if responseModel.status == true {
                SingleTon.shared.inspectorName = responseModel.data.inspectorName
                self.loginrequest = (responseModel.data.requests)
                if responseModel.data.requests.count == 0 {
                    self.noReqLbl.isHidden = false
                } else {
                    self.noReqLbl.isHidden = true
                }
                self.homeTableView.dataSource = self
                self.homeTableView.delegate = self
                self.homeTableView.reloadData()
            } else {
                HUD.flash(.labeledError(title: "", subtitle: responseModel.message), delay: 1.0)
            }
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
       
}

/*
func requestsApi(_ selectedDate: String, completion: @escaping(_ : RequestModel) -> Void) {
    var semaphore = DispatchSemaphore (value: 0)

   let parameters = "filterByDate=\(selectedDate)&sessionToken=\(SingleTon.shared.userToken)"
   // let parameters = "sessionToken=\(SingleTon.shared.userToken)"
    let postData = parameters.data(using: .utf8)
    
    var request = URLRequest(url: URL(string: "http://poseidon-fire.com/api/inspector/dashboard")!,timeoutInterval: 120)
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    request.addValue("ci_session=030bb998d231b45ab2d7ec0da9001798ed22ca99", forHTTPHeaderField: "Cookie")

    request.httpMethod = "POST"
    request.httpBody = postData
    
    Indicator.sharedInstance.showIndicator()
    if Connectivity.isConnectedToInternet {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                return
            }
            if httpResponse.statusCode == 200 {
                guard let data = data else {
                    print(String(describing: error))
                    semaphore.signal()
                    return
                }
                print(String(data: data, encoding: .utf8)!)
                do {
                        let dataResponse = try JSONDecoder().decode(RequestModel.self, from: data)
                        print("response data:", dataResponse)
                   DispatchQueue.main.async {
                        completion(dataResponse)
                    }
                    
//                        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String: Any]
//                        print(json)
//
//                        if let status = json["status"] as? Bool {
//                            print(status)
//                            if status == true {
//
//                                if let requests = json["requests"] as? [[String:Any]] {
//                                    print(requests)
//
//                                    DispatchQueue.main.async {
//                                        if requests.count == 0 {
//                                            self.noRequestLbl.isHidden = false
//                                        } else {
//                                            for i in 0..<requests.count {
//                                                self.requestsArr.append(requests[i])
//                                            }
//                                            print(self.requestsArr)
//                                            self.noRequestLbl.isHidden = true
//                                        }
//                                        self.listTblView.reloadData()
//                                    }
//                                }
//
//                            } else {
//                                if let message = json["message"] as? String {
//                                    self.showOnlyAlert("Alert", message: message)
//                                }
//                            }
//                        }
                    
                } catch {
                    print("error====-=-=*******", error)
                }
            } else if httpResponse.statusCode == 401 {
                let refreshAlert = UIAlertController(title: "Alert", message: "Token Expired", preferredStyle: UIAlertController.Style.alert)
                SingleTon.shared.userToken = ""
                refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                    let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
                    UIApplication.shared.currentWindow?.rootViewController = loginVC
                    UIApplication.shared.currentWindow?.makeKeyAndVisible()
                }))
                
                UIApplication.shared.currentWindow?.rootViewController?.present(refreshAlert, animated: true, completion: nil)
            } else {
                HUD.flash(.labeledError(title: "", subtitle: "Something went wrong"), delay: 1.0)
                print("error====-=-=", error?.localizedDescription)
            }
           
            semaphore.signal()
            Indicator.sharedInstance.hideIndicator()
        }
        Indicator.sharedInstance.hideIndicator()
        task.resume()
        semaphore.wait()
    } else{
        UIApplication.shared.currentWindow?.rootViewController?.showOnlyAlert("", message: "Please Check Network Connection")
        Indicator.sharedInstance.hideIndicator()
    }
}
*/


/*
//--Api Call Function
func requestApiCalling(){
    SingleTon.shared.clientName = ""
    loginrequest = [Request]()
    //let headers: [String: String] = ["sessionToken": SingleTon.shared.userToken ]
    
    let params = [
        "filterByDate" : selectedDate,
        "sessionToken": SingleTon.shared.userToken
    ]
   
    ApiFunc.shared.APIHeaderMethod(url: ApiUrl.RequestUrl, method: .post, parameters: params, headers: nil) { (success : RequestModel!) in
        print(success as Any)
        if success?.status == true {
            SingleTon.shared.inspectorName = success.inspectorInfo.inspectorName
            //SingleTon.shared.inspectorName = success.data.inspectorInfo.inspectorName
            
            if success?.requests?.count == 0 {
                self.noReqLbl.isHidden = false
            } else {
                for i in 0..<(success?.requests)!.count {
                    self.loginrequest.append(success.requests![i])
                }
                self.noReqLbl.isHidden = true
            }

 self.homeTableView.dataSource = self
 self.homeTableView.delegate = self
 self.homeTableView.reloadData()
 }
        else if success?.status == false{
            print(success?.message as Any)
        }
    }
}
 */
