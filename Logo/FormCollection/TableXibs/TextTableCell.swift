//  TextTableCell.swift
//  Logo
//  Created by Mobile on 21/12/22.

import UIKit

class TextTableCell: UITableViewCell {

    @IBOutlet weak var basevw: UIView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var questionTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        updateBackgroundColor()
    }

    
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                basevw.backgroundColor = ThemeColor.darkThemeCellBGColor
                textField.textColor = .black
            }else{
                
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.textField.text = ""
    }
}
