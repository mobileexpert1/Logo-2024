//  BoolTableCell.swift
//  Logo
//  Created by Mobile on 21/12/22.

import UIKit

class BoolTableCell: UITableViewCell {
    
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var nilBtn: UIButton!
    @IBOutlet weak var noBtn: UIButton!
    @IBOutlet weak var yesBtn: UIButton!
    
    @IBOutlet weak var base_vw: UIView!
    @IBOutlet weak var yesRadioIcon: UIImageView!
    @IBOutlet weak var nilRadioIcon: UIImageView!
    @IBOutlet weak var noRadioIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateBackgroundColor()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                base_vw.backgroundColor = ThemeColor.darkThemeCellBGColor
            }else{
                
            }
        }
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        yesRadioIcon.image = #imageLiteral(resourceName: "radio-off-button")
        nilRadioIcon.image = #imageLiteral(resourceName: "radio-off-button")
        noRadioIcon.image = #imageLiteral(resourceName: "radio-off-button")
    }
}
