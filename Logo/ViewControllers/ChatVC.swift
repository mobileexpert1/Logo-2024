//
//  ChatVC.swift
//  Logo
//
//  Created by MOBILE on 02/08/23.
//

import UIKit

class ChatVC: UIViewController, UITextViewDelegate {
    
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var sendBtn: UIImageView!
    @IBOutlet weak var chatTxtVw: UITextView!
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var bgImgVw: UIImageView!
    @IBOutlet weak var headerVw1: UIView!
    @IBOutlet weak var headerVw2: UIView!
    
    var headerLblText = ""
    var chatArr = [Message]()
    var timeArr = [String]()
    var userNoteId = "0"
    
    var timer : Timer?
    var currentRow = 0
    var isScroll = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackgroundColor()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(GetChat), userInfo: nil, repeats: true)
        headerLbl.text = "Chat On \(headerLblText)"
        tblVw.delegate = self
        tblVw.dataSource = self
        chatTxtVw.delegate = self
        tblVw.separatorStyle = .none
        ChatTblCell1.registerTableCell(for: tblVw)
        ChatTblCell2.registerTableCell(for: tblVw)
        GetChatAPI()
        chatTxtVw.sizeToFit()

        backBtn.actionBlock {
            self.timer?.invalidate()
            self.navigationController?.popViewController(animated: true)
        }
        
        sendBtn.actionBlock {
            if !self.chatTxtVw.text.isEmpty{
                self.AddMessagesAPI()
            }
        }
        
    }
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if !chatArr.isEmpty{
            tblVw.scrollToBottom(isAnimated: false)
        }
        return true
    }
    
    @objc func GetChat(){
        GetChatAPI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
  
    
    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
               
                if traitCollection.userInterfaceStyle == .dark {
              // Dark mode is enabled
                    headerLbl.textColor = ThemeColor.darkThemeTextColor
                    backBtn.tintColor = ThemeColor.darkThemeImageTintColor
                    bgImgVw.image = UIImage(named: "Dashboard2")
                    headerVw1.backgroundColor = ThemeColor.lightThemeImageTintColor
                    headerVw2.backgroundColor = ThemeColor.lightThemeImageTintColor
                    tblVw.reloadData()
                } else {

                    headerLbl.textColor = ThemeColor.lightThemeImageTintColor
                    backBtn.tintColor =
                    ThemeColor.lightThemeImageTintColor
                    sendBtn.tintColor =
                    ThemeColor.lightThemeImageTintColor
                    bgImgVw.image = UIImage(named: "Dashboard2Light")
                    headerVw1.backgroundColor = .white
                    headerVw2.backgroundColor = .white
                    tblVw.reloadData()
                }
            } else {
            }
            view.setNeedsDisplay()
        }
    
    
    func getDayAndTime(fromTimestamp timestamp: TimeInterval) -> (day: String, time: String) {
        // Convert the timestamp to a Date object
        let date = Date(timeIntervalSince1970: timestamp)
        
        // Create a date formatter to extract day and time components
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE" // "EEEE" will give the full weekday name (e.g., Monday, Tuesday)
        dateFormatter.timeZone = .current
        let day = dateFormatter.string(from: date)
        
        dateFormatter.dateFormat = "h:mm a" // "h:mm a" will give the time in 12-hour format (e.g., 3:30 PM)
        let time = dateFormatter.string(from: date)
        
        return (day, time)
    }
    
    
    func timeIntervalFromString(_ dateString: String, format: String) -> TimeInterval? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        
        if let date = dateFormatter.date(from: dateString) {
            return date.timeIntervalSince1970
        } else {
            return nil // Return nil if the conversion fails
        }
    }

}

extension ChatVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if chatArr[indexPath.row].userID != SingleTon.shared.MyLoginID{
            let cell = tblVw.dequeueReusableCell(withIdentifier: "ChatTblCell1", for: indexPath) as! ChatTblCell1
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.lbl.text = chatArr[indexPath.row].text
            cell.lbl.sizeToFit()
            cell.timeLbl.text = getDayAndTime(fromTimestamp: Double(chatArr[indexPath.row].addedOnTimeStamp)!).time
            return cell
        }
        else{
            let cell = tblVw.dequeueReusableCell(withIdentifier: "ChatTblCell2", for: indexPath) as! ChatTblCell2
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.lbl.text = chatArr[indexPath.row].text
            cell.lbl.sizeToFit()
            cell.timeLbl.text = getDayAndTime(fromTimestamp: Double(chatArr[indexPath.row].addedOnTimeStamp)!).time
            return cell
        }
    }
}


extension ChatVC{
    func GetChatAPI(){
        ApiFunc.shared.APIHeaderMethod1(url: ApiUrl.chatMessagesUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken, "userNoteId" : userNoteId]) { [self] (success : ChatMessagesModel?) in
            let requestData = success!.data
            if chatArr.count != requestData.messages.count{
                chatArr = requestData.messages
                tblVw.reloadData()
                isScroll = true
            }
            if !chatArr.isEmpty{
                if isScroll{
                    isScroll = false
                    tblVw.scrollToBottom(isAnimated: false)
                }
            }
        }
    }
    
    // MARK: - ACCEPT_REJECT_SCHEDULE_API
    func AddMessagesAPI(){
        
        let msg = chatTxtVw.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let params = ["sessionToken" : SingleTon.shared.userToken,"userNoteId" : userNoteId ,"text" : msg] as [String : Any]
        ApiFunc.shared.APIHeaderMethod1(url: ApiUrl.chatMessagesAddUrl, method: .post, parameters: params) { [self] (success : ChatMessagesAddModel?) in
            isScroll = true
            chatTxtVw.text = ""
            GetChatAPI()
        }
    }
}
