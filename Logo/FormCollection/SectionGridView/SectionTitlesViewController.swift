//  SectionTitlesViewController.swift
//  Logo
//  Created by Mobile on 21/12/22.

import UIKit
import PKHUD



class SectionTitlesViewController: UIViewController, modelDelegate  {
    
    func modelUpdate(updatedModel: SectionApiModel, index: Int) {
        sectionsModel = updatedModel
        sectionTitleCollectionView.reloadData()
        let lastIndexPath = IndexPath(item: index, section: 0)
        sectionTitleCollectionView.scrollToItem(at: lastIndexPath, at: .bottom, animated: true)
    }
    
    
    @IBOutlet weak var bgImgVw: UIImageView!
    @IBOutlet weak var sectionTitleCollectionView: UICollectionView!
    @IBOutlet weak var imag_Alpha: UIImageView!
    @IBOutlet weak var pop_Vw: UIView!
    @IBOutlet weak var btnhide: UIButton!
    @IBOutlet weak var txtfld_SystemId: UITextField!
    @IBOutlet weak var txtfld_SystemName: UITextField!
    @IBOutlet weak var txtfld_SystemLocation: UITextField!
    //second pop
    @IBOutlet weak var pop_Vw2: UIView!
    @IBOutlet weak var org_Name: UITextField!
    var floatingButton: UIButton!
    var sectionsModel : SectionApiModel!
    var systemLocationText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSectionsData()
        Loaddata()
       
    }
    
    func Loaddata() {
        pop_Vw.isHidden = true
        imag_Alpha.isHidden = true
        self.pop_Vw2.isHidden = true
        pop_Vw2.layer.cornerRadius = 30
        pop_Vw.layer.cornerRadius = 30
        self.imag_Alpha.isHidden = true
        txtfld_SystemName.delegate = self
               setupFloatingButton()
        setNavigationBar(vc: self, middleTitle: "Form", leftAction: #selector(RightBtnAction(sender:)),rightAction: #selector(RightBtnAction(sender:)))
    
        updateBackgroundColor()
       
        btnhide.actionBlock { [self] in
            pop_Vw.isHidden = true
           imag_Alpha.isHidden = true
            self.imag_Alpha.isUserInteractionEnabled = false
            floatingButton.isHidden = false
        }
    }
    
    func setupFloatingButton() {
            floatingButton = UIButton(type: .custom)
            floatingButton.frame = CGRect(x: self.view.frame.size.width - 70, y: self.view.frame.size.height - 100, width: 50, height: 50)
            floatingButton.backgroundColor = UIColor(red: 31/255, green: 47/255, blue: 135/255, alpha: 1.0)
            floatingButton.layer.cornerRadius = 25
            floatingButton.setImage(UIImage(systemName: "plus"), for: .normal)
            floatingButton.tintColor = .white
            floatingButton.addTarget(self, action: #selector(floatingButtonTapped), for: .touchUpInside)
            
            // Add the button to the view
            self.view.addSubview(floatingButton)
            
            // Set constraints
            floatingButton.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                floatingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                floatingButton.bottomAnchor.constraint(equalTo: sectionTitleCollectionView.bottomAnchor, constant: 10),
                floatingButton.widthAnchor.constraint(equalToConstant: 50),
                floatingButton.heightAnchor.constraint(equalToConstant: 50)
            ])
        }
        
        @objc func floatingButtonTapped() {
            print("Floating button tapped")
            
//            
//            pop_Vw.isHidden = false
//            imag_Alpha.isHidden = false
//            imag_Alpha.isUserInteractionEnabled = true
//            floatingButton.isHidden = true
//            txtfld_SystemName.text = ""
            print("Floating button tapped")
                
                if SectionDataHandler.shared.Buildingids == "" {
                    AlertPopUp()
                } else if SectionDataHandler.shared.Buildingids != nil {
                    pop_Vw.isHidden = false
                    imag_Alpha.isHidden = false
                    imag_Alpha.isUserInteractionEnabled = true
                    floatingButton.isHidden = true
                    txtfld_SystemName.text = ""
                    
                } else {
                    pop_Vw.isHidden = false
                    imag_Alpha.isHidden = false
                    imag_Alpha.isUserInteractionEnabled = true
                    floatingButton.isHidden = true
                    txtfld_SystemName.text = ""
                }
            }
    
    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
               
                if traitCollection.userInterfaceStyle == .dark {
             
                    bgImgVw.image = UIImage(named: "Dashboard2")
                  
                } else {

                    bgImgVw.image = UIImage(named: "Dashboard2Light")
              }
            } else {
                // Fallback for earlier versions
          //      UIView.appearance().backgroundColor = .white
            }

            // Refresh the view hierarchy to apply the new background color
            view.setNeedsDisplay()
        }

    
    func AlertPopUp() {
        let alert = UIAlertController(title: "Select", message: "Please Select an option", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Add System", style: .default, handler: { [self] (_) in
            print("add request tapped")
            pop_Vw.isHidden = false
            imag_Alpha.isHidden = false
            imag_Alpha.isUserInteractionEnabled = true
            floatingButton.isHidden = true
            txtfld_SystemName.text = ""
           
        }))
        alert.addAction(UIAlertAction(title: "Add Building", style: .default, handler: { (_) in
            print("add request tapped")
            self.pop_Vw2.isHidden = false
            self.imag_Alpha.isHidden = false
            self.floatingButton.isHidden = true
            self.imag_Alpha.isUserInteractionEnabled = true
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
        self.present(alert, animated: true)
    }

    @IBAction func btnHideAction(_ sender: Any) {
        self.pop_Vw2.isHidden = true
        self.imag_Alpha.isHidden = true
        self.imag_Alpha.isUserInteractionEnabled = false
        self.floatingButton.isHidden = false
    }
    @IBAction func btnBuildAction(_ sender: Any) {
        
        if org_Name.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill Organization Name.")
            
        }else{
            
            ApiFunc.shared.SectionBulidingAddApi(self.view, Name: org_Name.text ?? "") { responseModel in
                if responseModel.status == true {
                    self.pop_Vw2.isHidden = true
                    self.imag_Alpha.isHidden = true
                    self.imag_Alpha.isUserInteractionEnabled = false
                    self.floatingButton.isHidden = false
                    self.org_Name.text = nil
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "CalanderHomeVC") as! CalanderHomeVC
                    self.navigationController?.pushViewController(vc, animated: true)
                }else{
                    if responseModel.message == "Building already exist" {
                        AlertControl.shared.showOnlyAlert("Poseidon", message: "Building already exist")
                    }else{
                        print("not Added Building")
                    }
                }
                
            }
            
        }
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if !SectionDataHandler.shared.isFormCompletelyFilledForIndexes.isEmpty {
            print(SectionDataHandler.shared.isFormCompletelyFilledForIndexes)
            sectionTitleCollectionView.reloadData()
        }
    }
   
    @objc func RightBtnAction(sender: UIButton){
        if imag_Alpha.isUserInteractionEnabled == false {
            navigationController?.popViewController(animated: true)
       } else{
             print ("dsfgsdgvs")
           }
    }
    
    @IBAction func submitBtnTapped(_ sender: UIButton) {

      SectionDataHandler.shared.bindInputModel()
     
  }
        
    @IBAction func btnPop_Submit(_ sender: Any) {
        
        if txtfld_SystemName.text!.isEmpty{
            AlertControl.shared.showOnlyAlert("Poseidon", message: "Please fill System Name.")
            
        }else if txtfld_SystemLocation.text == ""{
            showOnlyAlert("Poseidon", message: "Please fill System Location.")
      
        }else{
            ApiFunc.shared.AddSectionSystemIdApi(self.view, systemId: txtfld_SystemId.text ?? "", systemDescription: txtfld_SystemLocation.text ?? "", assignedQuestion: "\(systemNameSelectedId ?? 0)") { [self] responseModel in
                if responseModel.status == true {
                    pop_Vw.isHidden = true
                    imag_Alpha.isHidden = true
                    imag_Alpha.isUserInteractionEnabled = false
                    floatingButton.isHidden = false
                    txtfld_SystemLocation.text = nil
                    txtfld_SystemName.text = nil
                    getSectionsData()
                }else{
                    if responseModel.message == "Building already exist" {
                        AlertControl.shared.showOnlyAlert("Poseidon", message: "Building already exist")
                    }else{
                        print("Not Added Building")
                    }
                }
            }
            
        }
        
        
    }
}

extension SectionTitlesViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.sectionsModel.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SectionTitleCell", for: indexPath) as! SectionTitleCell
       
        if traitCollection.userInterfaceStyle == .dark {
            cell.base_Vw.backgroundColor = ThemeColor.lightThemeImageTintColor
            cell.center_Vw.backgroundColor = ThemeColor.lightThemeImageTintColor
            //cell.sectionTitle.textColor = .black
        }
        cell.sectionTitle.text = self.sectionsModel.data[indexPath.row].sectionName
        cell.systemId.text = self.sectionsModel.data[indexPath.row].systemId
        cell.lbl_SectionTxt.text = self.sectionsModel.data[indexPath.row].systemLocationText
    
        
        //SingleTon.shared.systemLocationText = self.sectionsModel.data[indexPath.row].systemLocationText
        print("data--", SingleTon.shared.systemLocationText)
        
        cell.blueTickIcon.isHidden = true
//        SectionDataHandler.shared.isFormCompletelyFilledForIndexes.forEach { index in
//            print("--*-*-*-*-*---*-*-*---",index)
//            if index == indexPath.row {
//                cell.blueTickIcon.isHidden = false
//            }
//        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2) - 6, height: (collectionView.frame.width/2) - 6)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SectionFormViewController") as! SectionFormViewController
        vc.mDelegate = self
        vc.selectedIndex = indexPath.row 
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SectionTitlesViewController {
    func getSectionsData() {
        ApiFunc.shared.allSectionsApi(self.view, requestId: SectionDataHandler.shared.selectedReportId) { [self] responseModel in
            if responseModel.status == true {
                self.sectionsModel = responseModel
                print(self.sectionsModel.data.count)
                if  let storedModel = UserDefaults.standard.object(forKey: "model" + SectionDataHandler.shared.selectedReportId) as? Data {
                    let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
                    SectionDataHandler.shared.model = model
                    print(SectionDataHandler.shared.model.data.count)
                    //Updatemodelflow
                    if SectionDataHandler.shared.model.data.count < self.sectionsModel.data.count {
                        try? UserDefaults.standard.set(PropertyListEncoder().encode(self.sectionsModel), forKey: "model" + SectionDataHandler.shared.selectedReportId)
                        if  let storedModel = UserDefaults.standard.object(forKey: "model" + SectionDataHandler.shared.selectedReportId) as? Data {
                            let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
                            SectionDataHandler.shared.model = model
                            print(SectionDataHandler.shared.model.data.count)
                        }
                    }
                } else {
                    SectionDataHandler.shared.model = self.sectionsModel
                }
                self.sectionTitleCollectionView.delegate = self
                self.sectionTitleCollectionView.dataSource = self
                self.sectionTitleCollectionView.reloadData()
            } else {
                HUD.flash(.labeledError(title: "", subtitle: responseModel.message), delay: 1.0)
            }
        }
    }
}
extension SectionTitlesViewController :  UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        txtfld_SystemName.loadDropdownData2(data: ["Fire pump", "Extinguishers",  "Fire Hydrants", "Flow Test" ,"Tanks" ,"Wet System" ,"Dry Systen", "Anti- Freeze", "Standpipe", "Sprinkler Heads", "Pump", "While Pump Is Running", "Fire Department Connection", "Trip system", "5 Year Internal", "5 Year FDC Flush & Hydro"])
        print("Text field did begin editing")
        
    }
}
