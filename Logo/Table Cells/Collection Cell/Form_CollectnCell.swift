//
//  Form_CollectnCell.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 05/03/22.
//

import UIKit

class Form_CollectnCell: UICollectionViewCell {
    @IBOutlet weak var baseView_FormC_C: UIView!
    
    @IBOutlet weak var label_FormC_C: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.baseView_FormC_C.layer.cornerRadius = 10
        baseView_FormC_C.clipsToBounds = true
//        baseView_FormC_C.layer.masksToBounds = true
       
    }

}
