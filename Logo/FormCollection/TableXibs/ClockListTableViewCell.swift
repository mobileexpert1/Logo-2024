//
//  ClockListTableViewCell.swift
//  Logo
//
//  Created by Mobile on 28/03/23.
//

import UIKit

class ClockListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var projectNameLbl: UILabel!
    @IBOutlet weak var projectAddressLbl: UILabel!
    @IBOutlet weak var punchSwitch: UISwitch!
    @IBOutlet weak var distanceLbl: UILabel!
    @IBOutlet weak var cellVw: UIView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
