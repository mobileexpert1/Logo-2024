//  ImageTableCell.swift
//  Logo
//  Created by Mobile on 21/12/22.

import UIKit

class ImageTableCell: UITableViewCell {

    @IBOutlet weak var base_vw: UIView!
    @IBOutlet weak var imageHolderViewHyt: NSLayoutConstraint!
    @IBOutlet weak var uploadImageBtn: UIButton!
    @IBOutlet weak var questionTitle: UILabel!
    @IBOutlet weak var uploadImageBtnHyt: NSLayoutConstraint!
    
    @IBOutlet weak var crossIcon: UIImageView!
    @IBOutlet weak var imageHolderImageView: UIImageView!
    @IBOutlet weak var imageHolderView: UIView!
    
    @IBOutlet weak var image_CollectionVW: UICollectionView!
    var imagesArray: [UIImage] = []
    var selectedIndex = Int()
    var selectedindeximg = Int()
    override func awakeFromNib() {
        super.awakeFromNib()
      
        image_CollectionVW.register(UINib(nibName: "ImagesViewCell", bundle: nil), forCellWithReuseIdentifier: "ImagesViewCell")
        image_CollectionVW.delegate = self
        image_CollectionVW.dataSource = self
        updateBackgroundColor()
        
    }
 
    override func prepareForReuse() {
        super.prepareForReuse()
        imageHolderImageView?.image = nil
        imageHolderView.isHidden = true
        imageHolderViewHyt.constant = 0
        imagesArray = []
          image_CollectionVW.reloadData()
    }
  
    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
                if traitCollection.userInterfaceStyle == .dark {
                    base_vw.backgroundColor = ThemeColor.darkThemeCellBGColor
                }else{
                    
                }
            }
        }
    
    func configureCell(withImage image: UIImage , selectedIndexdata: IndexPath ) {
       
     //imageHolderImageView.image = image
//        imagesArray.append(image)
        let index = min(max(selectedIndexdata.row, 0), imagesArray.count)
           imagesArray.insert(image, at: index)
           image_CollectionVW.reloadData()
        print("selectedIndex+++++++++++++++++++++++++" , selectedIndex)
       print ("selectedIndexdata----------------------->>>>>", selectedIndexdata )
        selectedindeximg = selectedIndexdata.row
        print("selectedindeximg===============:", selectedindeximg)
        print("Updated imagesArray:", imagesArray)
        
      print("uigsuigsfduidfh", SectionDataHandler.shared.selectedIndexForImage)
       print("KKKKKK", SectionDataHandler.shared.indexpathRowForImage)
        
        
        
               // print("Selected index:", indexPath)
    }
  
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
       
    }

    
    
    func setupImageCell(_ cell : ImageTableCell, _ indexPath: IndexPath) {
        cell.imageHolderImageView.image = imagesArray[indexPath.row]
         
         
      

          cell.crossIcon.actionBlock {
              let indexPathOfCell = indexPath
              self.imagesArray.remove(at: indexPath.row)
                  self.image_CollectionVW.reloadData()
              print("Delete button tapped in cell at indexPath: \(indexPathOfCell)")
          }
    }
    
    
    
}
extension  ImageTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imagesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImagesViewCell", for: indexPath) as! ImagesViewCell
      
      //cell.imageHolderImageView.image = imagesArray[indexPath.row]
       
        if indexPath.row < imagesArray.count {
               cell.imageHolderImageView.image = imagesArray[indexPath.row]
           }
    

        cell.crossIcon.actionBlock {
            let indexPathOfCell = indexPath
            self.imagesArray.remove(at: indexPath.row)
                self.image_CollectionVW.reloadData()
            print("Delete button tapped in cell at indexPath: \(indexPathOfCell)")
        }
        return cell
        
    }
  
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width/2) - 2, height: (collectionView.frame.width/2) - 6)
    }
    
    


}
