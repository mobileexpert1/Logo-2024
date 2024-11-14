//  PickerTableCell.swift
//  Logo
//  Created by Mobile on 21/12/22.

import UIKit

class PickerTableCell: UITableViewCell {
   
    @IBOutlet weak var pickervw: UIView!
    @IBOutlet weak var base_Vw: UIView!
    @IBOutlet weak var pickerCollectionView: UICollectionView!
    @IBOutlet weak var plusIcon: UIImageView!
    @IBOutlet weak var questionTitle: UILabel!
    var itemsArray = [String]()
    var localFilledDict = [String:Any]()
    var localSelectedIndex = Int()
    var currentTag = Int()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        pickerCollectionView.delegate = self
        pickerCollectionView.dataSource = self
        updateBackgroundColor()
    }
    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    base_Vw.backgroundColor = ThemeColor.darkThemeCellBGColor
                    pickervw.backgroundColor = ThemeColor.darkThemeCellBGColor
                   // pickerCollectionView.backgroundColor = .red
                }else{
                    
                }
            }
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        itemsArray = []
        pickerCollectionView.reloadData()
    }
    
    
    func checkForAvailableDict(_ indexPath : IndexPath, _ selectedIndex: Int) {
       
        localSelectedIndex = selectedIndex
        currentTag = indexPath.row
        
//        let filledDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any]
//
//        if let dict = filledDict {
//            print(dict)
//
//            if let array = dict[SectionDataHandler.shared.model.data[selectedIndex].questionJSON![indexPath.row].answer] {
//                itemsArray = (array as! String).components(separatedBy: ",#")
//                pickerCollectionView.reloadData()
//            }
//        }
        
        
        if  let storedModel = UserDefaults.standard.object(forKey: "model" + SectionDataHandler.shared.selectedReportId) as? Data {
            let model = try! PropertyListDecoder().decode(SectionApiModel.self, from: storedModel)
            
            
            if !model.data[selectedIndex].questionJSON![indexPath.row].answer.isEmpty {
                let array = model.data[selectedIndex].questionJSON![indexPath.row].answer
                    itemsArray = array.components(separatedBy: ",#")
                    pickerCollectionView.reloadData()
            }
            
        }
        
        
    }
    
    func setDataWithTypes(_ textToAdd : String, _ indexPath : IndexPath, _ selectedIndex: Int, _ filledDict : inout [String:Any]) {
        localSelectedIndex = selectedIndex
        itemsArray.append(textToAdd)
        pickerCollectionView.reloadData()
        SectionDataHandler.shared.model.data[selectedIndex].questionJSON![indexPath.row].answer = itemsArray.joined(separator: ",#")
        
        let model = SectionDataHandler.shared.model
        try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model" + SectionDataHandler.shared.selectedReportId)
        
//        filledDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
//        filledDict[SectionDataHandler.shared.model.data[selectedIndex].questionJSON![indexPath.row].answer] = itemsArray.joined(separator: ",#")
//        UserDefaults.standard.set(filledDict, forKey: "filledDataDict")
//        print(filledDict)
        
//        localFilledDict = filledDict
        currentTag = indexPath.row
        print("-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-------> ",self.localSelectedIndex)
        
        print("onAdded :- > ",SectionDataHandler.shared.model.data[selectedIndex].questionJSON![indexPath.row].question)
        print("onAdded :- > ",SectionDataHandler.shared.model.data[selectedIndex].questionJSON![indexPath.row].answer)
        
        
        print("test1", SectionDataHandler.shared.model.data[selectedIndex].questionJSON![indexPath.row].question)
        print("test1", SectionDataHandler.shared.model.data[selectedIndex].questionJSON![indexPath.row].answer)
    }
    
}

extension PickerTableCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PickerCollectionCell", for: indexPath) as! PickerCollectionCell
        cell.pickerTextLabel.text = itemsArray[indexPath.row]
        cell.pickerTextLabel.textColor = .white
        cell.pickerTextLabel.tag = indexPath.row
        let longPressRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(longPressed(_:)))
        longPressRecognizer.delegate = self
        cell.contentView.addGestureRecognizer(longPressRecognizer)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: itemsArray[indexPath.item].size(withAttributes: [
            NSAttributedString.Key.font : UIFont.systemFont(ofSize: 17),
        ]).width + 25, height: 50)
    }
    
    @objc func longPressed(_ sender: UILongPressGestureRecognizer) {
        print("button long pressed")
        guard sender.state != .ended else { return }
            let point = sender.location(in: pickerCollectionView)
            let indexPath = pickerCollectionView.indexPathForItem(at: point)
            if let index = indexPath{
                  print(index.row)
                //collectnCellTag = index.row
              //  handleLongs()
                
                let alert = UIAlertController(title: "Alert", message: "Are you sure you want to delete \(self.itemsArray[indexPath!.row])", preferredStyle: .alert)
                // add the actions (buttons)
                alert.addAction(UIAlertAction(title: "Yes", style: UIAlertAction.Style.default, handler: {_ in
                    print(self.itemsArray)
                    self.itemsArray.remove(at: self.itemsArray.firstIndex(of: self.itemsArray[indexPath!.row])!)
                    print(self.itemsArray)
                    
                   
                    print("-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-------> ",self.localSelectedIndex)
                    print(self.currentTag)
                    SectionDataHandler.shared.model.data[self.localSelectedIndex].questionJSON![self.currentTag].answer = self.itemsArray.joined(separator: ",#")
                   
                    print("test2", SectionDataHandler.shared.model.data[self.localSelectedIndex].questionJSON![self.currentTag].question)
                    print("test2", SectionDataHandler.shared.model.data[self.localSelectedIndex].questionJSON![self.currentTag].answer)
                    
                    
                    let model = SectionDataHandler.shared.model
                    try? UserDefaults.standard.set(PropertyListEncoder().encode(model), forKey: "model" + SectionDataHandler.shared.selectedReportId)
                    
                    
//                    self.localFilledDict = UserDefaults.standard.object(forKey: "filledDataDict") as? [String:Any] ?? [:]
//                    self.localFilledDict[SectionDataHandler.shared.model.data[indexPath!.row].questionJSON![indexPath!.row].answer] = self.itemsArray.joined(separator: ",#")
//                    UserDefaults.standard.set(self.localFilledDict, forKey: "filledDataDict")
//                    print(self.localFilledDict)
                    
                    
                    alert.dismiss(animated: true)
                    self.pickerCollectionView.reloadData()
                }))
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))

                UIApplication.visibleViewController.present(alert, animated: true, completion: nil)
                
            }
            else{
                  print("Could not find index path")
            }
    }
    
}
