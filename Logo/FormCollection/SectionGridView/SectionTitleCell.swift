//  SectionTitleCell.swift
//  Logo
//  Created by Mobile on 21/12/22.

import UIKit

class SectionTitleCell: UICollectionViewCell {
    
    @IBOutlet weak var blueTickIcon: UIImageView!
    @IBOutlet weak var sectionTitle: UILabel!
    @IBOutlet weak var systemId: UILabel!
    
    @IBOutlet weak var base_Vw: UIView!
    @IBOutlet weak var center_Vw: UIView!
    @IBOutlet weak var lbl_SectionTxt: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyling(to: base_Vw)
    }
    func applyStyling(to view: UIView) {
           
           view.layer.cornerRadius = 15
           view.backgroundColor = UIColor.white
           view.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
           view.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
           view.layer.shadowOpacity = 1.5
           view.layer.shadowRadius = 4
        
       }
    
}





