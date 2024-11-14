//
//  Home_TBlVwCell.swift
//  Logo
//
//  Created by Nihal kamboj on 04/03/22.
//

import UIKit

class Home_TBlVwCell: UITableViewCell {

    @IBOutlet weak var inspectionTypeLbl: UILabel!
    @IBOutlet weak var baseView_HomeCell: UIView!
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var leftImg_HomeCell: LazyImageView!
    @IBOutlet weak var locationIcon_homeCell: UIImageView!
    //--Labels outlet
    @IBOutlet weak var nameLabel_HomeCell: UILabel!
    @IBOutlet weak var locationLabel_HomeCell: UILabel!
    
    @IBOutlet weak var lbladdress: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
        
        
        baseView_HomeCell.layer.cornerRadius = 12
        //view.backgroundColor = UIColor.white
        baseView_HomeCell.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
        baseView_HomeCell.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
        baseView_HomeCell.layer.shadowOpacity = 1.5
        baseView_HomeCell.layer.shadowRadius = 4
        //baseView_HomeCell.roundCorners(corners: [.topLeft, .topRight], radius: 30, newWidth: self.baseView_HomeCell.frame.width)
        
//        circleView(view: leftImg_HomeCell)
        
    }
    override func layoutSubviews() {
                 super.layoutSubviews()
        //circleView(view: leftImg_HomeCell)
       }

   
    
}
class LazyImageView: UIImageView
{

    private let imageCache = NSCache<AnyObject, UIImage>()

    func loadImage(fromURL imageURL: URL, placeHolderImage: String) {
        print("imageURL Start= ",imageURL)
        self.image = UIImage(named: placeHolderImage)

        if let cachedImage = self.imageCache.object(forKey: imageURL as AnyObject) {
            print("imageURL Meduim= ",imageURL)
            debugPrint("image loaded from cache for =\(imageURL)")
            self.image = cachedImage
            return
        }

        DispatchQueue.global().async { [weak self] in
            print("imageURL DispatchQueue Center = ",imageURL)
            if let imageData = try? Data(contentsOf: imageURL) {
                print("imageURL imageData = ",imageURL)
                debugPrint("image downloaded from server...")
                if let image = UIImage(data: imageData) {
                    print("imageURL image = ",image)
                    DispatchQueue.main.async {
                        print("imageCache image = ",image)
                        self!.imageCache.setObject(image, forKey: imageURL as AnyObject)
                        self?.image = image
                        print("imageCach FInal= ",image)
                    }
                }
            }
        }
    }
}
