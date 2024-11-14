//
//  AllListHomeVC.swift
//  Logo
//
//  Created by Mobile on 30/03/22.
//

import UIKit
import Alamofire
import PKHUD


class AllListHomeVC: UIViewController {
    
    // MARK: - Variables
    var loginrequest = [Request]()
    var requestsArr = [Any]()
    var selectedIndex = 0
    var AcceptIndex = 0
    var reqSelectedIndex =  0
    var completedRequestListArray = [CompletedRequest]()
    var filteredNotesArr: [CompletedRequest] = []
    var isSearching: Bool = false
    var inspectTypePopUp:InspectionTypePopup!
    
    // MARK: - Outlets
    @IBOutlet weak var inspectionType: UILabel!
    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var popUserImage: LazyImageView!
    @IBOutlet weak var listTblView: UITableView!
    @IBOutlet weak var userTxtLabel_pop: PaddingLabel!
    @IBOutlet weak var numberTxtLabel_pop: PaddingLabel!
    @IBOutlet weak var makeReportBtn: UIButton!
    @IBOutlet weak var locationTxtLabel_pop: PaddingLabel!
    @IBOutlet weak var popContent_VW: UIView!
    @IBOutlet weak var noRequestLbl: UILabel!
    
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var agreeStackVw: UIStackView!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejecttBtn: UIButton!
    @IBOutlet weak var search_Name: UISearchBar!
   
    
    // MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        LoadData()
    }
    
    
    func LoadData(){
        makeReportBtn.isHidden = true
        search_Name.delegate = self
        //        setNavigationBar(vc: self, middleTitle: "Requests", rightAction: #selector(RightBtnAction(sender:)))
        
        //  self.navigationController?.setNavigationBarHidden(false, animated: true)
        listTblView.estimatedRowHeight = 120
        listTblView.rowHeight = UITableView.automaticDimension
        //   Home_TBlVwCell.registerTableCell(for: listTblView)
        CompletedReqTableViewCell.registerTableCell(for: listTblView)
        
        //        closeBtn.actionBlock {
        //            UIView.transition(with: self.view, duration: 1, options: [.transitionCrossDissolve], animations: {
        //                self.popUpView.removeFromSuperview()
        //            }, completion: nil)
        //        }
        
        backBtn.actionBlock {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //   self.navigationController?.setNavigationBarHidden(false, animated: true)
        //        popUserImage.image = UIImage(named: "car")
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        listTblView.separatorStyle = .none
        listTblView.separatorColor = .blue
        self.CompletedRequestListAPI()
        //   self.allRequestApi()
        //   setUI()
    }
    
    @objc func RightBtnAction(sender: UIButton){
    }
    
    // MARK: - Functions
    func setUI() {
        listTblView.separatorStyle = .none
        listTblView.separatorColor = .blue
        //--POP UI SET
        userTxtLabel_pop.layer.cornerRadius = 5
        numberTxtLabel_pop.layer.cornerRadius = 5
        locationTxtLabel_pop.layer.cornerRadius = 5
        //---------
        self.capsuleButton(makeReportBtn)
        makeReportBtn.clipsToBounds = true
        popUserImage.layer.cornerRadius = 10
        popUserImage.clipsToBounds = true
        //roundCornerView.roundCorners([.topRight,.topLeft], radius: 40)
        popContent_VW.roundCorners([.topRight,.topLeft], radius: 40)
        
    }
    
    @IBAction func acceptAction(_ sender: UIButton) {
        self.ChageRequestStatusAPI(index: AcceptIndex, status: "1")
        
    }
    
    @IBAction func rejectAction(_ sender: UIButton) {
        
        self.ChageRequestStatusAPI(index: AcceptIndex, status: "2")
    }
    
    
    // MARK: - Actions
    @IBAction func makeReportBtn(_ sender: Any) {
        //        var requestDict = [String:Any]()
        //        requestDict["index"] = selectedIndex
        //        requestDict["model"] = loginrequest[selectedIndex]
        //        requestDict["clientName"] = SingleTon.shared.clientName
        //        requestDict["inspectorName"] = SingleTon.shared.inspectorName
        //        print(requestDict)
        
        //self.pushWithData("Form_VC", requestDict)
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "Form_VC")as! Form_VC
        SingleTon.shared.isMakeMenualReport = false
        ClearDataClass.removeAllValues()
        //showInspectPopUp()
        //        self.navigationController?.pushViewController(vc, animated: true)
        self.popUpView.removeFromSuperview()
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SectionTitlesViewController") as! SectionTitlesViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func showInspectPopUp(){
        inspectTypePopUp = InspectionTypePopup()
        inspectTypePopUp?.cancelButton.actionBlock { [weak self] in
            guard let self = self else { return }
            self.inspectTypePopUp.removeFromSuperview()
        }
        inspectTypePopUp?.nextBtn.actionBlock { [weak self] in
            guard let self = self else { return }
            
            //let vc = self.storyboard?.instantiateViewController(withIdentifier: "Form_VC") as! Form_VC
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SectionTitlesViewController") as! SectionTitlesViewController
            self.navigationController?.pushViewController(vc, animated: true)
            self.inspectTypePopUp?.removeFromSuperview()
            self.popUpView.removeFromSuperview()
            self.inspectTypePopUp = nil
        }
        self.navigationController?.view.addSubview(self.inspectTypePopUp)
        self.inspectTypePopUp.frame = (self.navigationController?.view.frame)!
        //self.tabBarController?.view.addSubview(self.completeKyc)
        
    }
    
    
    
    
    // MARK: - Web Services
    func requestsApi(completion: @escaping(_ : RequestModel) -> Void) {
        var semaphore = DispatchSemaphore (value: 0)
        
        let parameters = "sessionToken=\(SingleTon.shared.userToken)"
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(url: URL(string: "https://247.poseidons.io/api/inspector/dashboard")!,timeoutInterval: 120)
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
    
    //    func allRequestApi() {
    //        SingleTon.shared.clientName = ""
    //        loginrequest = [Request]()
    //        ApiFunc.shared.allRequestsApi(self.view) { responseModel in
    //            if responseModel.status == true {
    //                SingleTon.shared.inspectorName = responseModel.data.inspectorName
    //                self.loginrequest = (responseModel.data.requests)
    //                if responseModel.data.requests.count == 0 {
    //                    self.noRequestLbl.isHidden = false
    //                } else {
    //                    self.noRequestLbl.isHidden = true
    //                }
    //                self.listTblView.dataSource = self
    //                self.listTblView.delegate = self
    //                self.listTblView.reloadData()
    //            } else {
    //                HUD.flash(.labeledError(title: "", subtitle: responseModel.message), delay: 1.0)
    //            }
    //        }
    //    }
    
    
    func CompletedRequestListAPI(){
        //  + SingleTon.shared.userToken.description
        ApiFunc.shared.APIHeaderMethod(url: (ApiUrl.CompltedReqListUrl), method: .get, parameters: ["sessionToken":SingleTon.shared.userToken]) { [self] (success : CompletedRequestModel?) in
            self.completedRequestListArray = success!.data.completedRequest
            DispatchQueue.main.async {
                //                self.mainTblVw.rowHeight = 80
                //                SingleTon.shared.onRequest = true
                if self.completedRequestListArray.count != 0{
                    self.noRequestLbl.isHidden = true
                }
                self.listTblView.dataSource = self
                self.listTblView.delegate = self
                self.listTblView.reloadData()
                //                self.topTitleLbl.text = "Clock In/Out"
                //                self.backBtn.isHidden = false
                //                self.logoutBtn.isHidden = true
            }
        }
    }
    
    
    //MARK: CHANGE_REQUEST_STATUS_API
    @objc func ChageRequestStatusAPI(index:Int,status:String){
        print("Tapped")
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ChageRequestStatusUrl, method: .post, parameters: ["sessionToken" : SingleTon.shared.userToken,"type" : status,"requestId" : loginrequest[index].id]) { [self] (success : ChageRequestStatusModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            //    allRequestApi()
            UIView.transition(with: self.view, duration: 1, options: [.transitionCrossDissolve], animations: {
                self.popUpView.removeFromSuperview()
            }, completion: nil)
            let indxPath = IndexPath(row: index, section: 0)
            self.listTblView.scrollToRow(at: indxPath, at: .bottom, animated: false)
        }
    }
    
    @objc func viewPdf(_ sender:UIButton){
        print("Pdf Work")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PdfViewerVC")as! PdfViewerVC
        vc.pdfLink = ApiUrl.pdfBaseUrl+completedRequestListArray[sender.tag].report
        HUD.hide()
        vc.comeFrom = false
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //    func updateBackgroundColor() {
    //            if #available(iOS 13.0, *) {
    //
    //                if traitCollection.userInterfaceStyle == .dark {
    //              // Dark mode is enabled
    //                    headerLbl.textColor = ThemeColor.darkThemeTextColor
    //                    backBtn.tintColor = ThemeColor.darkThemeImageTintColor
    //                    self.view.backgroundColor = ThemeColor.darkThemeViewBGColor
    //                    submitBtn.backgroundColor = ThemeColor.lightThemeViewBGColor
    //                    submitBtn.setTitleColor(ThemeColor.lightThemeImageTintColor, for: .normal)
    //                    webView.backgroundColor = ThemeColor.darkThemeViewBGColor
    //                    webVw.backgroundColor = ThemeColor.darkThemeViewBGColor
    //
    //                } else {
    //
    //                    headerLbl.textColor = ThemeColor.lightThemeImageTintColor
    //                    backBtn.tintColor = ThemeColor.lightThemeImageTintColor
    //                    self.view.backgroundColor = ThemeColor.lightThemeViewBGColor
    //                    webView.backgroundColor = ThemeColor.lightThemeViewBGColor
    //                    webVw.backgroundColor = ThemeColor.darkThemeViewBGColor
    //                }
    //            } else {
    //                // Fallback for earlier versions
    //          //      UIView.appearance().backgroundColor = .white
    //            }
    //
    //            // Refresh the view hierarchy to apply the new background color
    //            view.setNeedsDisplay()
    //        }
    
    /*
     func requestApiCalling() {
     SingleTon.shared.clientName = ""
     loginrequest = [Request]()
     
     //let headers: [String: String] = ["sessionToken": SingleTon.shared.userToken ]
     
     let params = [
     "sessionToken": SingleTon.shared.userToken
     ]
     
     ApiFunc.shared.APIHeaderMethod(url: ApiUrl.RequestUrl, method: .post, parameters: params, headers: nil) { (success : RequestModel!) in
     print(success as Any)
     if success?.status == true {
     SingleTon.shared.inspectorName = success.inspectorInfo.inspectorName
     // SingleTon.shared.inspectorName = success.data.inspectorInfo.inspectorName
     if success?.requests?.count == 0 {
     self.noRequestLbl.isHidden = false
     } else {
     for i in 0..<(success?.requests)!.count {
     self.loginrequest.append(success.requests![i])
     }
     self.noRequestLbl.isHidden = true
     }
     self.listTblView.reloadData()
     } else if success?.status == false {
     print(success?.message as Any)
     }
     }
     }
     */
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension AllListHomeVC: UITableViewDelegate,UITableViewDataSource {
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return completedRequestListArray.count
//        //     return loginrequest.count
//    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredNotesArr.count
        } else {
            return completedRequestListArray.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CompletedReqTableViewCell", for: indexPath)as! CompletedReqTableViewCell
        
//        cell.reportNameLbl.text = completedRequestListArray[indexPath.row].fullName
//        cell.addressLbl.text = completedRequestListArray[indexPath.row].address
        let reportmake: CompletedRequest
        if isSearching {
            reportmake = filteredNotesArr[indexPath.row]
        } else {
            reportmake = completedRequestListArray[indexPath.row]
        }
        cell.reportNameLbl.text = reportmake.fullName
        cell.addressLbl.text = reportmake.address
              
        
        cell.reportPdfBtn.tag = indexPath.row
        cell.reportPdfBtn.addTarget(self, action: #selector(viewPdf), for: .touchUpInside)
        cell.backgroundColor = .clear
        
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "Home_TBlVwCell", for: indexPath)as! Home_TBlVwCell
        //
        //        cell.dateLbl.text = loginrequest[indexPath.row].assignedDate + "  " + loginrequest[indexPath.row].assignedTime
        //        cell.nameLabel_HomeCell.text = loginrequest[indexPath.row].fullName
        //        cell.locationLabel_HomeCell.text = loginrequest[indexPath.row].addressLine1 + ", " + loginrequest[indexPath.row].city + ", " + loginrequest[indexPath.row].state
        //        cell.inspectionTypeLbl.text = loginrequest[indexPath.row].inspectionType
        //
        //        cell.leftImg_HomeCell.circleView(view: cell.leftImg_HomeCell)
        //        if loginrequest[indexPath.row].profileImage != "" {
        //            cell.leftImg_HomeCell.setNetworkImage(cell.leftImg_HomeCell, ApiUrl.ProfileImgBase + loginrequest[indexPath.row].profileImage)
        //        } else {
        //            cell.leftImg_HomeCell.setNetworkImage(cell.leftImg_HomeCell, ApiUrl.ProfileImgBase + "userImages/defaultImage.png")
        //        }
        //
        ////        let myImg = ApiUrl.ProfileImgBase + loginrequest[indexPath.row].profileImage
        ////        let imageUrl = URL(string: myImg)!
        ////        cell.leftImg_HomeCell.loadImage(fromURL: imageUrl, placeHolderImage: "user")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (indexPath.row)
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PdfViewerVC")as! PdfViewerVC
        vc.pdfLink = ApiUrl.pdfBaseUrl+completedRequestListArray[indexPath.row].report
        HUD.hide()
        vc.comeFrom = false
        self.navigationController?.pushViewController(vc, animated: true)
        
        
        
        //        if loginrequest[indexPath.row].inspectorInspectionStatus == "0"{
        //         //   openActionSheet(index: indexPath.row)
        //            agreeStackVw.isHidden = false
        //            AcceptIndex = indexPath.row
        //            makeReportBtn.isHidden = true
        //        }
        //        else{
        //            agreeStackVw.isHidden = true
        //            makeReportBtn.isHidden = false
        //        }
        //
        //            SingleTon.shared.reqesedtUserId = loginrequest[indexPath.row].id
        //            print("request id--------------------------  > ",SingleTon.shared.reqesedtUserId)
        //            selectedIndex = indexPath.row
        //            UIView.transition(with: self.view, duration: 1, options: [.curveEaseIn], animations: {
        //                self.navigationController?.view.addSubview(self.popUpView)
        //            }, completion: nil)
        //
        //            popUpView.updatePopUpViewConstraints(Of: popUpView, to: self.view)
        //            userTxtLabel_pop.text = loginrequest[indexPath.row].fullName
        //            inspectionType.text = loginrequest[indexPath.row].inspectionType
        //            numberTxtLabel_pop.text = loginrequest[indexPath.row].mobileNumber
        //            locationTxtLabel_pop.text = loginrequest[indexPath.row].userCity + ", " + loginrequest[indexPath.row].userState
        //            let myImg = ApiUrl.ProfileImgBase + loginrequest[indexPath.row].profileImage
        //            let imageUrl = URL(string: myImg)!
        //
        //            SingleTon.shared.clientName = loginrequest[indexPath.row].fullName
        //            SingleTon.shared.requestStreetNuber = loginrequest[indexPath.row].streetNumber
        //            SingleTon.shared.requestAddressLine1 = loginrequest[indexPath.row].addressLine1
        //            SingleTon.shared.requestAddressLine2 = loginrequest[indexPath.row].addressLine2
        //            SingleTon.shared.requestCity = loginrequest[indexPath.row].city
        //            SingleTon.shared.requestState = loginrequest[indexPath.row].state
        //            SingleTon.shared.postalCode = loginrequest[indexPath.row].postalCode
        //            popUserImage.loadImage(fromURL: imageUrl, placeHolderImage: "user")
        
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
        
        return 100
        //      return UITableView.automaticDimension
    }
    
    // MARK: - ActionSheet
    func openActionSheet(index:Int) {
        let alertController = UIAlertController(title: "Poseidon", message: nil, preferredStyle: .actionSheet)
        let acceptButton = UIAlertAction(title: "Poseidon", style: .default, handler: { (action) -> Void in
            self.ChageRequestStatusAPI(index: index, status: "1")
        })
        
        let  rejectButton = UIAlertAction(title: "Reject", style: .default, handler: { (action) -> Void in
            self.ChageRequestStatusAPI(index: index, status: "2")
        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            self.acceptRejectAPI(index: index)
        })
        
        alertController.addAction(acceptButton)
        alertController.addAction(rejectButton)
        alertController.addAction(cancelButton)
        present(alertController, animated: true)
    }
    
    @objc func acceptRejectAPI(index:Int){
        print("Tapped")
    }
}
extension AllListHomeVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       // filteredNotesArr = completedRequestListArray.filter { $0.fullName.lowercased().contains(searchText.lowercased()) }
        filteredNotesArr = completedRequestListArray.filter {
                 $0.fullName.lowercased().contains(searchText.lowercased()) ||
                 $0.address.lowercased().contains(searchText.lowercased())
             }
        isSearching = !searchText.isEmpty
        listTblView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        filteredNotesArr.removeAll()
        isSearching = false
        listTblView.reloadData()
        searchBar.resignFirstResponder()
    }
   
}
