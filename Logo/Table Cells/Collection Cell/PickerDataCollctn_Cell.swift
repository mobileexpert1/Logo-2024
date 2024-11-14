//
//  pickerData_CollectionViewCell.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 22/03/22.
//

import UIKit

class PickerDataCollctn_Cell: UICollectionViewCell {

    @IBOutlet weak var txtLabel_BaseView: UIView!
    
    @IBOutlet weak var textLabel_PickerCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        textLabel_PickerCell.layer.cornerRadius = 10
        textLabel_PickerCell.clipsToBounds = true
       
      
        
    }
}
