//
//  BuildingViewListCell.swift
//  Logo
//
//  Created by Vishal on 12/06/24.
//

import UIKit

class BuildingViewListCell: UITableViewCell {
    
    @IBOutlet weak var buildingListName: UILabel!
    @IBOutlet weak var baseView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        applyStyling(to: baseView)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func applyStyling(to view: UIView) {
        view.layer.cornerRadius = 12
        view.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
        view.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 4
        
    }
}
