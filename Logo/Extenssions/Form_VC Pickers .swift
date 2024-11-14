   //
//  Picker .swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 11/03/22.
//
import UIKit

extension Form_VC: UIPickerViewDelegate,UIPickerViewDataSource {
    func pickUp(_ textField : UITextField,pickerHidden:Bool = false) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 300))
        } else {
            self.myPickerView = UIPickerView(frame:CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 216))
        }
        self.myPickerView.delegate = self
        self.myPickerView.dataSource = self
        self.myPickerView.backgroundColor = UIColor.white
        textField.inputView = self.myPickerView
        
        self.myPickerView.isHidden = pickerHidden
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(cancelButtonPressed1))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self , action: #selector(doneButtonPressed1))
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        textField.inputAccessoryView = toolBar
        toolBar.sizeToFit()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        var title = UILabel()
        if let view = view {
            title = view as! UILabel
        }
        title.font = UIFont(name: "Lato-Regular", size: 20)
        title.textColor = .black
        title.text =  pickerData[row]
        title.textAlignment = .center
        
        return title
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedText = pickerData[row]
//        field.inputAccessoryView = toolBar
    }
    @objc func doneButtonPressed1() {
        if selectedText == "" {
            selectedText = pickerData[0]
        }
        view.hideKeyboard()
    }
    @objc func cancelButtonPressed1() {
        view.hideKeyboard()
    }
}

extension Form_VC {
    func addInputViewDatePicker(field: UITextField, pickerHidden: Bool = false) {
        //Add DatePicker as inputView
        datePicker.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 216)
        datePicker.datePickerMode = .date
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        field.inputView = datePicker
        datePicker.isHidden = pickerHidden
        
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
//        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self , action: #selector(doneButtonPressed))
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        toolBar.sizeToFit()
        field.inputAccessoryView = toolBar
    }
    
    @objc func doneButtonPressed() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        selectedDate = dateFormatter.string(from: datePicker.date)
        print(selectedDate)
        view.hideKeyboard()
    }
    @objc func cancelButtonPressed() {
        view.hideKeyboard()
    }
}

extension Form_VC:UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverPresentationControllerDelegate {
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
            pickedImage = imagePicker
        }
        insertImagesToDictionarry(byTag: imgUploadBtnTag, image: pickedImage)
        self.dismiss(animated: true) {
            self.formTableView.reloadData()
        }
    }
    
    func insertImagesToDictionarry(byTag:Int,image:UIImage) {
        switch collecIndex {
        case 0:
            generalDic[byTag].updateValue(image , forKey: "uploadImg")
            self.formTableView.reloadData()
        case 1:
            pipeDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 2:
            fdcDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 3:
            headsDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 4:
            wetpipeDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 5:
            drypipeDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 6:
            tanksDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 7:
            foamDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 8:
            standpipeDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 9:
            pumpDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 10:
            FlowTestDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 11:
            whilePumpIsRunningDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 12:
            checkListDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 13:
            transferSwitchDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 14:
            extinguishersDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
        case 15:
            fireHydrantDic[byTag].updateValue(image, forKey: "uploadImg")
            self.formTableView.reloadData()
            
        default:
            break
        }
    }
}
