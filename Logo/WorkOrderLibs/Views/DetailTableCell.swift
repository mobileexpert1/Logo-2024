//  LaborTableCell.swift
//  FireDepartment
//  Created by Akshay on 24/01/22.

import UIKit

class DetailTableCell: UITableViewCell {

    @IBOutlet weak var quantityTxtField: UILabel!
    @IBOutlet weak var amountTextField: UILabel!
    
    @IBOutlet weak var priceTextField: UILabel!
    
    
    @IBOutlet weak var priceLblWidth: NSLayoutConstraint!
    @IBOutlet weak var materialTextField: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
