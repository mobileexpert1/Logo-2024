//  TextViewTableCell.swift
//  Logo
//  Created by Mobile on 21/12/22.

import UIKit

class TextViewTableCell: UITableViewCell {

    @IBOutlet weak var base_Vw: UIView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var questionTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        updateBackgroundColor()
    }
    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    base_Vw.backgroundColor = ThemeColor.darkThemeCellBGColor
                    textView.textColor = .black
                    
                }else{
                    
                }
            }
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        self.textView.text = ""
    }
}
