//
//  CalanderHomeViewCell.swift
//  Logo
//
//  Created by Vishal on 05/04/24.
//

import UIKit

class CalanderHomeViewCell: UICollectionViewCell {
    
    @IBOutlet weak var super_VW: UIView!
    @IBOutlet weak var vw_Top: UIView!
    @IBOutlet weak var lbl_Appointment: UILabel!
    
    @IBOutlet weak var lbl_Location: UILabel!
    @IBOutlet weak var llbl_Name: UILabel!
    @IBOutlet weak var lbl_time: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        vw_Top.layer.shadowRadius = 4
        vw_Top.layer.cornerRadius = 12
        updateBackgroundColor()
        
    }
 
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                super_VW.backgroundColor = ThemeColor.darkThemeViewBGColor
                lbl_Appointment.textColor = .black
                lbl_time.textColor = .black
                llbl_Name.textColor = .black
                lbl_Location.textColor = .black
            }else{
               
            }
        }
    }
    
 
   }


