//  DateTableCell.swift
//  Logo
//  Created by Mobile on 23/12/22.

import UIKit

class DateTableCell: UITableViewCell {
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var dateTextField: DatePickerField!
    
    @IBOutlet weak var base_vw: UIView!
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
    
    override func prepareForReuse() {
        self.dateTextField.text = ""
    }
}
