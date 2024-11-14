//
//  SubjectDiscussVC.swift
//  Logo
//
//  Created by Mobile on 05/04/24.
//

import UIKit

class SubjectDiscussVC: UIViewController {

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
        askToAdminPopUpVw.layer.cornerRadius = 30
        
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
    
   

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        GetChatSubjectsPdfAPI()
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
    
    @IBAction func btnsave(_ sender: Any) {
        askToAdminPopUpVw.isHidden = false
        alphaImgVw.isHidden = false
    }
    
    @IBAction func btn_hide(_ sender: Any) {
        askToAdminPopUpVw.isHidden = true
        alphaImgVw.isHidden = true
    }
    
}


extension SubjectDiscussVC{
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


extension SubjectDiscussVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblVw.dequeueReusableCell(withIdentifier: "SubjectChatTblCell", for: indexPath) as! SubjectChatTblCell
        
        tblVw.showsVerticalScrollIndicator = false
        cell.mainVw.backgroundColor = .white
        applyStyling(to: cell.mainVw)
        cell.arrowImg.image = UIImage(named: "Vectorback")
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
          // Dark mode is enabled
                cell.subjectLbl.textColor = .black
                cell.arrowImg.tintColor = .black
                //cell.mainVw.backgroundColor = ThemeColor.lightThemeViewBGColor
                cell.mainVw.backgroundColor = .white
                
               
            } else {
                cell.subjectLbl.textColor = .black
                cell.arrowImg.tintColor = .black
                //cell.mainVw.backgroundColor = ThemeColor.lightThemeImageTintColor
                cell.mainVw.backgroundColor = .white
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
    func applyStyling(to view: UIView) {
           
           
           view.backgroundColor = UIColor.white
           view.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
           view.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
        view.layer.shadowOpacity = 0.5
        
        
       }
    
}
