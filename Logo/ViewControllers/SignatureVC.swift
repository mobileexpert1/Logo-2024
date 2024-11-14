//
//  SignatureVC.swift
//  Logo
//
//  Created by Akshay on 29/03/22.
//

import UIKit
import PKHUD

class SignatureVC: UIViewController, UITextFieldDelegate {
    var textField: UITextField?
    @IBOutlet weak var inspectorSignPad: SignatureCanvas!
    @IBOutlet weak var clientSignPad: SignatureCanvas!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var bgImg: UIImageView!
    var winterizationSwitch = String()
    var fireExtinguisherSwitch = String()
    var dataHolderDict = [String:Any]()
    var responseString = NSString()
    var systemLocationText = String()
    var selectedTimeUnit: String = "min"
   
    override func viewDidLoad() {
        super.viewDidLoad()
        print("welcome to SignatureVC")
        winterizationSwitch = "No"
        fireExtinguisherSwitch = "No"
        
        setNavigationBar(vc: self, middleTitle: "Signature", rightAction: #selector(RightBtnAction(sender:)))
        updateBackgroundColor()
        
        

        
//        if let systemLocation = UserDefaults.standard.string(forKey: "systemLocationText") {
//            print("Username: \(systemLocation)")
//            systemLocationText = systemLocation
//        } else {
//           // systemLocationText = systemLocation
//            print("Username not found in UserDefaults")
//        }
    }
    
    
    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
            
                    bgImg.image = UIImage(named: "Dashboard2")
                  
                } else {

                  
                    bgImg.image = UIImage(named: "Dashboard2Light")
                   
                }
            } else {
         
            }

            view.setNeedsDisplay()
        }
    
    
    @objc func RightBtnAction(sender: UIButton){
    }
    @IBAction func winterizationSwitch(_ sender: UISwitch) {
        if sender.isOn {
            winterizationSwitch = "Yes"
        } else {
            winterizationSwitch = "No"
        }
    }
    @IBAction func fireExtinguisherSwitch(_ sender: UISwitch) {
        if sender.isOn {
            fireExtinguisherSwitch = "Yes"
        } else {
            fireExtinguisherSwitch = "No"
        }
    }
    
    func convertDataToJson(_ dataValue : [String: Any]) -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: dataValue, options: [])
            
            if let jsonString = String(data: jsonData, encoding: .utf8) { 
           return jsonString
            }
        }
        catch 
        {
            print("Error converting dictionary to JSON: \(error.localizedDescription)")

            return ""
        }
        return ""
    }

    @IBAction func submitBtnTapped(_ sender: UIButton) {
       
        var chart1String = ""
        var chart2String = ""
    
        
        chart1String = convertDataToJson(SectionDataHandler.shared.chartOneFinalData)
        chart2String = convertDataToJson(SectionDataHandler.shared.chartTwoFinalData)
        
      
        
        if checkSignatures() {
            
            print(SingleTon.shared.clientName)
            print(SingleTon.shared.requestAddressLine1)
            print(SingleTon.shared.requestAddressLine2)
            print(SingleTon.shared.requestCity)
            print(SingleTon.shared.requestState)
            print(SingleTon.shared.postalCode)
            
            let clientSignImg = convertViewToImage(view: self.clientSignPad)
            let inspectorSignImg = convertViewToImage(view: self.inspectorSignPad)
            
            let clientImgsStr = SectionDataHandler.shared.convertImageToBase64String2(img: clientSignImg!)
            let inspectorImgsStr = SectionDataHandler.shared.convertImageToBase64String2(img: inspectorSignImg!)
            
            var timeTakenForInspection = String()
            print("SignatureVC--------------SingleTon.shared.typeID-----------" , SingleTon.shared.typeID)
            if  SingleTon.shared.typeID == 1{
                if SectionDataHandler.shared.imageDictHolder.keys.count == 0 {
                    HUD.show(.progress, onView: self.view)
                    let defaults = UserDefaults.standard
                    defaults.removeObject(forKey: "imageModel")
                    //                    let systemLocationTextdefaults = UserDefaults.standard
                    //                    defaults.removeObject(forKey: "systemLocationText")
                    SectionDataHandler.shared.imageDictHolder = [:]
                    defaults.synchronize()
                    ApiFunc.shared.submitPdfApi(self.view, SingleTon.shared.userToken, clientImgsStr, inspectorImgsStr,self.fireExtinguisherSwitch,self.winterizationSwitch, self.responseString as String, SectionDataHandler.shared.flowTestTableValues, SectionDataHandler.shared.graphImageStr, timeTakenForInspection, chart1String, chart2String ) { response in
                        let defaults = UserDefaults.standard
                        //let dictionary = defaults.dictionaryRepresentation()
                        defaults.removeObject(forKey: "model" + SectionDataHandler.shared.selectedReportId)
                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PdfViewerVC")as! PdfViewerVC
                        vc.pdfLink = response.data.pdfName
                        HUD.hide()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                } else {
                    HUD.show(.progress, onView: self.view)
                    SectionDataHandler.shared.tempImageDictHolder = SectionDataHandler.shared.imageDictHolder
                    
                    print(SectionDataHandler.shared.tempImageDictHolder.keys.count)
                    print(SectionDataHandler.shared.tempImageDictHolder.keys)
                    
                    let imageDict = SectionDataHandler.shared.imageDictHolder
                    print(imageDict.keys.count)
                    print(imageDict.keys)
                    
                    var tempIndexes = [Int]()
                    
                    for index in 0..<Array(imageDict.keys).count {
                        
                        
                        ApiFunc.shared.uploadImageApi(self.view, Array(imageDict.values)[index]) { response in
                            
                            print(response.data.imageName)
                            SectionDataHandler.shared.tempImageDictHolder.updateValue(response.data.imageName ?? "" , forKey: Array(SectionDataHandler.shared.tempImageDictHolder.keys)[index])
                            print(Array(SectionDataHandler.shared.tempImageDictHolder.values)[index])
                            
                            tempIndexes.append(index)
                            print(tempIndexes.count)
                            print(Array(imageDict.keys).count)
                            let defaults = UserDefaults.standard
                            defaults.removeObject(forKey: "imageModel")
                            //                            let systemLocationTextdefaults = UserDefaults.standard
                            //                            defaults.removeObject(forKey: "systemLocationText")
                            SectionDataHandler.shared.imageDictHolder = [:]
                            defaults.synchronize()
                            if tempIndexes.count == Array(imageDict.keys).count {
                                //   HUD.show(.progress, onView: self.view)
                                DispatchQueue.main.asyncAfter(wallDeadline: .now()+0.5) {
                                    HUD.show(.progress, onView: self.view)
                                }
                                ApiFunc.shared.submitPdfApi(self.view, SingleTon.shared.userToken, clientImgsStr, inspectorImgsStr,self.fireExtinguisherSwitch,self.winterizationSwitch, self.responseString as String, SectionDataHandler.shared.flowTestTableValues, SectionDataHandler.shared.graphImageStr, timeTakenForInspection, chart1String, chart2String) { response in
                                    
                                    let defaults = UserDefaults.standard
                                    let dictionary = defaults.dictionaryRepresentation()
                                    defaults.removeObject(forKey: "model" + SectionDataHandler.shared.selectedReportId )
                                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "PdfViewerVC")as! PdfViewerVC
                                    vc.pdfLink = response.data.pdfName
                                    self.navigationController?.pushViewController(vc, animated: true)
                                }
                            }
                        }
                        
                        
                    }
                }
                
                
                print("******************************************")
            }else{
                // add text alert
                //1. Create the alert controller.
                let alert = UIAlertController(title: "Poseidon", message: "How long did inspection take?", preferredStyle: .alert)
                
              //  2. Add the text field. You can configure it however you need.
                alert.addTextField { (textField) in
                    // textField.text = "Enter time"
                    textField.delegate = self
                    
                    textField.keyboardType = UIKeyboardType.decimalPad
                    //new
                    let label = UILabel()
                    label.text = "min"
                    label.sizeToFit()
                    label.font = UIFont.systemFont(ofSize: 15)
                    
                    textField.rightView = label
                    textField.rightViewMode = .always
                    
                }

                
                alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
                    timeTakenForInspection = (alert?.textFields?[0].text)! // Force unwrapping because we know it exists.
                    
                    print("timeTakenForInspection------> ",timeTakenForInspection)
                    
                    
                    if SectionDataHandler.shared.imageDictHolder.keys.count == 0 {
                        HUD.show(.progress, onView: self.view)
                        let defaults = UserDefaults.standard
                        defaults.removeObject(forKey: "imageModel")
                        //                    let systemLocationTextdefaults = UserDefaults.standard
                        //                    defaults.removeObject(forKey: "systemLocationText")
                        SectionDataHandler.shared.imageDictHolder = [:]
                        defaults.synchronize()
                        ApiFunc.shared.submitPdfApi(self.view, SingleTon.shared.userToken, clientImgsStr, inspectorImgsStr,self.fireExtinguisherSwitch,self.winterizationSwitch, self.responseString as String, SectionDataHandler.shared.flowTestTableValues, SectionDataHandler.shared.graphImageStr, "\(timeTakenForInspection) ", chart1String, chart2String) { response in
                            
                            let defaults = UserDefaults.standard
                            //let dictionary = defaults.dictionaryRepresentation()
                            defaults.removeObject(forKey: "model" + SectionDataHandler.shared.selectedReportId)
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PdfViewerVC")as! PdfViewerVC
                            vc.pdfLink = response.data.pdfName
                            HUD.hide()
                            self.navigationController?.pushViewController(vc, animated: true)
                        }
                    } else {
                        HUD.show(.progress, onView: self.view)
                        SectionDataHandler.shared.tempImageDictHolder = SectionDataHandler.shared.imageDictHolder
                        
                        print(SectionDataHandler.shared.tempImageDictHolder.keys.count)
                        print(SectionDataHandler.shared.tempImageDictHolder.keys)
                        
                        let imageDict = SectionDataHandler.shared.imageDictHolder
                        print(imageDict.keys.count)
                        print(imageDict.keys)
                        
                        var tempIndexes = [Int]()
                        
                        for index in 0..<Array(imageDict.keys).count {
                            
                            
                            ApiFunc.shared.uploadImageApi(self.view, Array(imageDict.values)[index]) { response in
                                
                                print(response.data.imageName)
                                SectionDataHandler.shared.tempImageDictHolder.updateValue(response.data.imageName ?? "" , forKey: Array(SectionDataHandler.shared.tempImageDictHolder.keys)[index])
                                print(Array(SectionDataHandler.shared.tempImageDictHolder.values)[index])
                                
                                tempIndexes.append(index)
                                print(tempIndexes.count)
                                print(Array(imageDict.keys).count)
                                let defaults = UserDefaults.standard
                                defaults.removeObject(forKey: "imageModel")
                                //                            let systemLocationTextdefaults = UserDefaults.standard
                                //                            defaults.removeObject(forKey: "systemLocationText")
                                SectionDataHandler.shared.imageDictHolder = [:]
                                defaults.synchronize()
                                if tempIndexes.count == Array(imageDict.keys).count {
                                    //   HUD.show(.progress, onView: self.view)
                                    DispatchQueue.main.asyncAfter(wallDeadline: .now()+0.5) {
                                        HUD.show(.progress, onView: self.view)
                                    }
                                    ApiFunc.shared.submitPdfApi(self.view, SingleTon.shared.userToken, clientImgsStr, inspectorImgsStr,self.fireExtinguisherSwitch,self.winterizationSwitch, self.responseString as String, SectionDataHandler.shared.flowTestTableValues, SectionDataHandler.shared.graphImageStr, timeTakenForInspection, chart1String, chart2String) { response in
                                        
                                        let defaults = UserDefaults.standard
                                        let dictionary = defaults.dictionaryRepresentation()
                                        defaults.removeObject(forKey: "model" + SectionDataHandler.shared.selectedReportId )
                                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PdfViewerVC")as! PdfViewerVC
                                        vc.pdfLink = response.data.pdfName
                                        self.navigationController?.pushViewController(vc, animated: true)
                                    }
                                }
                            }
                            
                            
                        }
                    }
                    
                }))
                self.present(alert, animated: true, completion: nil)
            }
        }
        
        
        
      
        
       // ******************************
        
//        if checkSignatures() {
//            
//            print(SingleTon.shared.clientName)
//            print(SingleTon.shared.requestAddressLine1)
//            print(SingleTon.shared.requestAddressLine2)
//            print(SingleTon.shared.requestCity)
//            print(SingleTon.shared.requestState)
//            print(SingleTon.shared.postalCode)
//            
//            let clientSignImg = convertViewToImage(view: self.clientSignPad)
//            let inspectorSignImg = convertViewToImage(view: self.inspectorSignPad)
//            
//            let clientImgsStr = SectionDataHandler.shared.convertImageToBase64String2(img: clientSignImg!)
//            let inspectorImgsStr = SectionDataHandler.shared.convertImageToBase64String2(img: inspectorSignImg!)
//            
//            var timeTakenForInspection = String()
//            
//            // add text alert
//            //1. Create the alert controller.
//            let alert = UIAlertController(title: "Poseidon", message: "How long did inspection take?", preferredStyle: .alert)
//
//            //2. Add the text field. You can configure it however you need.
//            alert.addTextField { (textField) in
//                // textField.text = "Enter time"
//                textField.delegate = self
//               
//                textField.keyboardType = UIKeyboardType.alphabet
//              //  textField.addTarget(self, action: #selector(self.didtaptoChange), for: .allTouchEvents)
//            }
//
//            // 3. Grab the value from the text field, and print it when the user clicks OK.
//            alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak alert] (_) in
//                timeTakenForInspection = (alert?.textFields?[0].text)! // Force unwrapping because we know it exists.
//                
//                print("timeTakenForInspection------> ",timeTakenForInspection)
//                
//                
//                if SectionDataHandler.shared.imageDictHolder.keys.count == 0 {
//                    HUD.show(.progress, onView: self.view)
//                    let defaults = UserDefaults.standard
//                    defaults.removeObject(forKey: "imageModel")
//                    SectionDataHandler.shared.imageDictHolder = [:]
//                    defaults.synchronize()
//                    ApiFunc.shared.submitPdfApi(self.view, SingleTon.shared.userToken, clientImgsStr, inspectorImgsStr,self.fireExtinguisherSwitch,self.winterizationSwitch, self.responseString as String, SectionDataHandler.shared.flowTestTableValues, SectionDataHandler.shared.graphImageStr, timeTakenForInspection) { response in
//                        
//                        let defaults = UserDefaults.standard
//                        //let dictionary = defaults.dictionaryRepresentation()
//                        defaults.removeObject(forKey: "model" + SectionDataHandler.shared.selectedReportId)
//                        let vc = self.storyboard?.instantiateViewController(withIdentifier: "PdfViewerVC")as! PdfViewerVC
//                        vc.pdfLink = response.data.pdfName
//                        HUD.hide()
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                } else {
//                    HUD.show(.progress, onView: self.view)
//                    SectionDataHandler.shared.tempImageDictHolder = SectionDataHandler.shared.imageDictHolder
//                    
//                    print(SectionDataHandler.shared.tempImageDictHolder.keys.count)
//                    print(SectionDataHandler.shared.tempImageDictHolder.keys)
//                    
//                    //let imageDict = SectionDataHandler.shared.imageDictHolder
//                    let imageDict = SectionDataHandler.shared.allImagesArray
//                    print("imageDict+++++++++++++++++", imageDict)
//                    //  print(imageDict.keys.count)
//                    //  print(imageDict.keys)
//                    
//                    var tempIndexes = [Int]()
//                    
//                    var allImagesStr = [String]()
//                    for imgStr in imageDict {
//                        for index in 0..<Array(imgStr.keys).count {
//                            allImagesStr.append(Array(imgStr.values)[index])
//                        }
//                    }
//                    
//                    print(allImagesStr.count)// API param
//                    
//                    
//                    
//                    print(imageDict.count)
//                    
//                    var imagesToUpload: [[String: Any]] = []
//
//                    for imagePath in allImagesStr {
//                        let imageParam = [
//                            "images": imagePath
//                          
//                        ]
//                        imagesToUpload.append(imageParam)
//                    }
//                    
//                    
//                    
//                    
//                    //  for index in 0..<Array(imageDict.keys).count {
//                    ApiFunc.shared.uploadImageApi(self.view, imagesToUpload ){ response in
//                        print("resonse------>>>>>>>>>" , response)
//                        print("response.data.imageName-->", response?.data.imageName)
//                        //                                SectionDataHandler.shared.tempImageDictHolder.updateValue(response.data.imageName, forKey: Array(SectionDataHandler.shared.tempImageDictHolder.keys)[index])
//                        //                                print(Array(SectionDataHandler.shared.tempImageDictHolder.values)[index])
//                        //
//                        //                                tempIndexes.append(index)
//                        //                                print(tempIndexes.count)
//                        //                                print(Array(allImagesStr.keys).count)
//                        //  let defaults = UserDefaults.standard
//                        let defaults = UserDefaults.standard
//                         defaults.removeObject(forKey: "imageModel")
//                        
//                        
//                        //  SectionDataHandler.shared.imageDictHolder = [:]
//                        SectionDataHandler.shared.allImagesArray = [[:]]
//                        // defaults.synchronize()
//                        if tempIndexes.count == Array(allImagesStr).count {
//                            //   HUD.show(.progress, onView: self.view)
//                            DispatchQueue.main.asyncAfter(wallDeadline: .now()+0.5) {
//                                HUD.show(.progress, onView: self.view)
//                            }
//                            ApiFunc.shared.submitPdfApi(self.view, SingleTon.shared.userToken, clientImgsStr, inspectorImgsStr,self.fireExtinguisherSwitch,self.winterizationSwitch, self.responseString as String, SectionDataHandler.shared.flowTestTableValues, SectionDataHandler.shared.graphImageStr, timeTakenForInspection) { response in
//                                
//                                let defaults = UserDefaults.standard
//                                let dictionary = defaults.dictionaryRepresentation()
//                                defaults.removeObject(forKey: "model" + SectionDataHandler.shared.selectedReportId)
//                                let vc = self.storyboard?.instantiateViewController(withIdentifier: "PdfViewerVC")as! PdfViewerVC
//                                vc.pdfLink = response.data.pdfName
//                                self.navigationController?.pushViewController(vc, animated: true)
//                            }
//                        }
//                        
//                    
//                            
//                        }
//                    }
//                  
//
//                }
//                                          
//            ))
//            self.present(alert, animated: true, completion: nil)
//    
//        }
    }
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        print(textField)
//        return true
//    }
    
    
    let timePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .time
      
        picker.locale = Locale(identifier: "en_GB")
        picker.addTarget(self, action: #selector(handleTimePickerValueChanged(_:)), for: .valueChanged)
        return picker
    }()
    
    
    @objc func didtaptoChange() {
        // Add the date picker to the view
        view.addSubview(timePicker)
        
        // Position the date picker at the bottom of the screen
        timePicker.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            timePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            timePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            timePicker.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100)
        ])
       
        // Animate the date picker to slide from the bottom
        UIView.animate(withDuration: 0.3) {
            self.timePicker.frame.origin.y -= self.timePicker.frame.height
        }
    }

    
//    print("ghjghjghjghj")
//    view.addSubview(timePicker)
//
//    timePicker.translatesAutoresizingMaskIntoConstraints = false
//    NSLayoutConstraint.activate([
//        timePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//        
//    ])
//    
  
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        self.textField = textField
//       
//        textField.inputView = timePicker
//    }

   
    @objc func handleTimePickerValueChanged(_ sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH 'hours' mm 'min'"
        let selectedTime = dateFormatter.string(from: sender.date)
        print("Selected time: \(selectedTime)")
        textField?.text = selectedTime
    }
//    @objc func handleTimePickerValueChanged(_ sender: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "HH 'hours' mm 'min'"
//        let selectedTime = dateFormatter.string(from: sender.date)
//        print("Selected time: \(selectedTime)")
//        textField.text = selectedTime
//    }
    @IBAction func clientSignClearBtnTapped(_ sender: UIButton) {
        clientSignPad.clear()
    }
    @IBAction func inspectorSignClearBtnTapped(_ sender: UIButton) {
        inspectorSignPad.clear()
    }
    
    func checkSignatures() -> Bool {
        if clientSignPad.lines.count == 0 {
            UIApplication.shared.currentWindow?.rootViewController?.showOnlyAlert("", message: "Please add client's signature")
            return false
        } else if inspectorSignPad.lines.count == 0 {
            UIApplication.shared.currentWindow?.rootViewController?.showOnlyAlert("", message: "Please add inspector's signature")
            return false
        } else {
            return true
        }
    }
    
    
    func convertViewToImage(view: UIView) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
        defer { UIGraphicsEndImageContext() }
        if let context = UIGraphicsGetCurrentContext() {
            view.layer.render(in: context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            return image
        }
        return nil
    }
}
