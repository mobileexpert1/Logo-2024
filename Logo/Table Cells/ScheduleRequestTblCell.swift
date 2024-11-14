//
//  ScheduleRequestTblCell.swift
//  Logo
//
//  Created by Mobile on 25/05/23.
//

import UIKit

class ScheduleRequestTblCell: UITableViewCell {
    
    @IBOutlet weak var mainVw: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionTxtVw: UITextView!
    @IBOutlet weak var dateTimeLbl: UILabel!
    @IBOutlet weak var acceptBtn: UIButton!
    @IBOutlet weak var rejectBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        mainVw.clipsToBounds = true
        mainVw.layer.cornerRadius = 12.0
        
        acceptBtn.clipsToBounds = true
        acceptBtn.layer.cornerRadius = 5.0
        
        rejectBtn.clipsToBounds = true
        rejectBtn.layer.cornerRadius = 5.0
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
