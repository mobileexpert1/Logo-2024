//
//  CalanderHomeReusableView.swift
//  Logo
//
//  Created by Vishal on 05/04/24.
//

import UIKit

class CalanderHomeReusableView: UICollectionReusableView {
    
    @IBOutlet weak var lbl_Header: UILabel!
    
    @IBOutlet weak var base_Vw: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        updateBackgroundColor()
    }
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
                base_Vw.backgroundColor = ThemeColor.darkThemeViewBGColor
                lbl_Header.textColor = .black
            }else{
               
            }
        }
    }
}
