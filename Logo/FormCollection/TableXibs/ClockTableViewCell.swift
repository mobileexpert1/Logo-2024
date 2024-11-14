//
//  ClockTableViewCell.swift
//  Logo
//
//  Created by Mobile on 24/03/23.
//

import UIKit

class ClockTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var clockInLbl: UILabel!
    @IBOutlet weak var clockOutLbl: UILabel!
    @IBOutlet weak var clockDateLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var greyVw: UIView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        greyVw.clipsToBounds = true
        greyVw.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
