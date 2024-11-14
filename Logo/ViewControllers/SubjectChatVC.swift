//
//  SubjectChatVC.swift
//  Logo
//
//  Created by MOBILE on 02/08/23.
//

import UIKit

class SubjectChatVC: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!
    @IBOutlet weak var backBtn: UIImageView!
    
    @IBOutlet weak var askToAdminPopUpVw: UIView!
    @IBOutlet weak var chatSubjectTxtFld: UITextField!
    @IBOutlet weak var chatDescriptionTxtVw: UITextView!
    @IBOutlet weak var chatSubmitBtn: UIButton!
    @IBOutlet weak var alphaImgVw: UIImageView!
    @IBOutlet weak var addSubjectBtn: UIImageView!
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var bgImgVw: UIImageView!
    @IBOutlet weak var headerVw1: UIView!
    @IBOutlet weak var headerVw2: UIView!
    
    var notesArr : [NotesList] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackgroundColor()
        HideViews(true)
        tblVw.delegate = self
        tblVw.dataSource = self
        tblVw.separatorStyle = .none
        SubjectChatTblCell.registerTableCell(for: tblVw)
        
        
        backBtn.actionBlock {
            self.navigationController?.popViewController(animated: true)
        }
        
        alphaImgVw.actionBlock { [self] in
            askToAdminPopUpVw.isHidden = true
            alphaImgVw.isHidden = true
            chatSubjectTxtFld.text = ""
            chatDescriptionTxtVw.text = ""
        }
        
        addSubjectBtn.actionBlock {
            self.HideViews(false)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        GetChatSubjectsPdfAPI()
    }
    
    func HideViews(_ value:Bool){
        alphaImgVw.isHidden = value
        askToAdminPopUpVw.isHidden = value
    }
    
    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
              // Dark mode is enabled
                    headerLbl.textColor = ThemeColor.darkThemeTextColor
                    backBtn.tintColor = ThemeColor.darkThemeImageTintColor
                    addSubjectBtn.tintColor = ThemeColor.darkThemeImageTintColor
                    bgImgVw.image = UIImage(named: "Dashboard2")
                    headerVw1.backgroundColor = ThemeColor.lightThemeImageTintColor
                    headerVw2.backgroundColor = ThemeColor.lightThemeImageTintColor
                    tblVw.reloadData()
                } else {

                    headerLbl.textColor = ThemeColor.lightThemeImageTintColor
                    backBtn.tintColor = ThemeColor.lightThemeImageTintColor
                    addSubjectBtn.tintColor = ThemeColor.lightThemeImageTintColor
                    bgImgVw.image = UIImage(named: "Dashboard2Light")
                    headerVw1.backgroundColor = .white
                    headerVw2.backgroundColor = .white
                    tblVw.reloadData()
                }
            } else {
            }
            view.setNeedsDisplay()
        }
    
    @IBAction func chatSubmitBtnAction(_ sender: UIButton) {
        if chatDescriptionTxtVw.text.isEmpty || chatSubjectTxtFld.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Kindly enter a valid reason for leaves.")
        }
        else{
            AskToAdminAPI()
        }
        
        
    }
    

}


extension SubjectChatVC{
    func GetChatSubjectsPdfAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.chatSubjectsUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken]) { [self] (success : ChatSubjectsModel?) in
            let requestData = success!.data
            notesArr = requestData.notesList
            tblVw.reloadData()
            if notesArr.isEmpty{
                AlertControl.shared.showOnlyAlert("No Data Found", message: "")
            }
        }
    }
    
    // MARK: - ACCEPT_REJECT_SCHEDULE_API
    func AskToAdminAPI(){
        let params = ["sessionToken" : SingleTon.shared.userToken,"note" : chatDescriptionTxtVw.text! ,"subject" : chatSubjectTxtFld.text!] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.AskToAdminUrl,  method: .post, parameters: params) { [self] (success : AskToAdminModel?) in
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Chat Subject added.")
            HideViews(true)
            GetChatSubjectsPdfAPI()
        }
    }
}


extension SubjectChatVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblVw.dequeueReusableCell(withIdentifier: "SubjectChatTblCell", for: indexPath) as! SubjectChatTblCell
        
        tblVw.showsVerticalScrollIndicator = false
        
        
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
          // Dark mode is enabled
                cell.subjectLbl.textColor = ThemeColor.lightThemeImageTintColor
                cell.arrowImg.tintColor = ThemeColor.lightThemeImageTintColor
                cell.mainVw.backgroundColor = ThemeColor.lightThemeViewBGColor
            } else {
                cell.subjectLbl.textColor = .white
                cell.arrowImg.tintColor = .white
                cell.mainVw.backgroundColor = ThemeColor.lightThemeImageTintColor
            }
        } else {
        }
        view.setNeedsDisplay()
        
        
        cell.backgroundColor = .clear
        cell.subjectLbl.text = notesArr[indexPath.row].subject
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChatVC") as! ChatVC
        VC.userNoteId = notesArr[indexPath.row].id
        VC.headerLblText = notesArr[indexPath.row].subject
        self.navigationController?.pushViewController(VC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
}
