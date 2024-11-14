//
//  EmergencyWorkOrderVC.swift
//  Logo
//
//  Created by MOBILE on 24/08/23.
//

import UIKit

class EmergencyWorkOrderVC: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var HeaderLbl: UILabel!
    @IBOutlet weak var bgImg: UIImageView!
    @IBOutlet weak var addBtn: UILabel!
    
    var myDataArray = [EmergencyRequest]()

    override func viewDidLoad() {
        super.viewDidLoad()

        updateBackgroundColor()
        
        tblVw.delegate = self
        tblVw.dataSource = self
        addBtn.clipsToBounds = true
        addBtn.layer.cornerRadius = 25
        addBtn.layer.borderColor = UIColor(red: 237/255, green: 243/255, blue: 247/255, alpha: 1.0).cgColor
        addBtn.layer.borderWidth = 2.0
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        EmergencyWorkOrderTblCell.registerTableCell(for: tblVw)

        tblVw.estimatedRowHeight = 100
        
        backBtn.actionBlock {
            self.addHapticFeedback()
            self.navigationController?.popViewController(animated: true)
        }
        
        addBtn.actionBlock {
            self.addHapticFeedback()
            let VC = UIStoryboard(name: "WorkOrderView", bundle: nil).instantiateViewController(withIdentifier: "WorkOrderView")
            UserDefaults.standard.setValue([:], forKey: "filledDataDict")
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        GetEmergencyRequestsAPI()
    }
    
    
    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
              // Dark mode is enabled
                    HeaderLbl.textColor = ThemeColor.darkThemeTextColor
                    backBtn.tintColor = ThemeColor.darkThemeImageTintColor
                    bgImg.image = UIImage(named: "Dashboard2")
                    tblVw.reloadData()
                } else {

                    HeaderLbl.textColor = ThemeColor.lightThemeImageTintColor
                    backBtn.tintColor = ThemeColor.lightThemeImageTintColor
                    bgImg.image = UIImage(named: "Dashboard2Light")
                    tblVw.reloadData()
                }
            } else {
                // Fallback for earlier versions
          //      UIView.appearance().backgroundColor = .white
            }

            // Refresh the view hierarchy to apply the new background color
            view.setNeedsDisplay()
        }

}

extension UIViewController{
    func addHapticFeedback(){
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        // Trigger Haptic Feedback
        feedbackGenerator.impactOccurred()
    }
}


extension EmergencyWorkOrderVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblVw.dequeueReusableCell(withIdentifier: "EmergencyWorkOrderTblCell", for: indexPath) as! EmergencyWorkOrderTblCell
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        cell.titleLbl.text = myDataArray[indexPath.row].name
        cell.dateLbl.text = myDataArray[indexPath.row].dateOfOrder
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80;//Choose your custom row height
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.addHapticFeedback()
        let VC = UIStoryboard(name: "WorkOrderView", bundle: nil).instantiateViewController(withIdentifier: "WorkOrderView") as! WorkOrderView
        UserDefaults.standard.setValue([:], forKey: "filledDataDict")
        var myDict = [String:Any]()
        myDict["toTextField"] = myDataArray[indexPath.row].name
        myDict["termsTextField"] = myDataArray[indexPath.row].terms
        myDict["orderTakenByTxtField"] = myDataArray[indexPath.row].orderTakenBy
        myDict["customersOrderNumberTxtField"] = myDataArray[indexPath.row].orderNumber
        myDict["phoneTextField"] = myDataArray[indexPath.row].phone
        myDict["jobNameTextField"] = myDataArray[indexPath.row].jobName
        myDict["jobLocationTextField"] = myDataArray[indexPath.row].jobLocation
        myDict["jobPhoneTextField"] = myDataArray[indexPath.row].jobPhone
        myDict["dateOfOrderTextField"] = myDataArray[indexPath.row].dateOfOrder
        myDict["startingDateTextField"] = myDataArray[indexPath.row].startingDate
        VC.jobId = myDataArray[indexPath.row].id
        UserDefaults.standard.setValue(myDict, forKey: "filledDataDict")
        self.navigationController?.pushViewController(VC, animated: true)
    }
}


extension EmergencyWorkOrderVC{
    // MARK: - GET_EMERGENCY_REQUESTS_API
    func GetEmergencyRequestsAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.emergencyRequestsUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : EmergencyRequestModel?) in
            myDataArray = (success?.data.emergencyRequest)!
            if myDataArray.count == 0{
                AlertControl.shared.showOnlyAlert("", message: "No Request Found")
            }
            else{
                tblVw.reloadData()
            }
        }
    }
}


