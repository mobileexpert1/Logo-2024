//  YearTableCell.swift
//  Logo
//  Created by Mobile on 23/12/22.

import UIKit

class YearTableCell: UITableViewCell {

    @IBOutlet weak var base_Vw: UIView!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var questionTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        updateBackgroundColor()
    }

    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    base_Vw.backgroundColor = ThemeColor.darkThemeCellBGColor
                    yearTextField.textColor = .black
                }else{
                    
                }
            }
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.yearTextField.text = ""
    }
}
