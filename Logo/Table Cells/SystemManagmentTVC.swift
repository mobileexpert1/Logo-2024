//
//  SystemManagmentTVC.swift
//  Logo
//
//  Created by Vishal on 13/06/24.
//

import UIKit

class SystemManagmentTVC: UITableViewCell {
    @IBOutlet weak var Base_View: UIView!
  
    @IBOutlet weak var lbl_SystemID: UILabel!
    
    @IBOutlet weak var lbl_SystemName: UILabel!
    
    @IBOutlet weak var lbl_SystemLocation: UILabel!
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyling(to: Base_View)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    func applyStyling(to view: UIView) {
           
           view.layer.cornerRadius = 12
           //view.backgroundColor = UIColor.white
           view.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
           view.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
        view.layer.shadowOpacity = 0.5
           view.layer.shadowRadius = 4
        
       }
}
