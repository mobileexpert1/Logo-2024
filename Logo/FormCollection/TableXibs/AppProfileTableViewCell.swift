//
//  AppProfileTableViewCell.swift
//  Logo
//
//  Created by Mobile on 24/03/23.
//

import UIKit

class AppProfileTableViewCell: UITableViewCell {
    
    @IBOutlet weak var greyVw: UIView!
    @IBOutlet weak var appProfileLbl: UILabel!
    

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
