//  GraphCell.swift
//  Logo
//  Created by Mobile on 27/12/22.

import UIKit

class GraphCell: UITableViewCell {

    @IBOutlet weak var base_vw: UIView!
    @IBOutlet weak var questionTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        updateBackgroundColor()
    }
    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    base_vw.backgroundColor = ThemeColor.darkThemeCellBGColor
                }else{
                    
                }
            }
        }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
