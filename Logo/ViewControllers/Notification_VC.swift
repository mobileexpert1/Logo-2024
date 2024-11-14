//
//  Notification_VC.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 05/03/22.
//

import UIKit
import Alamofire
class Notification_VC: UIViewController {
    
    var menualReportDetail:MenualReportModel?
    
    var myNotifiArr = [NotificatonMatirial]()
    let refreshControl = UIRefreshControl()
    
    
    @IBOutlet weak var notificatiosTableView: UITableView!
    @IBOutlet weak var baseVw: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Notification_TBlVwCell.registerTableCell(for: notificatiosTableView)
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        updateBackgroundColor()
        setRefreshControl()
        notificationApiCalling()
        setNavigationBar(vc: self, middleTitle: "Notification", rightAction: #selector(buttonAction(sender:)))
        notificatiosTableView.separatorStyle = .none
        notificatiosTableView.separatorColor = .clear
    }
    
    @objc func buttonAction(sender: UIButton) {
        print("Notification Btn Tapped")
    }
    
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                notificatiosTableView.reloadData()
                self.view.backgroundColor = ThemeColor.darkThemeCellBGColor
                self.baseVw.backgroundColor = ThemeColor.darkThemeCellBGColor
            }
            else{
                notificatiosTableView.reloadData()
            }
        }
        }
    
    func setRefreshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Reloading")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        self.notificatiosTableView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
       // Code to refresh table view
        print("tableView Reload Data")
        myNotifiArr = [NotificatonMatirial]()
        notificationApiCalling()
    }
}

extension Notification_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myNotifiArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = notificatiosTableView.dequeueReusableCell(withIdentifier: "Notification_TBlVwCell", for: indexPath)as! Notification_TBlVwCell
        
        if traitCollection.userInterfaceStyle == .dark {
            cell.backgroundColor = ThemeColor.darkThemeCellBGColor
            cell.contentView.backgroundColor = ThemeColor.darkThemeCellBGColor
            cell.baseView_NC.backgroundColor = ThemeColor.lightThemeImageTintColor
        }
        else{
            
        }
        
        cell.userNameLbl_NC.text = myNotifiArr[indexPath.row].title
        cell.messageLbl_NC.text = myNotifiArr[indexPath.row].description
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected Index is  :: \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return (notificatiosTableView.frame.height / 6)
        case .pad:
            return (notificatiosTableView.frame.height / 8)
        default:
            return 100
        }
    }
    
    func notificationApiCalling() {
        myNotifiArr = [NotificatonMatirial]()
        
        //let headers: [String: String] = ["Token": SingleTon.shared.userToken ]
        
        let params = [
            "sessionToken": SingleTon.shared.userToken
        ]
        
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.NotificationUrl, method: .post, parameters: params, headers: nil) { (success : NotificationModel!) in
            
            print(success as Any)
           
            if success?.status == true {
                    for i in 0..<(success?.data.requests)!.count {
                        self.myNotifiArr.append(success.data.requests[i])
                    }
               
                self.notificatiosTableView.reloadData()
                
            }
            else if success?.status == false {
                print(success?.message as Any)
            }
        }
        self.refreshControl.endRefreshing()
    }
}
