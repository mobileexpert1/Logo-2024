//
//  SubjectChatTblCell.swift
//  Logo
//
//  Created by MOBILE on 02/08/23.
//

import UIKit

class SubjectChatTblCell: UITableViewCell {
    
    @IBOutlet weak var mainVw: UIView!
    @IBOutlet weak var subjectLbl: UILabel!
    @IBOutlet weak var arrowImg: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
