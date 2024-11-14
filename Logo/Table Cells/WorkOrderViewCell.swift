//
//  WorkOrderViewCell.swift
//  Logo
//
//  Created by Vishal on 08/04/24.
//

import UIKit

class WorkOrderViewCell: UITableViewCell {

    @IBOutlet weak var img_Vw: UIImageView!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_Appointment: UILabel!
    @IBOutlet weak var vw_Header: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyling(to: vw_Header)
    }
    func applyStyling(to view: UIView) {
           
           view.layer.cornerRadius = 12
           //view.backgroundColor = UIColor.white
           view.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
           view.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
           view.layer.shadowOpacity = 1.5
           view.layer.shadowRadius = 4
        
       }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
