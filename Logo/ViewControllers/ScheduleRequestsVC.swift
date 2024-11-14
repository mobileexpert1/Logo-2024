//
//  ScheduleRequestsVC.swift
//  Logo
//
//  Created by Mobile on 25/05/23.
//

import UIKit
import SafariServices

class ScheduleRequestsVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var requestTblVw: UITableView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var bgImgVw: UIImageView!
    
    
    var requestsArray : [ScheduleRequestMeeting] = []
    var scheduleArr : [ScheduleMeeting] = []
    var meetingsArr : [Safety] = []
    var isComeForCheckSchedule = false
    var filterDate = ""
    var headerText = "Schedule Requests"
    
    var forMeetingPdf = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackgroundColor()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
        requestTblVw.delegate = self
        requestTblVw.dataSource = self
        
        
        if forMeetingPdf{
            let nibMeetingsPdfTblCell = UINib(nibName: "MeetingsPdfTblCell", bundle: nil)
            requestTblVw.register(nibMeetingsPdfTblCell, forCellReuseIdentifier: "MeetingsPdfTblCell")
            requestTblVw.rowHeight = 85
        }
        else{
            let nibScheduleRequestTblCell = UINib(nibName: "ScheduleRequestTblCell", bundle: nil)
            requestTblVw.register(nibScheduleRequestTblCell, forCellReuseIdentifier: "ScheduleRequestTblCell")
            requestTblVw.rowHeight = 140
        }
        
        backBtn.actionBlock {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        headerLbl.text = headerText
        
        if forMeetingPdf{
            GetMeetingdPdfAPI()
        }
        else{
            if isComeForCheckSchedule{
                GetScheduleAPI()
            }
            else{
                GetScheduleRequestsAPI()
            }
        }
    }
    
    
    func showFile(_ index: Int) {
        if let url = URL(string: scheduleArr[index].attachment) {
            let config = SFSafariViewController.Configuration()
            config.entersReaderIfAvailable = true

            let vc = SFSafariViewController(url: url, configuration: config)
            present(vc, animated: true)
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
                    headerLbl.textColor = ThemeColor.darkThemeTextColor
                    backBtn.tintColor = ThemeColor.darkThemeImageTintColor
                    bgImgVw.image = UIImage(named: "Dashboard2")
                    requestTblVw.reloadData()
                } else {

                    headerLbl.textColor = ThemeColor.lightThemeImageTintColor
                    backBtn.tintColor = ThemeColor.lightThemeImageTintColor
                    bgImgVw.image = UIImage(named: "Dashboard2Light")
                    requestTblVw.reloadData()
                }
            } else {
                // Fallback for earlier versions
          //      UIView.appearance().backgroundColor = .white
            }

            // Refresh the view hierarchy to apply the new background color
            view.setNeedsDisplay()
        }

    

}

extension ScheduleRequestsVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if forMeetingPdf{
            return meetingsArr.count
        }
        else{
            if isComeForCheckSchedule{
                return scheduleArr.count
            }
            else{
                return requestsArray.count
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if forMeetingPdf{
            let cell = requestTblVw.dequeueReusableCell(withIdentifier: "MeetingsPdfTblCell", for: indexPath) as! MeetingsPdfTblCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            
            cell.pdfTitleLbl.text = meetingsArr[indexPath.row].name
            cell.pdfDateLbl.text = meetingsArr[indexPath.row].createdAt
            
            if meetingsArr[indexPath.row].signature.isEmpty{
                
            }
            else{
                cell.pdfTitleLbl.font = UIFont.systemFont(ofSize: 18, weight: .medium)
                cell.pdfDateLbl.font = UIFont.systemFont(ofSize: 13, weight: .medium)
            }
            
            
            if traitCollection.userInterfaceStyle == .dark {
                cell.mainVw.backgroundColor = ThemeColor.lightThemeCellBGColor
                cell.pdfTitleLbl.textColor = ThemeColor.lightThemeImageTintColor
                cell.pdfDateLbl.textColor = ThemeColor.lightThemeImageTintColor
            }
            else{
                cell.mainVw.backgroundColor = ThemeColor.lightThemeImageTintColor
                cell.pdfTitleLbl.textColor = ThemeColor.darkThemeTextColor
                cell.pdfDateLbl.textColor = ThemeColor.darkThemeTextColor
            }
            
            return cell
        }
        else{
            let cell = requestTblVw.dequeueReusableCell(withIdentifier: "ScheduleRequestTblCell", for: indexPath) as! ScheduleRequestTblCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            
            if traitCollection.userInterfaceStyle == .dark {
                cell.mainVw.backgroundColor = ThemeColor.darkThemeCellBGColor
                cell.titleLbl.textColor = ThemeColor.darkThemeTextColor
                cell.dateTimeLbl.textColor = ThemeColor.darkThemeTextColor
                cell.descriptionTxtVw.textColor = ThemeColor.darkThemeTextColor
                
                cell.rejectBtn.setTitleColor(ThemeColor.darkThemeCellBGColor, for: .normal)
                cell.rejectBtn.backgroundColor = .white
                cell.acceptBtn.setTitleColor(ThemeColor.darkThemeCellBGColor, for: .normal)
                cell.acceptBtn.backgroundColor = .white
            }
            else{
                cell.mainVw.backgroundColor = .white
                cell.titleLbl.textColor = ThemeColor.lightThemeImageTintColor
                cell.dateTimeLbl.textColor = ThemeColor.lightThemeImageTintColor
                cell.descriptionTxtVw.textColor = ThemeColor.lightThemeImageTintColor
                
                cell.rejectBtn.setTitleColor(.white, for: .normal)
                cell.rejectBtn.backgroundColor = ThemeColor.lightThemeImageTintColor
                cell.acceptBtn.setTitleColor(.white, for: .normal)
                cell.acceptBtn.backgroundColor = ThemeColor.lightThemeImageTintColor
            }
            
            
            if isComeForCheckSchedule{
                cell.titleLbl.text = scheduleArr[indexPath.row].eventType
                cell.descriptionTxtVw.text = scheduleArr[indexPath.row].note
                cell.dateTimeLbl.text = "\(scheduleArr[indexPath.row].meetingDate), \(scheduleArr[indexPath.row].meetingTime)"
                cell.acceptBtn.isHidden = true
                cell.rejectBtn.tag = indexPath.row
                cell.rejectBtn.setTitle("View File", for: .normal)
                if scheduleArr[indexPath.row].attachment.isEmpty{
                    cell.rejectBtn.isHidden = true
                }
                cell.rejectBtn.actionBlock {
                    self.showFile(indexPath.row)
                }
                //      cell.rejectBtn.isHidden = true
            }
            else{
                cell.titleLbl.text = requestsArray[indexPath.row].eventType
                cell.descriptionTxtVw.text = requestsArray[indexPath.row].note
                cell.dateTimeLbl.text = "(\(requestsArray[indexPath.row].meetingDate), \(requestsArray[indexPath.row].meetingTime)"
                cell.acceptBtn.tag = indexPath.row
                cell.rejectBtn.tag = indexPath.row
                cell.acceptBtn.actionBlock {
                    self.AcceptRejectScheduleAPI(status: 1, index: cell.acceptBtn.tag)
                }
                cell.rejectBtn.actionBlock {
                    self.AcceptRejectScheduleAPI(status: 2, index: cell.acceptBtn.tag)
                }
            }
            return cell
        }
        
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if forMeetingPdf{
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MeetingsVC") as! MeetingsVC
            VC.pdfUrl = meetingsArr[indexPath.row].attachment
            VC.myId = meetingsArr[indexPath.row].id
            if meetingsArr[indexPath.row].signature.isEmpty{
                VC.showSign = true
            }
            else{
                VC.showSign = false
            }
            self.navigationController?.pushViewController(VC, animated: true)
        }
    }
  }


          



extension ScheduleRequestsVC{
    
    // MARK: - GET_LEAVES_API
    func GetScheduleRequestsAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ScheduleRequestsUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : ScheduleRequestModel?) in
            requestsArray.removeAll()
            requestsArray = success!.data.meetings
            if requestsArray.isEmpty{
                AlertControl.shared.showOnlyAlert("No Schedule Requests", message: "")
            }
            requestTblVw.reloadData()
        }
    }
    
    // MARK: - GET_SCHEDULE_API
    func GetScheduleAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.ScheduleUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken, "filterDate" : filterDate]) { [self] (success : ScheduleModel?) in
            let scheduleData = success!.data
            scheduleArr = scheduleData.meetings
            if scheduleArr.isEmpty{
                AlertControl.shared.showOnlyAlert("No Data Found", message: "")
            }
            requestTblVw.reloadData()
        }
    }
    
    // MARK: - GET_MeetingsPdf_API
    func GetMeetingdPdfAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.MeetingsPdfUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : MeetingsPDFModel?) in
            let meetingsPdfData = success!.data
            meetingsArr = meetingsPdfData.safety
            if meetingsArr.isEmpty{
                AlertControl.shared.showOnlyAlert("No Safety Meetings", message: "")
            }
            requestTblVw.reloadData()
        }
    }
    
    // MARK: - ACCEPT_REJECT_SCHEDULE_API
    func AcceptRejectScheduleAPI(status : Int, index : Int){
        let params = ["sessionToken" : SingleTon.shared.userToken,"meetingId" : requestsArray[index].id.description ,"status" : status.description] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.AcceptRejectScheduleUrl, method: .post, parameters: params) { [self] (success : AcceptRejectScheduleModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: (success?.message)!)
            GetScheduleRequestsAPI()
        }
    }
}
