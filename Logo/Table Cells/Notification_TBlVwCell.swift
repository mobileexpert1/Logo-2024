//
//  Notification_TBlVwCell.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 05/03/22.
//

import UIKit

class Notification_TBlVwCell: UITableViewCell {
    
var message = "When you present the details controller view, it will grow to take up the entire screen. When dismissed, it will shrink to the image’s original frame."
    
    @IBOutlet weak var baseView_NC: UIView!
    @IBOutlet weak var userNameLbl_NC: UILabel!
    @IBOutlet weak var messageLbl_NC: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        baseView_NC.layer.cornerRadius = 20
        setTextWithLineSpacing(label: messageLbl_NC, text: message, lineSpacing: 5)
    }

    func setTextWithLineSpacing(label:UILabel,text:String,lineSpacing:CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing

        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attrString.length))

        label.attributedText = attrString
    }
}

