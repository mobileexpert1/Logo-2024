//  SectionFormViewController.swift
//  Logo
//  Created by Mobile on 21/12/22.

import UIKit


protocol modelDelegate : AnyObject{
    func modelUpdate(updatedModel : SectionApiModel, index : Int)
}

class SectionFormViewController: UIViewController {
    
    @IBOutlet weak var addThisSectionCheckBox: UIImageView!
    @IBOutlet weak var addThisSection: UIView!
    @IBOutlet weak var sectionFormTableView: UITableView!
    @IBOutlet weak var addBtn: UIButton!
    
    @IBOutlet weak var bgImg: UIImageView!
    
    var addThisSectionBool = Bool()
    var modelDict = [String:Any]()
    var pickedImageString = String()
    
    var years = [String]()
    var selectedIndex = Int()
    
    var filledDataDict = [String:Any]()
    
    var dataQuestions = [QuestionJSON]()
    weak var mDelegate : modelDelegate?
    
    let cellIds = ["BoolTableCell", "ImageTableCell", "PickerTableCell", "TextTableCell", "TextViewTableCell", "YearTableCell", "DateTableCell", "GraphCell", "HeadingTextCell", "ElectricMotorTableViewCell","LoadConditionsTableViewCell","PilotReadingColTableViewCell"]
    let dataArray = ["English", "Maths", "History", "German", "Science"]
    var addedObject = ""
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackgroundColor()
        cellIds.forEach { cellId in
            sectionFormTableView.register(UINib(nibName: cellId, bundle: nil), forCellReuseIdentifier: cellId)
        }
        
        setNavigationBar(vc: self, middleTitle: "Form", leftAction: #selector(leftBtnAction(sender:)),rightAction: #selector(leftBtnAction(sender:)))
        addThisSection.actionBlock { [self] in
            print(self.addThisSectionBool)
            self.addThisSectionBool = !self.addThisSectionBool
            print(self.addThisSectionBool)
            if self.addThisSectionBool {
                self.addThisSectionCheckBox.image = #imageLiteral(resourceName: "group_4")
                SectionDataHandler.shared.model.data[self.selectedIndex].isInclude = "1"
                
                //                self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
                //                self.filledDataDict[SectionDataHandler.shared.model.data[self.selectedIndex].isInclude] = "1"
                //                UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
                //                print(self.filledDataDict)
                
                
                //                do{
                //                    let data = try NSKeyedArchiver.archivedData(withRootObject: SectionDataHandler.shared.model!, requiringSecureCoding: true)
                //                    UserDefaults.standard.set(data, forKey: "model")
                //                    UserDefaults.standard.synchronize()
                //                }catch (let error){
                //                    #if DEBUG
                //                        print("Failed to convert model to Data *-*-*-*-*-*-*-*---- : \(error.localizedDescription)")
                //                    #endif
                //                }
                let model = SectionDataHandler.shared.model
                try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model" + SectionDataHandler.shared.selectedReportId)
                print(self.selectedIndex)
               print(model?.data[self.selectedIndex].isInclude)
                
            } else {
                self.addThisSectionCheckBox.image = #imageLiteral(resourceName: "rectangle_4")
                SectionDataHandler.shared.model.data[self.selectedIndex].isInclude = "0"
                
                //                self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
                //                self.filledDataDict[SectionDataHandler.shared.model.data[self.selectedIndex].isInclude] = "0"
                //                UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
                //                print(self.filledDataDict)
                
                //                do{
                //                    let data = try NSKeyedArchiver.archivedData(withRootObject: SectionDataHandler.shared.model!, requiringSecureCoding: true)
                //                    UserDefaults.standard.set(data, forKey: "model")
                //                    UserDefaults.standard.synchronize()
                //                }catch (let error){
                //                    #if DEBUG
                //                        print("Failed to convert model to Data *-*-*-*-*-*-*-*---- : \(error.localizedDescription)")
                //                    #endif
                //                }
                let model = SectionDataHandler.shared.model
                try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model" + SectionDataHandler.shared.selectedReportId)
                print(self.selectedIndex)
                print("isInclude------>" , model?.data[self.selectedIndex].isInclude)
            }
        }
        //print("isInclude------>" , SectionDataHandler.shared.model.data[self.selectedIndex].isInclude)
        dataQuestions = SectionDataHandler.shared.model.data[selectedIndex].questionJSON!
      print(selectedIndex)
//        if selectedIndex < SectionDataHandler.shared.model.data.count {
//            if let questionJSON = SectionDataHandler.shared.model.data[selectedIndex].questionJSON {
//                var dataQuestions = questionJSON
//              
//            } else {
//               
//            }
//        } else {
//           
//            print("Index out of range")
//        }
        
        print(SectionDataHandler.shared.model.data[selectedIndex].questionJSON)
        
    }
    
    func updateBackgroundColor() {
        
        if traitCollection.userInterfaceStyle == .dark {
            
            addThisSection.backgroundColor = ThemeColor.darkThemeCellBGColor
            bgImg.image = UIImage(named: "Dashboard2")
            
        } else {
            
            //  addThisSection.backgroundColor = ThemeColor.lightThemeCellBGColor
            bgImg.image = UIImage(named: "Dashboard2Light")
            
        }
        
        view.setNeedsDisplay()
    }
    
    
    func showAlertWithTextField() {
        let alertController = UIAlertController(title: "Enter Object Name", message: nil, preferredStyle: .alert)
        alertController.addTextField { (textField) in
            textField.placeholder = "Enter your object name here"
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Save", style: .default) { (_) in
            if let textField = alertController.textFields?.first {
                // Process the text from the text field (textField.text)
                if let enteredText = textField.text {
                    // Do something with the entered text
                    print("Entered Text: \(enteredText)")
                    self.addedObject = enteredText
                    self.AddBtnActionCode()
                }
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func AddBtnActionCode(){
        
        
        let valueToFind = SectionDataHandler.shared.model.data[selectedIndex].sectionName
        var indexes: [Int] = []
        
        for (index, dictionary) in SectionDataHandler.shared.model.data.enumerated() {
            print(dictionary.sectionName)
            let value = dictionary.sectionName
            if let name = value as? String, name == valueToFind {
                indexes.append(index)
            }
        }
        print(indexes)
        
        
        SectionDataHandler.shared.model.data.insert(SectionDataHandler.shared.model.data[selectedIndex], at: indexes.last! + 1)
        
        if addedObject.isEmpty{
            if let lastCharacter = SectionDataHandler.shared.model.data[indexes.last!].sectionName.last, let lastCharacterValue = Int(String(lastCharacter)) {
                print("The last character '\(lastCharacter)' is an integer.")
                var lstCharacter = lastCharacterValue
                lstCharacter = lstCharacter + 1
                SectionDataHandler.shared.model.data[indexes.last! + 1].sectionName.removeLast()
                SectionDataHandler.shared.model.data[indexes.last! + 1].sectionName.append(lstCharacter.description)
            }
            else {
                print("The last character is not an integer.")
                SectionDataHandler.shared.model.data[indexes.last! + 1].sectionName.append("1")
            }
        }
        else{
            SectionDataHandler.shared.model.data[indexes.last! + 1].sectionName = addedObject
        }
        
        
        SectionDataHandler.shared.model.data[indexes.last! + 1].questionJSON = dataQuestions
        let model = SectionDataHandler.shared.model
        try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model" + SectionDataHandler.shared.selectedReportId)
        mDelegate?.modelUpdate(updatedModel: SectionDataHandler.shared.model, index: indexes.last! + 1)
        self.popOrDismissViewController(true)
    }
    
    
    
    @IBAction func addBtnAction(_ sender: Any) {
        //        for i in dataQuestions{
        //            SectionDataHandler.shared.model.data[selectedIndex].questionJSON?.append(i)
        //        }
        showAlertWithTextField()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        sectionFormTableView.delegate = self
        sectionFormTableView.dataSource = self
        for year in 1900...Calendar.current.component(.year, from: Date()) {
            years.append(String(year))
        }
        years = years.reversed()
        
        
        //        let filledDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any]
        //
        //        if let dict = filledDict {
        //            print(dict)
        //
        //            if let inclusion = dict[SectionDataHandler.shared.model.data[self.selectedIndex].isInclude] {
        //                if inclusion as! String == "0" {
        //                    self.addThisSectionCheckBox.image = #imageLiteral(resourceName: "rectangle_4")
        //                } else {
        //                    self.addThisSectionCheckBox.image = #imageLiteral(resourceName: "group_4")
        //                }
        //            }
        //        }
        
        
        
        
        
        //        do{
        //            if let data = UserDefaults.standard.object(forKey: "model") as? Data{
        //                if let model = try NSKeyedUnarchiver.unarchivedObject(ofClasses: [SectionApiModel], from: data){
        //                    // Use Color
        //                }
        //            }
        //        }catch (let error){
        //            #if DEBUG
        //                print("Failed to convert UIColor to Data : \(error.localizedDescription)")
        //            #endif
        //        }
        
        
        
        
        if  let storedModel = UserDefaults.standard.object(forKey: "model" + SectionDataHandler.shared.selectedReportId) as? Data {
            let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
            
            
            if model.data[self.selectedIndex].isInclude  == "0" || model.data[self.selectedIndex].isInclude == "" {
                self.addThisSectionCheckBox.image = #imageLiteral(resourceName: "rectangle_4")
                self.addThisSectionBool = false
            } else {
                self.addThisSectionCheckBox.image = #imageLiteral(resourceName: "group_4")
                self.addThisSectionBool = true
            }
        }
        
        
        
    }
    
    @objc func leftBtnAction(sender: UIButton){
        var formFilledAnswers = [Int]()
        SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON?.forEach({ question in
            // print(question)
            //  print(question.answer)
            if question.answer != "" {
                formFilledAnswers.append(1)
            } else {
               
                print("index has empty value for : \(question)")
            }
        })
        if SectionDataHandler.shared.model.data[self.selectedIndex].sectionName == "Pump" {
            if SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON!.count-1 == formFilledAnswers.count {
                SectionDataHandler.shared.isFormCompletelyFilledForIndexes.append(self.selectedIndex)
            } else {
                print("question count---> ",SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON?.count)
                print("answer count---> ",formFilledAnswers.count)
            }
            navigationController?.popViewController(animated: true)
        } else {
            if SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON?.count == formFilledAnswers.count {
                SectionDataHandler.shared.isFormCompletelyFilledForIndexes.append(self.selectedIndex)
            } else {
            print("question count---> ",SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON?.count)
                print("answer count---> ",formFilledAnswers.count)
            }
            navigationController?.popViewController(animated: true)
        }
        
    }
}

extension SectionFormViewController :  UITableViewDelegate, UITableViewDataSource,textFieldDataVolatgeDelegates{
    
    func textFieldDataForChartOne(_ data: [String : Any]) {
        SectionDataHandler.shared.chartOneFinalData = data
       // print("dataDict Voltage/Apmere",data)
    }
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SectionDataHandler.shared.model.data[selectedIndex].questionJSON!.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch SectionDataHandler.shared.model.data[selectedIndex].questionJSON![indexPath.row].type {
        case "chartOne":
            return 190
        case "chartTwo":
            return 250
        default:
            return UITableView.automaticDimension
        }
       
    }
    
    func tableView(_ tableView: UITableView , cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print ("TYPE***************SH***********", SectionDataHandler.shared.model.data[selectedIndex].questionJSON![indexPath.row].type)
        switch SectionDataHandler.shared.model.data[selectedIndex].questionJSON![indexPath.row].type {
        case "Boolean":
            let cell = tableView.dequeueReusableCell(withIdentifier: "BoolTableCell", for: indexPath) as! BoolTableCell
            
            //            let filledDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any]
            //
            //            if let dict = filledDict {
            //                print(dict)
            //
            //                if let bool = dict[SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer] {
            //                    if bool as! String == "Yes" {
            //                        self.handleRadioSelection("yes", cell)
            //                    } else if bool as! String == "No" {
            //                        self.handleRadioSelection("no", cell)
            //                    }  else if bool as! String == "N/A" {
            //                        self.handleRadioSelection("nil", cell)
            //                    }
            //                }
            //            }
            
            
            if  let storedModel = UserDefaults.standard.object(forKey: "model" + SectionDataHandler.shared.selectedReportId ) as? Data {
                let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
                
                let bool = model.data[self.selectedIndex].questionJSON![indexPath.row].answer
                if bool == "Yes" {
                    self.handleRadioSelection("yes", cell)
                } else if bool == "No" {
                    self.handleRadioSelection("no", cell)
                }  else if bool == "N/A" {
                    self.handleRadioSelection("nil", cell)
                }
                
                
            }
         
            //saveselectuser001
            cell.yesBtn.actionBlock {
                self.handleRadioSelection("yes", cell)
                SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer = "Yes"
                //
                //                self.filledDataDict = UserDefaults.standard.object(forKey: "modelDict") as? [String:Any] ?? [:]
                //                self.filledDataDict[SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer] = "Yes"
                //                UserDefaults.standard.set(self.filledDataDict, forKey: "modelDict")
                //                print(self.filledDataDict)
                
                let model = SectionDataHandler.shared.model
                try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model"+SectionDataHandler.shared.selectedReportId )
                
            }
            cell.noBtn.actionBlock {
                self.handleRadioSelection("no", cell)
                SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer = "No"
                
                //                self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
                //                self.filledDataDict[SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer] = "No"
                //                UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
                //                print(self.filledDataDict)
                
                let model = SectionDataHandler.shared.model
                try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model" + SectionDataHandler.shared.selectedReportId )
                
            }
            cell.nilBtn.actionBlock {
                self.handleRadioSelection("nil", cell)
                SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer = "N/A"
                
                //                self.filledDataDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
                //                self.filledDataDict[SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer] = "N/A"
                //                UserDefaults.standard.set(self.filledDataDict, forKey: "filledDataDict")
                //                print(self.filledDataDict)
                
                let model = SectionDataHandler.shared.model
                try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model" + SectionDataHandler.shared.selectedReportId)
            }
            cell.questionTitle.text = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question
            cell.selectionStyle = .none
            return cell
        case "MultiSelect":
            let cell = tableView.dequeueReusableCell(withIdentifier: "PickerTableCell", for: indexPath) as! PickerTableCell
            setupMultiSelectCell(cell, indexPath)
            cell.tag = indexPath.row
            cell.selectionStyle = .none
            return cell
        case "Text":
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextTableCell", for: indexPath) as! TextTableCell
            cell.questionTitle.text = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question
                
            if  let storedModel = UserDefaults.standard.object(forKey: "model" + SectionDataHandler.shared.selectedReportId ) as? Data {
                let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
                let text = model.data[self.selectedIndex].questionJSON![indexPath.row].answer
                cell.textField.text = text
            }
            cell.textField.setLeftPaddingPoints(10)
            cell.textField.delegate = self
            cell.textField.tag = indexPath.row
            cell.selectionStyle = .none
            return cell
            
        case "Heading":
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeadingTextCell", for: indexPath) as! HeadingTextCell
            cell.headingTextLabel.text = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question
            cell.headingTextLabel.tag = indexPath.row
            cell.selectionStyle = .none
            

            return cell
        case "Year":
            let cell = tableView.dequeueReusableCell(withIdentifier: "YearTableCell", for: indexPath) as! YearTableCell
            cell.questionTitle.text = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question
            cell.yearTextField.setLeftPaddingPoints(10)
            cell.yearTextField.loadDropdownData(data: years, selectedIndex: selectedIndex, indexPathRow: indexPath.row)
            cell.yearTextField.text = years[0]
            if  let storedModel = UserDefaults.standard.object(forKey: "model" + SectionDataHandler.shared.selectedReportId) as? Data {
                let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
                let year = model.data[self.selectedIndex].questionJSON![indexPath.row].answer
                cell.yearTextField.text = year
            }
            
            cell.selectionStyle = .none
            return cell
        case "Date":
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateTableCell", for: indexPath) as! DateTableCell
            cell.questionTitle.text = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question
            if  let storedModel = UserDefaults.standard.object(forKey: "model" + SectionDataHandler.shared.selectedReportId) as? Data {
                let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
                let date = model.data[self.selectedIndex].questionJSON![indexPath.row].answer
                cell.dateTextField.text = date
            }
            
            cell.dateTextField.setLeftPaddingPoints(10)
            cell.dateTextField.setDatePicker(selectedIndex: self.selectedIndex, indexPathRow: indexPath.row)
            cell.selectionStyle = .none
            return cell
        case "MultiLineText":
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextViewTableCell", for: indexPath) as! TextViewTableCell
            cell.questionTitle.text = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question
            if  let storedModel = UserDefaults.standard.object(forKey: "model" + SectionDataHandler.shared.selectedReportId) as? Data {
                let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
                
                let boxText = model.data[self.selectedIndex].questionJSON![indexPath.row].answer
                cell.textView.text = boxText
            }
            cell.selectionStyle = .none
            cell.textView.delegate = self
            cell.textView.tag = indexPath.row
            return cell
        case "Image":
            let cell = tableView.dequeueReusableCell(withIdentifier: "ImageTableCell", for: indexPath) as! ImageTableCell
            cell.selectionStyle = .none
            setupImageCell(cell, indexPath)
            cell.tag = indexPath.row
            print("tag>>>>>>>>>>>>>>" , cell.tag)
            return cell
            //MARK: test case
        case "chartOne":
            let cell = tableView.dequeueReusableCell(withIdentifier: "ElectricMotorTableViewCell", for: indexPath) as! ElectricMotorTableViewCell
            cell.delegates = self
            cell.textFieldDataToSend()
            print("tag>>>>>>>>>>>>>>" , cell.tag)
            return cell
        case "chartTwo":
            let cell = tableView.dequeueReusableCell(withIdentifier: "PilotReadingColTableViewCell", for: indexPath) as! PilotReadingColTableViewCell
            print("tag>>>>>>>>>>>>>>" , cell.tag)
            return cell
            //MARK:  test case end here
        case "Graph":
            let cell = tableView.dequeueReusableCell(withIdentifier: "GraphCell", for: indexPath) as! GraphCell
            cell.questionTitle.text = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question
            cell.selectionStyle = .none
            cell.questionTitle.actionBlock {
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "GraphVC") as! GraphVC
                let indexOfRatedPressure =   SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON!.firstIndex(where: {$0.question == "Rated pressure"})
                vc.ratedPressure = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexOfRatedPressure!].answer
                let indexOfRatedVolume = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON!.firstIndex(where: {$0.question == "Rated volume"})
                vc.ratedVolume = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexOfRatedVolume!].answer
                self.navigationController?.pushViewController(vc, animated: true)
            }
            return cell
        default:
            return UITableViewCell()
        }
        
    }

}

// BOOL
extension SectionFormViewController {
    func handleRadioSelection(_ type : String, _ cell : BoolTableCell) {
        
        switch type {
        case "yes":
            cell.yesRadioIcon.image = #imageLiteral(resourceName: "radio-on-button")
            cell.noRadioIcon.image = #imageLiteral(resourceName: "radio-off-button")
            cell.nilRadioIcon.image = #imageLiteral(resourceName: "radio-off-button")
        case "no":
            cell.yesRadioIcon.image = #imageLiteral(resourceName: "radio-off-button")
            cell.noRadioIcon.image = #imageLiteral(resourceName: "radio-on-button")
            cell.nilRadioIcon.image = #imageLiteral(resourceName: "radio-off-button")
        case "nil":
            cell.yesRadioIcon.image = #imageLiteral(resourceName: "radio-off-button")
            cell.noRadioIcon.image = #imageLiteral(resourceName: "radio-off-button")
            cell.nilRadioIcon.image = #imageLiteral(resourceName: "radio-on-button")
        default:
            break
        }
    }
}
// IMAGE
extension SectionFormViewController {
    
    func setupImageCell(_ cell : ImageTableCell, _ indexPath: IndexPath) {
        
        cell.questionTitle.text = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question
       
        
        
        //cell.uploadImageBtn.addTarget(self, action: #selector (imageUploadBtnAction(sender:)), for: .touchUpInside)
        
        cell.uploadImageBtn.actionBlock {
            SectionDataHandler.shared.selectedIndexForImage = self.selectedIndex
            SectionDataHandler.shared.indexpathRowForImage = indexPath.row
            
            self.openImagePicker(sender: cell.uploadImageBtn)
            
        }
        
        
        cell.imageHolderView.isHidden = true
        cell.imageHolderViewHyt.constant = 0
        
        
        print(SectionDataHandler.shared.selectedIndexForImage)
        print(SectionDataHandler.shared.indexpathRowForImage)
        print(self.selectedIndex)
        print(indexPath.row)
        
        
        if  let storedModel = UserDefaults.standard.object(forKey: "imageModel " + SectionDataHandler.shared.selectedReportId) as? Data {
            let model = try! PropertyListDecoder().decode([String:String].self, from: storedModel)
            
            if let image = model[SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")] {
                cell.imageHolderView.isHidden = false
                cell.imageHolderViewHyt.constant = 220
                cell.imageHolderImageView.image = SectionDataHandler.shared.convertBase64StringToImage(imageBase64String: image)
                
                print("Updated imagesArray:", SectionDataHandler.shared.convertBase64StringToImage(imageBase64String: image))
            }
//            cell.textView.text = boxText
        }
        
        if SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer == "1" {
            cell.imageHolderView.isHidden = false
            cell.imageHolderViewHyt.constant = 220
            
            
            let tempDict = SectionDataHandler.shared.imageDictHolder
            
            
            
          var tempImage = UIImage()
            tempImage = SectionDataHandler.shared.convertBase64StringToImage(imageBase64String: tempDict[SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")]!)
            
            cell.imageHolderImageView.image = tempImage
            
            
        }
        
        
//        if isImageSelected {
//            cell.imageHolderView.isHidden = false
//            cell.imageHolderViewHyt.constant = 220
//            cell.imageHolderImageView.image = pickedImageLocal
//
//            //SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer = pickedImageString
//            SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer = "1"
//
//            //SectionDataHandler.shared.imageDictHolder[SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer] = pickedImageString
//
//
//            let qq = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question
//            print(qq)
//            let qq2 = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")
//            print(qq2)
//
//            SectionDataHandler.shared.imageDictHolder[SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "")+SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")] = pickedImageString
//
//
//            print(SectionDataHandler.shared.imageDictHolder.keys.count)
//            print(SectionDataHandler.shared.imageDictHolder.keys)
//
//         //   isImageSelected = false
//
//            let model = SectionDataHandler.shared.model
//            try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model")
//        }
        
//        if  let storedModel = UserDefaults.standard.object(forKey: "model") as? Data {
//            let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
//            let image = model.data[self.selectedIndex].questionJSON![indexPath.row].answer
//            print(image)
//            if !image.isEmpty {
//                cell.imageHolderImageView.image = SectionDataHandler.shared.convertBase64StringToImage(imageBase64String: image)
//                isImageSelected = true
//                cell.imageHolderView.isHidden = false
//                cell.imageHolderViewHyt.constant = 220
//            }
//        }
//        isImageSelected = false
        
        cell.selectionStyle = .none
        
        cell.crossIcon.actionBlock {
            
            
            //SectionDataHandler.shared.model.data[SectionDataHandler.shared.selectedIndexForImage].questionJSON![SectionDataHandler.shared.indexpathRowForImage].answer = "0"
            SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer = "0"
            
            print(SectionDataHandler.shared.imageDictHolder.keys)
//            SectionDataHandler.shared.imageDictHolder.removeValue(forKey: SectionDataHandler.shared.imageDictHolder[SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")]!)
//
            if let index = SectionDataHandler.shared.imageDictHolder.index(forKey: SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")) {
                SectionDataHandler.shared.imageDictHolder.remove(at: index)
            }
//
//            SectionDataHandler.shared.imageDictHolder.remove(at: SectionDataHandler.shared.imageDictHolder.index(forKey: [SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")]))
            
            print(SectionDataHandler.shared.imageDictHolder.keys)
            
            
            
            if  let storedModel = UserDefaults.standard.object(forKey: "imageModel") as? Data {
                let model = try! PropertyListDecoder().decode([String:String].self, from: storedModel)
                
                
                if let index = SectionDataHandler.shared.imageDictHolder.index(forKey: SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")) {
                    SectionDataHandler.shared.imageDictHolder.remove(at: index)
                }
                
                let iModel = SectionDataHandler.shared.imageDictHolder
                try? UserDefaults.standard.set(PropertyListEncoder().encode(iModel), forKey: "imageModel")
               
    //            cell.textView.text = boxText
            }
            
            
            cell.imageHolderView.isHidden = true
            cell.imageHolderViewHyt.constant = 0
            cell.imageHolderImageView.image = UIImage()
            self.sectionFormTableView.reloadData()
            
            
            
        }
    }
    
//    func imageUploadBtnAction(sender: UIButton ){
//        // imgUploadBtnTag = sender.tag
//        self.openImagePicker(sender: sender)
//
//
//        DispatchQueue.main.async {
//            self.sectionFormTableView.reloadData()
//        }
//    }
}


// IMAGE
//extension SectionFormViewController {
//    
//    func setupImageCell(_ cell : ImageTableCell, _ indexPath: IndexPath) {
//        
//        cell.questionTitle.text = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question
//        
//        
//        
//        //cell.uploadImageBtn.addTarget(self, action: #selector (imageUploadBtnAction(sender:)), for: .touchUpInside)
//        
//        cell.uploadImageBtn.actionBlock {
//            SectionDataHandler.shared.selectedIndexForImage = self.selectedIndex
//            SectionDataHandler.shared.indexpathRowForImage = indexPath.row
//            
//            self.openImagePicker(sender: cell.uploadImageBtn)
//            
//        }
//        
//        
//        cell.imageHolderView.isHidden = true
//        cell.imageHolderViewHyt.constant = 0
//        
//        
//        print(SectionDataHandler.shared.selectedIndexForImage)
//        print(SectionDataHandler.shared.indexpathRowForImage)
//        print(self.selectedIndex)
//        print("iodfhjhjgfhgf", indexPath.row)
//        let dataindex = indexPath.row
//        
//        cell.tag = indexPath.row
//        //        if  let storedModel = UserDefaults.standard.object(forKey: "imageModel") as? Data {
//        //            let model = try! PropertyListDecoder().decode([String:String].self, from: storedModel)
//        //
//        //            if let image = model[SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")] {
//        //                cell.imageHolderView.isHidden = false
//        //                cell.imageHolderViewHyt.constant = 220
//        //
//        //                // cell.imageHolderImageView.image = SectionDataHandler.shared.convertBase64StringToImage(imageBase64String: image)
//        //                let image = SectionDataHandler.shared.convertBase64StringToImage(imageBase64String: image)
//        //                cell.configureCell(withImage: image , selectedIndexdata: indexPath)
//        //                cell.selectedIndex = indexPath.row
//        //                // cell.selectedIndex  = selectedIndex
//        //                print("vbdfboijoibjb" , image)
//        //
//        //                //cell.image_CollectionVW.imageHolderImageView = SectionDataHandler.shared.convertBase64StringToImage(imageBase64String: image)
//        //            }
//        //            cell.image_CollectionVW.reloadData()
//        //
//        //        }
//        
//        
//        
//        if let storedModel = UserDefaults.standard.object(forKey: "imageModel") as? Data {
//            do {
//                let model = try PropertyListDecoder().decode([[String:String]].self, from: storedModel)
//                
//                if let image = model.first(where: { $0.keys.first == SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "") }) {
//                    cell.imageHolderView.isHidden = false
//                    cell.imageHolderViewHyt.constant = 220
//                    for imageDict in model {
//                        if let imageData = image.values.first {
//                            let image = SectionDataHandler.shared.convertBase64StringToImage(imageBase64String: imageData)
//                            cell.configureCell(withImage: image, selectedIndexdata: indexPath)
//                            cell.selectedIndex = indexPath.row
//                        }
//                    }
//                }
//               
//            } catch {
//                print("Error decoding stored model: \(error)")
//            }
//        }
//        
//        
//        
//        
//        
//        if SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer == "1" {
//            cell.imageHolderView.isHidden = false
//            cell.imageHolderViewHyt.constant = 220
//            
//            
//            let tempDict = SectionDataHandler.shared.imageDictHolder
//            
//            
//            
//            var tempImage = UIImage()
//            tempImage = SectionDataHandler.shared.convertBase64StringToImage(imageBase64String: tempDict[SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")] ?? "")
//            
////             cell.imageHolderImageView.image = tempImage
////            cell.configureCell(withImage: tempImage, selectedIndexdata: indexPath)
////            cell.selectedIndex = indexPath.row
//            
//            //            let timage = tempImage
//            //              cell.configuredataCell(withImage: timage)
//            //            print("tioyhoihyt" , timage)
//           // cell.image_CollectionVW.reloadData()
//        }
//        
//        
//        
//        
//        
//        
//        //        if isImageSelected {
//        //            cell.imageHolderView.isHidden = false
//        //            cell.imageHolderViewHyt.constant = 220
//        //            cell.imageHolderImageView.image = pickedImageLocal
//        //
//        //            //SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer = pickedImageString
//        //            SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer = "1"
//        //
//        //            //SectionDataHandler.shared.imageDictHolder[SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer] = pickedImageString
//        //
//        //
//        //            let qq = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question
//        //            print(qq)
//        //            let qq2 = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")
//        //            print(qq2)
//        //
//        //            SectionDataHandler.shared.imageDictHolder[SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "")+SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")] = pickedImageString
//        //
//        //
//        //            print(SectionDataHandler.shared.imageDictHolder.keys.count)
//        //            print(SectionDataHandler.shared.imageDictHolder.keys)
//        //
//        //         //   isImageSelected = false
//        //
//        //            let model = SectionDataHandler.shared.model
//        //            try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model")
//        //        }
//        
//        //        if  let storedModel = UserDefaults.standard.object(forKey: "model") as? Data {
//        //            let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
//        //            let image = model.data[self.selectedIndex].questionJSON![indexPath.row].answer
//        //            print(image)
//        //            if !image.isEmpty {
//        //                cell.imageHolderImageView.image = SectionDataHandler.shared.convertBase64StringToImage(imageBase64String: image)
//        //                isImageSelected = true
//        //                cell.imageHolderView.isHidden = false
//        //                cell.imageHolderViewHyt.constant = 220
//        //            }
//        //        }
//        //        isImageSelected = false
//        
//        cell.selectionStyle = .none
//        
//        
//        
//        
//        // crossbtn
//        cell.crossIcon.actionBlock {
//            
//            
//            //SectionDataHandler.shared.model.data[SectionDataHandler.shared.selectedIndexForImage].questionJSON![SectionDataHandler.shared.indexpathRowForImage].answer = "0"
//            SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].answer = "0"
//            
//            print(SectionDataHandler.shared.imageDictHolder.keys)
//            //            SectionDataHandler.shared.imageDictHolder.removeValue(forKey: SectionDataHandler.shared.imageDictHolder[SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")]!)
//            //
//            if let index = SectionDataHandler.shared.imageDictHolder.index(forKey: SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")) {
//                SectionDataHandler.shared.imageDictHolder.remove(at: index)
//            }
//            //
//            //            SectionDataHandler.shared.imageDictHolder.remove(at: SectionDataHandler.shared.imageDictHolder.index(forKey: [SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")]))
//            
//            print(SectionDataHandler.shared.imageDictHolder.keys)
//            
//            
//            
//            if  let storedModel = UserDefaults.standard.object(forKey: "imageModel") as? Data {
//                let model = try! PropertyListDecoder().decode([String:String].self, from: storedModel)
//                
//                
//                if let index = SectionDataHandler.shared.imageDictHolder.index(forKey: SectionDataHandler.shared.model.data[self.selectedIndex].sectionName.replacingOccurrences(of: " ", with: "") + SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question.replacingOccurrences(of: " ", with: "")) {
//                    SectionDataHandler.shared.imageDictHolder.remove(at: index)
//                }
//                
//                let iModel = SectionDataHandler.shared.imageDictHolder
//                try? UserDefaults.standard.set(PropertyListEncoder().encode(iModel), forKey: "imageModel")
//                
//                //            cell.textView.text = boxText
//            }
//            
//            
//            cell.imageHolderView.isHidden = true
//            cell.imageHolderViewHyt.constant = 0
//            cell.imageHolderImageView.image = UIImage()
//            let image = UIImage()
//            // cell.configureCell(withImage: image, selectedIndexdata: IndexPath)
//            print("datapicwedfgidfgj" , image)
//            //cell.image_CollectionVW.reloadData()
//            self.sectionFormTableView.reloadData()
//            
//            
//            
//            
//        }
//    }
//}
extension SectionFormViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
    
    func openImagePicker(sender:UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        if let presenter = alert.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.sourceRect = CGRect(x: self.view.frame.maxX, y: 20, width: 100, height: 100)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let imagePicker = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            pickedImageString = SectionDataHandler.shared.convertImageToBase64String2(img: imagePicker)
            
            SectionDataHandler.shared.model.data[SectionDataHandler.shared.selectedIndexForImage].questionJSON![SectionDataHandler.shared.indexpathRowForImage].answer = "1"
            
            
            
            SectionDataHandler.shared.imageDictHolder[SectionDataHandler.shared.model.data[SectionDataHandler.shared.selectedIndexForImage].sectionName.replacingOccurrences(of: " ", with: "")+SectionDataHandler.shared.model.data[SectionDataHandler.shared.selectedIndexForImage].questionJSON![SectionDataHandler.shared.indexpathRowForImage].question.replacingOccurrences(of: " ", with: "")] = pickedImageString
            
            SectionDataHandler.shared.allImagesArray.append( SectionDataHandler.shared.imageDictHolder)
            print("SectionDataHandler.shared.allImagesArray----->", SectionDataHandler.shared.allImagesArray)
            
            let model = SectionDataHandler.shared.imageDictHolder
            try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "imageModel")
            
            
            //            if let imageData = UserDefaults.standard.data(forKey: "imageModel"),
            //               let model = try? PropertyListDecoder().decode([String:String].self, from: imageData) {
            //                print("modeldata---->>?>?>?>?", model)
            //            } else {
            //                print("Failed to retrieve and decode the image model.")
            //            }
            
        }
        //insertImagesToDictionarry(byTag: imgUploadBtnTag, image: pickedImage)
        self.dismiss(animated: true) {
            self.sectionFormTableView.reloadData()
            
        }
    }
    
}

// MULTISELECT
extension SectionFormViewController {
    func setupMultiSelectCell(_ cell : PickerTableCell, _ indexPath : IndexPath) {
        cell.questionTitle.text = SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].question
        
        cell.checkForAvailableDict(indexPath, self.selectedIndex)
        let nib = UINib(nibName: "PickerCollectionCell", bundle: .main)
        cell.pickerCollectionView?.register(nib, forCellWithReuseIdentifier: "PickerCollectionCell")
        
        cell.plusIcon.actionBlock {
            DropDownHandler.shared.showDropDownWithItems(cell.questionTitle,
                                                         SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![indexPath.row].values.components(separatedBy: ",#")
            )
            DropDownHandler.shared.itemPickedBlock = { (index, item) in
                print("selected item is :::  ", item)
                cell.setDataWithTypes(item, indexPath, self.selectedIndex, &self.filledDataDict)
            }
        }
        
    }
}

// TEXTFIELD
extension SectionFormViewController : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text as NSString? {
            let txtAfterUpdate = text.replacingCharacters(in: range, with: string)
            SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![textField.tag].answer = txtAfterUpdate
            let model = SectionDataHandler.shared.model
            try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model" + SectionDataHandler.shared.selectedReportId)
        }
        return true
    }
}

// TEXTVIEW
extension SectionFormViewController : UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        SectionDataHandler.shared.model.data[self.selectedIndex].questionJSON![textView.tag].answer = textView.text
        let model = SectionDataHandler.shared.model
        try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model" + SectionDataHandler.shared.selectedReportId)
    }
}
