//
//  CompletedReqTableViewCell.swift
//  Logo
//
//  Created by Mobile on 12/04/23.
//

import UIKit

class CompletedReqTableViewCell: UITableViewCell {
    
    @IBOutlet weak var reportPdfBtn: UIButton!
    @IBOutlet weak var reportNameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
