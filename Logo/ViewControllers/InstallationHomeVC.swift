//
//  InstallationHomeVC.swift
//  Logo
//
//  Created by MOBILE on 31/07/23.
//

import UIKit

class InstallationHomeVC: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var createReqBtn: UIImageView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var bgImgVw: UIImageView!
    
    
    
    var requestArr : [AssignedRequest] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
                
        tblVw.estimatedRowHeight = 120
        tblVw.rowHeight = UITableView.automaticDimension
        Home_TBlVwCell.registerTableCell(for: tblVw)
        tblVw.backgroundColor = .clear
        
        tblVw.delegate = self
        tblVw.dataSource = self
        
        backBtn.actionBlock {
            self.navigationController?.popViewController(animated: true)
        }
        createReqBtn.actionBlock {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "MenualReportVC") as! MenualReportVC
            SingleTon.shared.isMakeMenualReport = false
            vc.isComeFromInstallation = true
    //        ClearDataClass.removeAllValues()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        updateBackgroundColor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        GetInstallationListAPI()
        navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = .white
    }
    
    
    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
               
                if traitCollection.userInterfaceStyle == .dark {
              // Dark mode is enabled
                    headerLbl.textColor = ThemeColor.darkThemeTextColor
                    backBtn.tintColor = ThemeColor.darkThemeImageTintColor
                    createReqBtn.tintColor = ThemeColor.darkThemeImageTintColor
                    bgImgVw.image = UIImage(named: "Dashboard2")
                    tblVw.reloadData()
                } else {

                    headerLbl.textColor = ThemeColor.lightThemeImageTintColor
                    backBtn.tintColor = ThemeColor.lightThemeImageTintColor
                    createReqBtn.tintColor = ThemeColor.lightThemeImageTintColor
                    bgImgVw.image = UIImage(named: "Dashboard2Light")
                    tblVw.reloadData()
                }
            } else {
                // Fallback for earlier versions
          //      UIView.appearance().backgroundColor = .white
            }

            // Refresh the view hierarchy to apply the new background color
            view.setNeedsDisplay()
        }
    
    
    // MARK: - GET_SCHEDULE_API
    func GetInstallationListAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.getInstallationListUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken, "from" : ""]) { [self] (success : GetInstallationModel?) in
            let requestData = success!.data
            requestArr.removeAll()
            requestArr = requestData.assignedRequest
            tblVw.reloadData()
            if requestArr.isEmpty{
                AlertControl.shared.showOnlyAlert("No Request Found", message: "")
            }
        }
    }
    
    
    

}

extension InstallationHomeVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requestArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblVw.dequeueReusableCell(withIdentifier: "Home_TBlVwCell", for: indexPath)as! Home_TBlVwCell
       
        if traitCollection.userInterfaceStyle == .dark {
            cell.backgroundColor = ThemeColor.darkThemeCellBGColor
            cell.baseView_HomeCell.backgroundColor = ThemeColor.lightThemeImageTintColor
        }
        else{
            cell.backgroundColor = UIColor(red: 237/255, green: 243/255, blue: 247/255, alpha: 1.0)
        }
        
        cell.leftImg_HomeCell.image = UIImage(named: "user")
      
        cell.dateLbl.text = requestArr[indexPath.row].date
        //cell.locationLabel_HomeCell.text = requestArr[indexPath.row].address
        //MARK: changes made
        let combineDetail = "\(requestArr[indexPath.row].city) \(requestArr[indexPath.row].state) \(requestArr[indexPath.row].postalCode)"
        cell.locationLabel_HomeCell.text = combineDetail
      
        if requestArr[indexPath.row].type == "1"{
            cell.lbladdress.text = "Above ground"
        }else if requestArr[indexPath.row].type == "2" {
            cell.lbladdress.text = "Back flow"
        }
        //MARK: changes made till here
        cell.nameLabel_HomeCell.text = requestArr[indexPath.row].propertyName
        cell.inspectionTypeLbl.isHidden = true
    
        cell.backgroundColor = .clear
        cell.baseView_HomeCell.cornerRadius = 10.0
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstallationVC") as! InstallationVC
        VC.pdfId = requestArr[indexPath.row].id
        VC.pdfUrl = "https://247.poseidons.io/installation/admin/generateReport?tok=" + requestArr[indexPath.row].id
        
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
}
