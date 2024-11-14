//
//  AllRequestsTableViewCell.swift
//  Logo
//
//  Created by Mobile on 05/04/24.
//

import UIKit

class AllRequestsTableViewCell: UITableViewCell {

    @IBOutlet weak var content_VW: UIView!
    @IBOutlet weak var lbl_Header: UILabel!
    
    @IBOutlet weak var vwheader: UIView!
    @IBOutlet weak var lbl_Time: UILabel!
    @IBOutlet weak var lbl_SubHeader: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        applyStyling(to: vwheader)
        updateBackgroundColor()
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

    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
              
                content_VW.backgroundColor = ThemeColor.darkThemeCellBGColor
                vwheader.backgroundColor = ThemeColor.lightThemeImageTintColor
//                dayWorkCheckImage.tintColor = .white
//                extraWorkCheckImage.tintColor = .white
//                contractWorkCheckImage.tintColor = .white
        
            }
            else{
//                dayWorkCheckImage.tintColor = .black
//                extraWorkCheckImage.tintColor = .black
//                contractWorkCheckImage.tintColor = .black
            }
        }
    }
}
