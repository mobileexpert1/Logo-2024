//
//  AllRequestsVC.swift
//  Logo
//
//  Created by Mobile on 05/04/24.
//

import UIKit
import Alamofire
import PKHUD
class AllRequestsVC: UIViewController {
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var headerVw2: UIView!
    @IBOutlet weak var headerVw1: UIView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var addSubjectBtn: UIImageView!
    
    @IBOutlet weak var baseVw: UIView!
    @IBOutlet weak var bgImgVw: UIImageView!
    var myNotifiArr = [NotificatonMatirial]()
    let refreshControl = UIRefreshControl()
    
    var completedRequestListArray = [CompletedRequest]()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackgroundColor()
        
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.separatorStyle = .none
        AllRequestsTableViewCell.registerTableCell(for: tblVw)
        backBtn.actionBlock {
            self.navigationController?.popViewController(animated: true)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tblVw.separatorStyle = .none
        tblVw.separatorColor = .blue
        self.CompletedRequestListAPI()
        //   self.allRequestApi()
        //   setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        notificationApiCalling()
        //  setRefreshControl()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                headerLbl.textColor = ThemeColor.darkThemeTextColor
                backBtn.tintColor = ThemeColor.darkThemeImageTintColor
                addSubjectBtn.tintColor = ThemeColor.darkThemeImageTintColor
                self.baseVw.backgroundColor = ThemeColor.darkThemeCellBGColor
                bgImgVw.image = UIImage(named: "Dashboard2")
                headerVw2.backgroundColor = ThemeColor.lightThemeImageTintColor
                headerVw1.backgroundColor = ThemeColor.lightThemeImageTintColor
            }
            else{
                headerVw1.backgroundColor = .white
                headerVw2.backgroundColor = .white
                backBtn.tintColor = ThemeColor.lightThemeImageTintColor
                addSubjectBtn.tintColor = ThemeColor.lightThemeImageTintColor
                headerLbl.textColor = ThemeColor.lightThemeImageTintColor
                bgImgVw.image = UIImage(named: "Dashboard2Light")
             
                tblVw.reloadData()
            }
        }
    }
    
    //    func updateBackgroundColor() {
    //        if #available(iOS 13.0, *) {
    //            if traitCollection.userInterfaceStyle == .dark {
    //                notificatiosTableView.reloadData()
    //                self.view.backgroundColor = ThemeColor.darkThemeCellBGColor
    //                self.baseVw.backgroundColor = ThemeColor.darkThemeCellBGColor
    //            }
    //            else{
    //                tblVw.reloadData()
    //            }
    //        }
    //        }
    
    
    
    func CompletedRequestListAPI(){
        //  + SingleTon.shared.userToken.description
        ApiFunc.shared.APIHeaderMethod(url: (ApiUrl.CompltedReqListUrl), method: .get, parameters: ["sessionToken":SingleTon.shared.userToken]) { [self] (success : CompletedRequestModel?) in
            self.completedRequestListArray = success!.data.completedRequest
            DispatchQueue.main.async {
                //                self.mainTblVw.rowHeight = 80
                //                SingleTon.shared.onRequest = true
                if self.completedRequestListArray.count != 0{
                    //  self.noRequestLbl.isHidden = true
                }
                // self.listTblView.dataSource = self
                //self.listTblView.delegate = self
                self.tblVw.reloadData()
                //                self.topTitleLbl.text = "Clock In/Out"
                //                self.backBtn.isHidden = false
                //                self.logoutBtn.isHidden = true
            }
        }
    }
    
    
    //    @objc func refresh(_ sender: AnyObject) {
    //       // Code to refresh table view
    //        print("tableView Reload Data")
    //        myNotifiArr = [NotificatonMatirial]()
    //        notificationApiCalling()
    //    }
    
    
    func notificationApiCalling() {
        myNotifiArr = [NotificatonMatirial]()
        
        //let headers: [String: String] = ["Token": SingleTon.shared.userToken ]
        
        let params = [
            "sessionToken": SingleTon.shared.userToken
        ]
        print("params----" , params)
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.NotificationUrl, method: .post, parameters: params, headers: nil) { (success : NotificationModel!) in
            print("ApiUrl.NotificationUrl", ApiUrl.NotificationUrl)
            print(success as Any)
            
            if success?.status == true {
                for i in 0..<(success?.data.requests)!.count {
                    self.myNotifiArr.append(success.data.requests[i])
                }
                
                self.tblVw.reloadData()
                
            }
            else if success?.status == false {
                print(success?.message as Any)
            }
        }
        self.refreshControl.endRefreshing()
    }
    
    
}
extension AllRequestsVC : UITableViewDelegate, UITableViewDataSource{
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            
            let todayNotifications = myNotifiArr.filter { isToday(dateString: $0.addedOn) }
            return todayNotifications.count
        } else if section == 1 {
            
            let yesterdayNotifications = myNotifiArr.filter { isYesterday(dateString: $0.addedOn) }
            return yesterdayNotifications.count
        } else {
            
            let beforeYesterdayNotifications = myNotifiArr.filter { !isToday(dateString: $0.addedOn) && !isYesterday(dateString: $0.addedOn) }
            return beforeYesterdayNotifications.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let headerLabel = UILabel(frame: CGRect(x: 20, y: 5, width: tableView.frame.width - 30, height: 20))
        //          headerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        headerLabel.font = UIFont.systemFont(ofSize: 19)
        headerLabel.textColor = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0)
        
        headerLabel.frame.origin.y = headerView.frame.height - headerLabel.frame.height - 2
        if section == 0 {
            headerLabel.text = "Today"
        } else if section == 1 {
            headerLabel.text = "Yesterday"
        } else {
            headerLabel.text = "Before Yesterday"
        }
        
        headerView.addSubview(headerLabel)
        return headerView
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllRequestsTableViewCell", for: indexPath) as! AllRequestsTableViewCell
        
        var notification: NotificatonMatirial
        
        if indexPath.section == 0 {
            
            let todayNotifications = myNotifiArr.filter { isToday(dateString: $0.addedOn) }
            notification = todayNotifications[indexPath.row]
        } else if indexPath.section == 1 {
            
            let yesterdayNotifications = myNotifiArr.filter { isYesterday(dateString: $0.addedOn) }
            notification = yesterdayNotifications[indexPath.row]
        } else {
            
            let beforeYesterdayNotifications = myNotifiArr.filter { !isToday(dateString: $0.addedOn) && !isYesterday(dateString: $0.addedOn) }
            notification = beforeYesterdayNotifications[indexPath.row]
        }
        
        cell.lbl_Header.text = notification.title
        cell.lbl_SubHeader.text = notification.description
        cell.lbl_Time.text = notification.addedOn
        cell.selectionStyle = .none
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected Index is  :: \(indexPath.row)")
    }
    //    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //        print (indexPath.row)
    //
    //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PdfViewerVC")as! PdfViewerVC
    //        vc.pdfLink = ApiUrl.pdfBaseUrl+completedRequestListArray[indexPath.row].report
    //        HUD.hide()
    //        vc.comeFrom = false
    //        self.navigationController?.pushViewController(vc, animated: true)
    //
    //
    //
    //    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    private func isToday(dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        return Calendar.current.isDateInToday(date ?? Date())
    }
    
    
    private func isYesterday(dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dateFormatter.date(from: dateString)
        guard let validDate = date else {
            return false
        }
        
        
        return Calendar.current.isDateInYesterday(validDate)
    }
    
}
