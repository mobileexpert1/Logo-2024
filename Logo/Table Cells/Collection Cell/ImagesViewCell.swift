//
//  ImagesViewCell.swift
//  Logo
//
//  Created by Vishal on 15/04/24.
//

import UIKit

class ImagesViewCell: UICollectionViewCell {
    @IBOutlet weak var imageHolderViewHyt: NSLayoutConstraint!
  
   
   
    
    @IBOutlet weak var crossIcon: UIImageView!
    @IBOutlet weak var imageHolderImageView: UIImageView!
    @IBOutlet weak var imageHolderView: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
   
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        imageHolderImageView?.image = nil
//        imageHolderView.isHidden = true
//        imageHolderViewHyt.constant = 0
//        
//    }
}
