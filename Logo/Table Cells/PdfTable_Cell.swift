//
//  PdfTable_Cell.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 17/03/22.
//

import UIKit

class PdfTable_Cell: UITableViewCell {

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
  var pdfCollecArr = [String]()
    
    @IBOutlet weak var bottomLabels_View: UIView!
    @IBOutlet weak var imge_View: UIView!
    @IBOutlet weak var quesLabel: UILabel!
    @IBOutlet weak var yesLabel: UILabel!
    
    @IBOutlet weak var LeftBottomLabel: UILabel!
    @IBOutlet weak var width_YesLbl: NSLayoutConstraint!
  
    @IBOutlet weak var leftBottomLbl_Width: NSLayoutConstraint!
    
    @IBOutlet weak var textViewerLabel: UITextView!
    
    @IBOutlet weak var textViewer_Height: NSLayoutConstraint!
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var textViewr_BaseView: UIView!
    
    @IBOutlet weak var textViewrBaseView_Height: NSLayoutConstraint!
    @IBOutlet weak var heading_BaseView: UIView!
    
    @IBOutlet weak var pageHeadingLabel: UILabel!
    @IBOutlet weak var collecBase_Height: NSLayoutConstraint!
    @IBOutlet weak var pdfCollec_BaseView: UIView!
    @IBOutlet weak var pdfTable_CollectnView: UICollectionView!
    @IBOutlet weak var pdfCollectn_Height: NSLayoutConstraint!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionViewHeight()
        pdfTable_CollectnView.layoutIfNeeded()
        
        PickerDataCollctn_Cell.registerCollectionCell(for: pdfTable_CollectnView)
       yesLabel.layer.cornerRadius = yesLabel.frame.height / 2
       yesLabel.clipsToBounds = true
       
       LeftBottomLabel.layer.cornerRadius = 8
       LeftBottomLabel.clipsToBounds = true
        textViewerLabel.layer.cornerRadius = 8
        textViewerLabel.clipsToBounds = true
        textViewerLabel.isScrollEnabled = false
        textViewerLabel.isEditable = false
        textViewerLabel.textColor = .white
        textViewerLabel.backgroundColor = UIColor(named: "NaColor")
        pdfTable_CollectnView.delegate = self
        pdfTable_CollectnView.dataSource = self
        pageHeadingLabel.font = .boldSystemFont(ofSize: 25)
    }
    
    func sendDataToArry(data: [String]) {
        pdfCollecArr = data
        pdfTable_CollectnView.reloadData()
        
    }
    func collectionViewHeight() {
        
        let height = pdfTable_CollectnView.collectionViewLayout.collectionViewContentSize.height
        pdfCollectn_Height.constant = height
        self.pdfTable_CollectnView.layoutSubviews()
    }
}
extension PdfTable_Cell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pdfCollecArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = pdfTable_CollectnView.dequeueReusableCell(withReuseIdentifier: "PickerDataCollctn_Cell", for: indexPath)as! PickerDataCollctn_Cell
        cell.textLabel_PickerCell.text  = pdfCollecArr[indexPath.row]
        cell.textLabel_PickerCell.backgroundColor = UIColor(named:"NaColor")
        cell.textLabel_PickerCell.textColor = .white
//        cell.contentView.layer.cornerRadius = 10
//        cell.contentView.clipsToBounds = true
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad
        {
            return CGSize (width: ((pdfCollecArr[indexPath.row].widthofstring(usingfont: UIFont(name: "Lato-Regular", size: 30)!)) + 40) , height: 50)
        }
        
        else{
            return CGSize (width: ((pdfCollecArr[indexPath.row].widthofstring(usingfont: UIFont(name: "Lato-Regular", size: 20)!)) + 10) , height: 30)
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
