//
//  EmergencyWorkOrderTblCell.swift
//  Logo
//
//  Created by MOBILE on 25/08/23.
//

import UIKit

class EmergencyWorkOrderTblCell: UITableViewCell {
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var mainVw: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyling(to: mainVw)
    }
    func applyStyling(to view: UIView) {
           
           view.layer.cornerRadius = 12
           //view.backgroundColor = UIColor.white
           view.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
           view.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
        view.layer.shadowOpacity = 0.5
           view.layer.shadowRadius = 4
        
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
