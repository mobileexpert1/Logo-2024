//
//  Form_TableCell.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 05/03/22.
//

import UIKit

class Form_TableCell: UITableViewCell {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
   var collectioDataArr = [String]()
    var collectnCellTag = -1
    var surerViewTag = -1
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var baseView_FormTblC: UIView!
    @IBOutlet weak var label_View: UIView!
    @IBOutlet weak var buttons_View: UIView!
    @IBOutlet weak var txtField_View: UIView!
    @IBOutlet weak var imgUploadButton_View: UIView!
    @IBOutlet weak var textViewer_View: UIView!
    @IBOutlet weak var ImageUpload_BaseView: UIView!
    
    @IBOutlet weak var contentLbl_FormLblC: UILabel!
    @IBOutlet weak var yesBtn_FormTblC: UIButton!
    @IBOutlet weak var noBtn_FormTblC: UIButton!
    @IBOutlet weak var nilBtn_FormTblCell: UIButton!
    @IBOutlet weak var uploadBtn: UIButton!
    
    @IBOutlet weak var pickerCollection_BaseView: UIView!
    @IBOutlet weak var pickerData_CollectionView: UICollectionView!
    
    
    @IBOutlet weak var imageDeletBtn: UIImageView!
    @IBOutlet weak var uploded_Image: UIImageView!
    @IBOutlet weak var yesBtn_Image: UIImageView!
    @IBOutlet weak var noBtn_Image: UIImageView!
    @IBOutlet weak var nilBtn_Image: UIImageView!
    
    
    @IBOutlet weak var picker_Field: UITextField!
    @IBOutlet weak var textInput_field: UITextField!
    @IBOutlet weak var textBox: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUI()
        buttons_View.isHidden = true
        txtField_View.isHidden = false
        imgUploadButton_View.isHidden = true
        textViewer_View.isHidden = true
        pickerData_CollectionView.delegate = self
        pickerData_CollectionView.dataSource = self
        PickerDataCollctn_Cell.registerCollectionCell(for: pickerData_CollectionView)
    }
    
    func setUI(){
        textInput_field.setLeftPaddingPoints(20)
        textBox.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        noBtn_Image.image = UIImage(named: "radio-off-button")
        yesBtn_Image.image = UIImage(named: "radio-off-button")
        nilBtn_Image.image =  UIImage(named: "radio-off-button")
        uploadBtn.layer.cornerRadius = 10
        uploadBtn.clipsToBounds = true
        stackView.roundCorners([.bottomLeft,.bottomRight], radius: 20)
        baseView_FormTblC.layer.cornerRadius = 20
        self.addShadow1(view: baseView_FormTblC)
        
    }
    func addShadow1(view: UIView) {
        view.backgroundColor = UIColor(white: 100, alpha: 1)
        view.layer.cornerRadius = 20
        view.layer.borderColor = UIColor.white.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 3.0
        view.layer.shadowOffset = .zero// Use any CGSize
        view.layer.shadowColor = UIColor(named: "shadow_5")?.cgColor
        
    }
    func updateCellWith(data : [String]) {
        collectioDataArr = data
//            appDelegate.collectioDataArr = data
            print("collection Data Array is :: \(collectioDataArr)")

            self.pickerData_CollectionView.reloadData()
            self.pickerData_CollectionView.collectionViewLayout.invalidateLayout()
            self.pickerData_CollectionView.layoutSubviews()
       
        
    }
}

extension Form_TableCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectioDataArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pickerData_CollectionView.dequeueReusableCell(withReuseIdentifier: "PickerDataCollctn_Cell", for: indexPath) as! PickerDataCollctn_Cell
        cell.txtLabel_BaseView.tag = indexPath.row
        let isIndexValid = collectioDataArr.indices.contains(indexPath.row)
        if isIndexValid {
            cell.textLabel_PickerCell.text = collectioDataArr[indexPath.row]
            collectnCellTag = cell.txtLabel_BaseView.tag
            let superTag = collectionView.tag
            surerViewTag = superTag
            self.setupLongGestureRecognizerOnCollection(view: cell.txtLabel_BaseView)
        }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize (width: ((collectioDataArr[indexPath.row].widthofstring(usingfont: UIFont(name: "Lato-Regular", size: 20)!)) + 40) , height: pickerData_CollectionView.frame.height / 1.4)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      
    }
    private func setupLongGestureRecognizerOnCollection(view:UIView) {
        
//        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
//        longPressedGesture.minimumPressDuration = 0.5
//        longPressedGesture.numberOfTapsRequired = 0
//        longPressedGesture.delegate = self
//        longPressedGesture.delaysTouchesBegan = false
//
//        longPressedGesture.delaysTouchesEnded = true
//        self.addGestureRecognizer(longPressedGesture)
        //MARK: - new method
        
        let longPressedGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gestureRecognizer:)))
        longPressedGesture.minimumPressDuration = 0.5
     
        longPressedGesture.delegate = self
        longPressedGesture.delaysTouchesBegan = true
        
        self.addGestureRecognizer(longPressedGesture)
        
        //---------
    }
    
    @objc func handleLongPress(gestureRecognizer: UILongPressGestureRecognizer) {
        print("collectnCellTag\(collectnCellTag)")
        
//        handleLongs()
        //MARK: - new method
        guard gestureRecognizer.state != .began else { return }
            let point = gestureRecognizer.location(in: pickerData_CollectionView)
            let indexPath = pickerData_CollectionView.indexPathForItem(at: point)
            if let index = indexPath{
                  print(index.row)
                collectnCellTag = index.row
                handleLongs()
            }
            else{
                  print("Could not find index path")
            }
        //------------
        
        NotificationCenter.default.post(name:NSNotification.Name("formTableViewReloadData"),object: nil,userInfo: nil)
    }
    func handleLongs() {
        //        print("Button long Pressed:: tag is \(collectnCellTag)")
        switch collecIndex {
        case 0:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            generalDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 1:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            pipeDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 2:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            fdcDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 3:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            headsDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()
        case 4:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            wetpipeDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 5:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            drypipeDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 6:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            tanksDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 7:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            foamDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 8:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            standpipeDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 9:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            pumpDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 10:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            FlowTestDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 11:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            whilePumpIsRunningDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 12:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            checkListDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 13:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            transferSwitchDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()

        case 14:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            extinguishersDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()
        case 15:
            if pickerCollectionData.indices.contains(collectnCellTag){
                pickerCollectionData.remove(at: collectnCellTag)
            }
            fireHydrantDic[surerViewTag].updateValue(pickerCollectionData, forKey: "pickerSelections")
            pickerData_CollectionView.reloadData()
            
        default:
            break
        }
    }
}
