//
//  Form_VC.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 05/03/22.
//
import IQKeyboardManagerSwift
import UIKit
var pickerCollectionData = [String]()
var collecIndex = -1

//var pickerCollectionViewTag = -1
class Form_VC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var myPickerView : UIPickerView!
    //    let toolBar = UIToolbar()
    let datePicker = UIDatePicker()
    var priviousFieldTag = -1
    var fieldTag = -1
    var btnTag = -1
    var pickerFieldTag = -1
    var imgUploadBtnTag = -1
    var selectedArr = [[String : Any]]()
    var pickerData = [String]()
    var selectedText = ""
    var selectedDate = ""
    var graphPopUp:GraphView!
    
    
    
    @IBOutlet weak var formCollectionView: UICollectionView!
    @IBOutlet weak var formTableView: UITableView!
    @IBOutlet weak var submitBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        submitBtn.setTitle("Next", for: .normal)
        setNavigationBar(vc: self, middleTitle: "Form", leftAction: #selector(RightBtnAction(sender:)),rightAction: #selector(RightBtnAction(sender:)))
        formCollectionView.allowsMultipleSelection = false
        let indexPathForFirstRow = IndexPath(row: 0, section: 0)
        formCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .centeredHorizontally, animated: true)
        self.collectionView(formCollectionView, didSelectItemAt: indexPathForFirstRow)
        NotificationCenter.default.addObserver(self,selector:#selector(reloadTableView(_:)), name: NSNotification.Name ("formTableViewReloadData"), object: nil)

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self, name:  NSNotification.Name("formTableViewReloadData"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        Indicator.sharedInstance.hideIndicator()
        formTableView.allowsSelection = true
        //        formTableView.sectionIndexColor = .red
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print ("view release memory ")
    }
    
    @objc func RightBtnAction(sender: UIButton){
        if graphPopUp != nil{
            if  (self.navigationController!.view.subviews.contains(graphPopUp)){
            graphPopUp.removeFromSuperview()
        }
    }
        navigationController?.popViewController(animated: true)
    
}
    
    func setupUI(){
        self.capsuleButton(submitBtn)
        Form_CollectnCell.registerCollectionCell(for: formCollectionView)
        Form_TableCell.registerTableCell(for: formTableView)
    }
    
    @IBAction func submitBtnAction(_ sender: UIButton) {
        print(collecIndex)
        if submitBtn.currentTitle == "Submit" {
            //Indicator.sharedInstance.showIndicator()
            //            let dd = dataFromLastVC as! [String:Any]
            //            print(dd)
            //
            //            self.pushWithData("SignatureVC", dd)

            
            print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
            print("pipeHangersValueSectionDic\n ",pipeHangersValueSectionDic)
            print("generalDic\n ",generalDic)
            print("fdcDic\n ",fdcDic)
            print("headsDic\n ",headsDic)
            print("wetpipeDic\n ",wetpipeDic)
            print("drypipeDic\n ",drypipeDic)
            print("tanksDic\n ",tanksDic)
            print("foamDic\n ",foamDic)
            print("standpipeDic\n ",standpipeDic)
            print("pumpDic\n ",pumpDic)
            print("FlowTestDic\n ",FlowTestDic)
            print("whilePumpIsRunningDic\n ",whilePumpIsRunningDic)
            print("checkListDic\n ",checkListDic)
            print("transferSwitchDic\n ",transferSwitchDic)
            print("extinguishersDic\n ",extinguishersDic)
            print("fireHydrantDic\n ",fireHydrantDic)
            print("*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*")
            
            PdfJsonHandler().setupPipeHangerValueFormDict()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignatureVC")as! SignatureVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        self.view.hideKeyboard()
        
        if collecIndex < titleArr.count - 1 {
            formCollectionView.reloadData()
            formTableView.scrollToTop(isAnimated: false)
            
            formCollectionView.scrollToItem(at: IndexPath(item: collecIndex + 1, section: 0), at: .centeredHorizontally, animated: true)
            collecIndex = collecIndex + 1
            
            formCollectionView.reloadData()
            
            switch collecIndex {
            case 0:
//                selectedArr = generalDic
//                formTableView.reloadData()
                selectedArr = pipeDic
                formTableView.reloadData()
            case 1:
//                selectedArr = pipeDic
//                formTableView.reloadData()
                selectedArr = generalDic
                formTableView.reloadData()
            case 2:
                selectedArr = fdcDic
                formTableView.reloadData()
            case 3:
                selectedArr = headsDic
                formTableView.reloadData()
            case 4:
                selectedArr = wetpipeDic
                formTableView.reloadData()
            case 5:
                selectedArr = drypipeDic
                formTableView.reloadData()
            case 6:
                selectedArr = tanksDic
                formTableView.reloadData()
            case 7:
                selectedArr = foamDic
                formTableView.reloadData()
            case 8:
                selectedArr = standpipeDic
                formTableView.reloadData()
            case 9:
                selectedArr = pumpDic
                formTableView.reloadData()
            case 10:
                selectedArr = FlowTestDic
                formTableView.reloadData()
            case 11:
                selectedArr = whilePumpIsRunningDic
                formTableView.reloadData()
            case 12:
                selectedArr = checkListDic
                formTableView.reloadData()
            case 13:
                selectedArr = transferSwitchDic
                formTableView.reloadData()
            case 14:
                selectedArr = extinguishersDic
                formTableView.reloadData()
            case 15:
                selectedArr = fireHydrantDic
                formTableView.reloadData()
            default:
                break
            }
            
            if collecIndex == titleArr.count - 1 {
                submitBtn.setTitle("Submit", for: .normal)
            } else {
                submitBtn.setTitle("Next", for: .normal)
            }
        }
    }
    
    func tableScrollToTop() {
        let indexPath = IndexPath(row: collecIndex, section: 0)
        formTableView.scrollToRow(at: indexPath, at: .top, animated: false)
    }
}

extension Form_VC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = formCollectionView.dequeueReusableCell(withReuseIdentifier: "Form_CollectnCell", for: indexPath) as! Form_CollectnCell
        cell.label_FormC_C.textColor =  UIColor(named: "Main_Color")
        cell.label_FormC_C.text = titleArr[indexPath.row]
        if indexPath.row == collecIndex {
            cell.label_FormC_C.backgroundColor = UIColor(named: "Main_Color")
            cell.label_FormC_C.textColor = .white
        } else {
            cell.label_FormC_C.backgroundColor = UIColor(named: "Cell_Color")
            cell.label_FormC_C.textColor =  UIColor(named: "Main_Color")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch UIDevice.current.userInterfaceIdiom {
        case .phone:
            return CGSize (width: ((titleArr[indexPath.row].widthofstring(usingfont: UIFont(name: "Lato-Regular", size: 20)!)) + 40), height: formCollectionView.frame.height / 1.2)
        case .pad:
            return CGSize (width: ((titleArr[indexPath.row].widthofstring(usingfont: UIFont(name: "Lato-Regular", size: 28)!)) + 60), height: formCollectionView.frame.height / 1.4)
        default:
            return CGSize (width: ((titleArr[indexPath.row].widthofstring(usingfont: UIFont(name: "Lato-Regular", size: 20)!)) + 40), height: formCollectionView.frame.height / 1.4)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.hideKeyboard()
        collecIndex = indexPath.row
        formCollectionView.reloadData()
        formTableView.scrollToTop(isAnimated: false)
        switch indexPath.row {
        case 0:
//            selectedArr = generalDic
//            formTableView.reloadData()
            selectedArr = pipeDic
            formTableView.reloadData()
        case 1:
//            selectedArr = pipeDic
//            formTableView.reloadData()
            selectedArr = generalDic
            formTableView.reloadData()
        case 2:
            selectedArr = fdcDic
            formTableView.reloadData()
        case 3:
            selectedArr = headsDic
            formTableView.reloadData()
        case 4:
            selectedArr = wetpipeDic
            formTableView.reloadData()
        case 5:
            selectedArr = drypipeDic
            formTableView.reloadData()
        case 6:
            selectedArr = tanksDic
            formTableView.reloadData()
        case 7:
            selectedArr = foamDic
            formTableView.reloadData()
        case 8:
            selectedArr = standpipeDic
            formTableView.reloadData()
        case 9:
            selectedArr = pumpDic
            formTableView.reloadData()
        case 10:
            selectedArr = FlowTestDic
            formTableView.reloadData()
        case 11:
            selectedArr = whilePumpIsRunningDic
            formTableView.reloadData()
        case 12:
            selectedArr = checkListDic
            formTableView.reloadData()
        case 13:
            selectedArr = transferSwitchDic
            formTableView.reloadData()
        case 14:
            selectedArr = extinguishersDic
            formTableView.reloadData()
        case 15:
            selectedArr = fireHydrantDic
            formTableView.reloadData()
        default:
            break
        }
        
        if collecIndex == titleArr.count - 1 {
            submitBtn.setTitle("Submit", for: .normal)
        } else {
            submitBtn.setTitle("Next", for: .normal)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        visibleRect.origin = formCollectionView.contentOffset
        visibleRect.size = formCollectionView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        guard let indexPath = formCollectionView.indexPathForItem(at: visiblePoint) else { return }
    }
}

extension Form_VC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = formTableView.dequeueReusableCell(withIdentifier: "Form_TableCell", for: indexPath)as! Form_TableCell
        cell.contentLbl_FormLblC.text = selectedArr[indexPath.row]["text"] as? String
        
        //--Tags
        cell.tag = 1000+indexPath.row
        cell.yesBtn_FormTblC.tag = indexPath.row
        cell.noBtn_FormTblC.tag = indexPath.row
        cell.nilBtn_FormTblCell.tag = indexPath.row
        cell.noBtn_Image.tag = indexPath.row
        cell.yesBtn_Image.tag = indexPath.row
        cell.nilBtn_Image.tag = indexPath.row
        cell.textInput_field.tag = indexPath.row
        cell.textBox.tag = indexPath.row
        cell.uploded_Image.tag = indexPath.row
        cell.uploadBtn.tag = indexPath.row
        cell.imageDeletBtn.tag = indexPath.row
        cell.pickerData_CollectionView.tag = indexPath.row
        cell.picker_Field.tag = indexPath.row
        
        //--DELEGATE METHODS
        cell.textBox.delegate = self
        cell.textInput_field.delegate = self
        cell.picker_Field.delegate = self
        cell.textBox.delegate = self
        cell.selectionStyle = .none
        
        //--SET TOOLBAR ON TEXTFIELDS AND TEXTVIEW
        cell.addtoolBAr(textVw: cell.textBox, textField: cell.textInput_field)
        cell.textInput_field.tintColor = .systemBlue
        //--HIDE All VIEWS
        cell.buttons_View.isHidden = true
        cell.txtField_View.isHidden = true
        cell.imgUploadButton_View.isHidden = true
        cell.textViewer_View.isHidden = true
        cell.ImageUpload_BaseView.isHidden = true
        cell.pickerCollection_BaseView.isHidden = true
        
        
        //--To Show DATA  IN TABLE VIEW
        
        switch collecIndex {
        case 0:
            /*let dictArr = generalDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = generalDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = generalDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(generalDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(generalDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(generalDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = generalDic[indexPath.row]["uploadImg"] as? UIImage
            if generalDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }*/
            let dictArr = pipeDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = pipeDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = pipeDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(pipeDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(pipeDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(pipeDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = pipeDic[indexPath.row]["uploadImg"] as? UIImage
            if pipeDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 1:
            /*let dictArr = pipeDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = pipeDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = pipeDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(pipeDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(pipeDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(pipeDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = pipeDic[indexPath.row]["uploadImg"] as? UIImage
            if pipeDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }*/
            let dictArr = generalDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = generalDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = generalDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(generalDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(generalDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(generalDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = generalDic[indexPath.row]["uploadImg"] as? UIImage
            if generalDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 2:
            let dictArr = fdcDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = fdcDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = fdcDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(fdcDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(fdcDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(fdcDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = fdcDic[indexPath.row]["uploadImg"] as? UIImage
            if fdcDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 3:
            
            let dictArr = headsDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            print(headsDic[indexPath.row]["pickerSelections"] as Any )
            
            cell.textInput_field.text = headsDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = headsDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(headsDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(headsDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(headsDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = headsDic[indexPath.row]["uploadImg"] as? UIImage
            if headsDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 4:
            let dictArr = wetpipeDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = wetpipeDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = wetpipeDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(wetpipeDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(wetpipeDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(wetpipeDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = wetpipeDic[indexPath.row]["uploadImg"] as? UIImage
            if wetpipeDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 5://-------
            let dictArr = drypipeDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = drypipeDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = drypipeDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(drypipeDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(drypipeDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(drypipeDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = drypipeDic[indexPath.row]["uploadImg"] as? UIImage
            if drypipeDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 6:
            let dictArr = tanksDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = tanksDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = tanksDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(tanksDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(tanksDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(tanksDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = tanksDic[indexPath.row]["uploadImg"] as? UIImage
            if tanksDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 7:
            let dictArr = foamDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = foamDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = foamDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(foamDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(foamDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(foamDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = foamDic[indexPath.row]["uploadImg"] as? UIImage
            if foamDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 8:
            let dictArr = standpipeDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = standpipeDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = standpipeDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(standpipeDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(standpipeDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(standpipeDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = standpipeDic[indexPath.row]["uploadImg"] as? UIImage
            if standpipeDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 9:
            let dictArr = pumpDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = pumpDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = pumpDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(pumpDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(pumpDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(pumpDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = pumpDic[indexPath.row]["uploadImg"] as? UIImage
            if pumpDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 10:
            let dictArr = FlowTestDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = FlowTestDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = FlowTestDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(FlowTestDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(FlowTestDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(FlowTestDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = FlowTestDic[indexPath.row]["uploadImg"] as? UIImage
            if FlowTestDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 11:
            let dictArr = whilePumpIsRunningDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = whilePumpIsRunningDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = whilePumpIsRunningDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(whilePumpIsRunningDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(whilePumpIsRunningDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(whilePumpIsRunningDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = whilePumpIsRunningDic[indexPath.row]["uploadImg"] as? UIImage
            if whilePumpIsRunningDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 12:
            let dictArr = checkListDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = checkListDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = checkListDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(checkListDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(checkListDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(checkListDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = checkListDic[indexPath.row]["uploadImg"] as? UIImage
            if checkListDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 13:
            let dictArr = transferSwitchDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = transferSwitchDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = transferSwitchDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(transferSwitchDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(transferSwitchDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(transferSwitchDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = transferSwitchDic[indexPath.row]["uploadImg"] as? UIImage
            if transferSwitchDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
        case 14:
            let dictArr = extinguishersDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = extinguishersDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = extinguishersDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(extinguishersDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(extinguishersDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(extinguishersDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = extinguishersDic[indexPath.row]["uploadImg"] as? UIImage
            if extinguishersDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
            
        case 15:
            let dictArr = fireHydrantDic[indexPath.row]["pickerSelections"] as! [String]
            cell.updateCellWith(data: dictArr)
            cell.textInput_field.text = fireHydrantDic[indexPath.row]["textFieldText"] as? String
            cell.textBox.text = fireHydrantDic[indexPath.row]["textViewText"] as? String
            cell.yesBtn_Image.image = UIImage(named: "\(fireHydrantDic[indexPath.row]["yesBtn"] ?? "radio-off-button")")
            cell.noBtn_Image.image = UIImage(named: "\(fireHydrantDic[indexPath.row]["noBtn"] ?? "radio-on-button")")
            cell.nilBtn_Image.image = UIImage(named: "\(fireHydrantDic[indexPath.row]["nilBtn"] ?? "radio-off-button")")
            cell.uploded_Image.image = fireHydrantDic[indexPath.row]["uploadImg"] as? UIImage
            if fireHydrantDic[indexPath.row]["uploadImg"] as! UIImage != UIImage(){
                cell.ImageUpload_BaseView.isHidden = false
            }
            
        default:
            cell.collectioDataArr = [String]()
        }
        //------------------
        //---Image Delet Button Action
        cell.imageDeletBtn.addTapGestureRecognizer(){
            
            switch collecIndex {
            case 0:
//                generalDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
//                self.formTableView.reloadData()
                generalDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 1:
//                generalDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
//                self.formTableView.reloadData()
                generalDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 2:
                fdcDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 3:
                headsDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 4:
                wetpipeDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 5:
                drypipeDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 6:
                tanksDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 7:
                foamDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 8:
                standpipeDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 9:
                pumpDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 10:
                FlowTestDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 11:
                whilePumpIsRunningDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 12:
                checkListDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 13:
                transferSwitchDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 14:
                extinguishersDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            case 15:
                fireHydrantDic[cell.imageDeletBtn.tag].updateValue(UIImage(), forKey: "uploadImg")
                self.formTableView.reloadData()
            default:
                break
            }
            
            
            
        }
        
        //--ADDING TAPGUESSTERS ON  "YES" BUTTON
        
        cell.yesBtn_FormTblC.addTapGestureRecognizer(){
            self.btnTag = cell.yesBtn_FormTblC.tag
            switch collecIndex {
            case 0:
//                generalDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
//                generalDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
//                generalDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
//                self.formTableView.reloadData()
//                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                pipeDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                pipeDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                pipeDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 1:
//                pipeDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
//                pipeDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
//                pipeDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
//                self.formTableView.reloadData()
//                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                generalDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                generalDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                generalDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 2:
                fdcDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                fdcDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                fdcDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 3:
                headsDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                headsDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                headsDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 4:
                wetpipeDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                wetpipeDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                wetpipeDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 5:
                drypipeDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                drypipeDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                drypipeDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 6:
                tanksDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                tanksDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                tanksDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 7:
                foamDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                foamDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                foamDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 8:
                standpipeDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                standpipeDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                standpipeDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 9:
                pumpDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                pumpDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                pumpDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 10:
                FlowTestDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                FlowTestDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                FlowTestDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 11:
                whilePumpIsRunningDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                whilePumpIsRunningDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                whilePumpIsRunningDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 12:
                checkListDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                checkListDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                checkListDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                
            case 13:
                transferSwitchDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                transferSwitchDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                transferSwitchDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                
            case 14:
                extinguishersDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                extinguishersDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                extinguishersDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                
            case 15:
                fireHydrantDic[self.btnTag].updateValue("radio-on-button", forKey: "yesBtn")
                fireHydrantDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                fireHydrantDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            default:
                break
            }
        }
        
        //--ADDING TAPGUESSTERS ON  "NO" BUTTON
        
        cell.noBtn_FormTblC.addTapGestureRecognizer(){
            self.btnTag = cell.noBtn_FormTblC.tag
            switch collecIndex {
            case 0:
//                generalDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
//                generalDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
//                generalDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
//                self.formTableView.reloadData()
//                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                pipeDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                pipeDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                pipeDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 1:
//                pipeDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
//                pipeDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
//                pipeDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
//                self.formTableView.reloadData()
//                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                generalDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                generalDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                generalDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 2:
                fdcDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                fdcDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                fdcDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 3:
                headsDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                headsDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                headsDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 4:
                wetpipeDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                wetpipeDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                wetpipeDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 5:
                drypipeDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                drypipeDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                drypipeDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 6:
                tanksDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                tanksDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                tanksDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 7:
                foamDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                foamDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                foamDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 8:
                standpipeDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                standpipeDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                standpipeDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 9:
                pumpDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                pumpDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                pumpDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 10:
                FlowTestDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                FlowTestDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                FlowTestDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 11:
                whilePumpIsRunningDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                whilePumpIsRunningDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                whilePumpIsRunningDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 12:
                checkListDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                checkListDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                checkListDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                
            case 13:
                transferSwitchDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                transferSwitchDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                transferSwitchDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                
            case 14:
                extinguishersDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                extinguishersDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                extinguishersDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                
            case 15:
                fireHydrantDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                fireHydrantDic[self.btnTag].updateValue("radio-on-button", forKey: "noBtn")
                fireHydrantDic[self.btnTag].updateValue("radio-off-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            default:
                break
            }
            
        }
        //--ADDING TAPGUESSTERS ON  "NIL" BUTTON
        
        cell.nilBtn_FormTblCell.addTapGestureRecognizer(){
            self.btnTag = cell.nilBtn_FormTblCell.tag
            switch collecIndex {
            case 0:
//                generalDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
//                generalDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
//                generalDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
//                self.formTableView.reloadData()
//                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                pipeDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                pipeDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                pipeDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 1:
//                pipeDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
//                pipeDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
//                pipeDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
//                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                generalDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                generalDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                generalDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 2:
                fdcDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                fdcDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                fdcDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 3:
                headsDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                headsDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                headsDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 4:
                wetpipeDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                wetpipeDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                wetpipeDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 5:
                drypipeDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                drypipeDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                drypipeDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 6:
                tanksDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                tanksDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                tanksDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 7:
                foamDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                foamDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                foamDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 8:
                standpipeDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                standpipeDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                standpipeDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 9:
                pumpDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                pumpDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                pumpDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 10:
                FlowTestDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                FlowTestDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                FlowTestDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 11:
                whilePumpIsRunningDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                whilePumpIsRunningDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                whilePumpIsRunningDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 12:
                checkListDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                checkListDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                checkListDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                
            case 13:
                transferSwitchDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                transferSwitchDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                transferSwitchDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
                
            case 14:
                extinguishersDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                extinguishersDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                extinguishersDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            case 15:
                fireHydrantDic[self.btnTag].updateValue("radio-off-button", forKey: "yesBtn")
                fireHydrantDic[self.btnTag].updateValue("radio-off-button", forKey: "noBtn")
                fireHydrantDic[self.btnTag].updateValue("radio-on-button", forKey: "nilBtn")
                self.formTableView.reloadData()
                print("cell.yesBtn_FormTblC.tag :: \(cell.yesBtn_FormTblC.tag)")
            default:
                break
            }
        }
        
        
        switch selectedArr[indexPath.row]["type"] as! String {
        case "ynan": //-- CASE FOR BUTTONS
            cell.buttons_View.isHidden = false
        case "text-input": //-- CASE FOR TESXT-INPUT FIELDS
            cell.txtField_View.isHidden = false
        case "image-upload"://--CASE FOR IMAGE UPLOADING
            
            cell.imgUploadButton_View.isHidden = false
            //            cell.ImageUpload_BaseView.isHidden = imageViewHidden
            cell.uploadBtn.addTarget(self, action: #selector (imageUploadBtnAction(sender:)), for: .touchUpInside)
        case "text-box": //--CASE FOR TEXTVIEW FIELDS
            cell.textViewer_View.isHidden = false
        case "select"://-- CASE FOR PICKERVIEW FIELDS
            //            cell.textInput_field.tintColor = .clear
            cell.picker_Field.textColor = .clear
            cell.picker_Field.tintColor = .clear
            //            cell.txtField_View.isHidden = false
            cell.pickerCollection_BaseView.isHidden = false
        case "text-date"://-- CASE FOR DATEPICKER FIELDS
            cell.textInput_field.tintColor = .clear
            cell.txtField_View.isHidden = false
        case "flow-test-table":
            cell.txtField_View.isHidden = false
            print("Another Field type Is :: flow-test-table")
            
        case "electric-driven-table":
            cell.txtField_View.isHidden = false
            print("Another Field type Is :: electric-driven-table")
            
        default:
            break
        }
        return cell
    }
    //--TABLEVIEW CELL HEIGHT
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    //     func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    //        pickerCollectionViewTag = indexPath.row
    //        printContent(pickerCollectionViewTag)
    //
    //      }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print ("cell selected ")
    }
    //-- TEXTFIELD RETURN BUTTON ACTION
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //--PICKER VIEW OPENING FUNCTION
    
    //-- TEXTFIELD START EDITING FUNCTION
    func textFieldDidBeginEditing(_ textField: UITextField) {
        selectedText = ""
        fieldTag = textField.tag
        pickerFieldTag = fieldTag
        //--Clear PICEKERCOLLECTION DATA IF TEXTFIELD CHANGED
        if priviousFieldTag != fieldTag{
            pickerCollectionData = [String]()
        }
        
        switch selectedArr[textField.tag]["type"] as! String {
            
        case "select" : //--CASE FOR PICKER VIEW
            self.pickUp(textField)
            IQKeyboardManager.shared.enableAutoToolbar = false
            //-- Show Data in Picker
            let data = selectedArr[textField.tag]["options"]
            pickerData = data as! [String]
            myPickerView.selectRow(0, inComponent: 0, animated: true)
            print(pickerData)
            
        case "text-date" ://--CASE FOR DATE PICKER
            self.addInputViewDatePicker(field: textField)
            //textField.isEnabled = false
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            selectedDate = dateFormatter.string(from: datePicker.date)
            print(selectedDate)
//        MARK: - Flow Test Popup Call
        case "flow-test-table": //-- case graph Maker
            showInspectPopUp(tag: fieldTag)
        case "electric-driven-table":
            showInspectPopUp(tag: fieldTag)
        default:
            textField.inputView = nil
            textField.inputAccessoryView = nil
            textField.becomeFirstResponder()
        }
        print("textFieldDidBeginEditing  Start")
        IQKeyboardManager.shared.enableAutoToolbar = true
    }
    
//MARK: - Graph View Open
    func showInspectPopUp(tag:Int){
        graphPopUp = GraphView()
        graphPopUp?.cancelButton.actionBlock { [weak self] in
            guard let self = self else { return }
            self.graphPopUp?.removeFromSuperview()
        }
        graphPopUp?.UploadGraphBtn.actionBlock { [weak self] in
            guard let self = self else { return }
            
            let graphImage = self.graphPopUp?.generateImage()
            self.insertImagesToDictionarry(byTag: tag, image: graphImage!)
             self.graphPopUp?.removeFromSuperview()
            self.graphPopUp = nil
           }
        self.view.addSubview(self.graphPopUp)
        self.navigationController?.view.addSubview(self.graphPopUp)
        let guide = self.view.safeAreaLayoutGuide
        self.graphPopUp.layout{
            $0.top.equal(to: guide.topAnchor,offsetBy: 0)
            $0.leading.equal(to: guide.leadingAnchor,offsetBy: 0)
            $0.trailing.equal(to: guide.trailingAnchor,offsetBy: 0)
            $0.bottom.equal(to: guide.bottomAnchor,offsetBy: 0)
        }
//        self.graphPopUp.frame = (self.navigationController?.view.frame)!
        
        //self.tabBarController?.view.addSubview(self.completeKyc)
       
    }
    
    
    
    
    //-- TEXTFIELD END EDITING FUNCTION
    func textFieldDidEndEditing(_ textField: UITextField) {
        priviousFieldTag = textField.tag
        
        let txt = textField.text!
        switch selectedArr[textField.tag]["type"] as! String {
        case "select"://--CASE FOR PICKER VIEW
            switch collecIndex {
                // -- 1 picker data text into selectedText var
                //--2 selectedText Append in pickerCollectionData
                //--3 while textField change pickerCollectionDataArr Empty in texField Begin Editing
                //--4 pickerCollectionData Arr assign To DIctioary key "pickerSelections"
                //--4 collecton view pass data from Global Var collectioDataArr
                //--6 collectioDataArr Assign value from Dictionaries key "pickerSelections" at [indexpath.row] and tableview Reload data
            case 0:
//                if selectedText != "" {
//                    pickerCollectionData.append(selectedText)
//                }
//                generalDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
//                formTableView.reloadData()
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                pipeDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 1:
//                if selectedText != "" {
//                    pickerCollectionData.append(selectedText)
//                }
//                pipeDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
//                formTableView.reloadData()
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                generalDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 2:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                pickerCollectionData.append(selectedText)
                fdcDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 3:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                headsDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 4:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                wetpipeDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 5:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                drypipeDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 6:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                tanksDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 7:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                foamDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 8:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                standpipeDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 9:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                pumpDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 10:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                FlowTestDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 11:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                whilePumpIsRunningDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 12:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                checkListDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 13:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                transferSwitchDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 14:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                extinguishersDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            case 15:
                if selectedText != "" {
                    pickerCollectionData.append(selectedText)
                }
                fireHydrantDic[fieldTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
                formTableView.reloadData()
            default:
                break
            }
        case "text-date"://--CASE FOR DATE PICKER
            switch collecIndex {
            case 0:
//                generalDic[fieldTag].updateValue(selectedDate , forKey: "textFieldText")
//                formTableView.reloadData()
                pipeDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 1:
                generalDic[fieldTag].updateValue(selectedDate , forKey: "textFieldText")
                formTableView.reloadData()
//                pipeDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
//                formTableView.reloadData()
            case 2:
                fdcDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 3:
                headsDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 4:
                wetpipeDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 5:
                drypipeDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 6:
                tanksDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
                
            case 7:
                foamDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 8:
                standpipeDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 9:
                pumpDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 10:
                FlowTestDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 11:
                whilePumpIsRunningDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 12:
                checkListDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 13:
                transferSwitchDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 14:
                extinguishersDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            case 15:
                fireHydrantDic[fieldTag].updateValue(selectedDate, forKey: "textFieldText")
                formTableView.reloadData()
            default:
                break
            }
        default:
            switch collecIndex { //-- FOR INPUT TEXTFIELDS
            case 0:
//                generalDic[fieldTag].updateValue(txt , forKey: "textFieldText")
//                formTableView.reloadData()
                pipeDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 1:
                generalDic[fieldTag].updateValue(txt , forKey: "textFieldText")
                formTableView.reloadData()
//                pipeDic[fieldTag].updateValue(txt, forKey: "textFieldText")
//                formTableView.reloadData()
            case 2:
                fdcDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 3:
                headsDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 4:
                wetpipeDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 5:
                drypipeDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 6:
                tanksDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
                
            case 7:
                foamDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 8:
                standpipeDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 9:
                pumpDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 10:
                FlowTestDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 11:
                whilePumpIsRunningDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 12:
                checkListDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 13:
                transferSwitchDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 14:
                extinguishersDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            case 15:
                fireHydrantDic[fieldTag].updateValue(txt, forKey: "textFieldText")
                formTableView.reloadData()
            default:
                break
            }
        }
        print("textFieldDidEndEditing")
    }
    //--TEXTVIEW START EDITING FUNCTION
    func textViewDidBeginEditing(_ textView: UITextView) {
        print("textViewDidBeginEditing start")
    }
    //--TEXTVIEW END EDITING FUNCTION
    func textViewDidEndEditing(_ textView: UITextView) {
        let txt = textView.text!
        switch collecIndex {
        case 0:
//            generalDic[textView.tag].updateValue(txt , forKey: "textViewText")
//            formTableView.reloadData()
            pipeDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 1:
            generalDic[textView.tag].updateValue(txt , forKey: "textViewText")
            formTableView.reloadData()
//            pipeDic[textView.tag].updateValue(txt, forKey: "textViewText")
//            formTableView.reloadData()
        case 2:
            fdcDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 3:
            headsDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 4:
            wetpipeDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 5:
            drypipeDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 6:
            tanksDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 7:
            foamDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 8:
            standpipeDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 9:
            pumpDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 10:
            FlowTestDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 11:
            whilePumpIsRunningDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 12:
            checkListDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 13:
            transferSwitchDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 14:
            extinguishersDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        case 15:
            fireHydrantDic[textView.tag].updateValue(txt, forKey: "textViewText")
            formTableView.reloadData()
        default:
            break
        }
        
    }
    
    //--IMAGE UPLOAD BUTTON ACTION
    @objc func imageUploadBtnAction(sender: UIButton){
        imgUploadBtnTag = sender.tag
        self.openImagePicker(sender: sender)
        
        
        DispatchQueue.main.async {
            self.formTableView.reloadData()
        }
    }
    @objc func reloadTableView(_ notification: Notification){
        //.... code process
        print("Notification ObserVer Working ")
        self.formTableView.reloadData()
        
    }
    
}
extension UITableView {
    
    func scrollToBottom(isAnimated:Bool = true){
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .bottom, animated: isAnimated)
            }
        }
    }
    
    func scrollToTop(isAnimated:Bool = true) {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            if self.hasRowAtIndexPath(indexPath: indexPath) {
                self.scrollToRow(at: indexPath, at: .top, animated: isAnimated)
            }
        }
    }
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
}

