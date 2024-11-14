//
//  MeetingsPdfTblCell.swift
//  Logo
//
//  Created by MOBILE on 28/07/23.
//

import UIKit

class MeetingsPdfTblCell: UITableViewCell {
    
    @IBOutlet weak var pdfTitleLbl: UILabel!
    @IBOutlet weak var pdfDateLbl: UILabel!
    @IBOutlet weak var mainVw: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        mainVw.clipsToBounds = true
        mainVw.layer.cornerRadius = 12.0
    }

  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
