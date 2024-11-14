//
//  OrganizationListTVC.swift
//  Logo
//
//  Created by Vishal on 11/06/24.
//

import UIKit
import Lightbox

class OrganizationListTVC: UITableViewCell {
    
    @IBOutlet weak var Base_View: UIView!
    @IBOutlet weak var img_organization: UIImageView!
    
    @IBOutlet weak var lbl_Name: UILabel!
   
  
    
    @IBOutlet weak var lbl_Number: UILabel!
    @IBOutlet weak var lbl_Email: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyling(to: Base_View)
        
      //  contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 50))
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
