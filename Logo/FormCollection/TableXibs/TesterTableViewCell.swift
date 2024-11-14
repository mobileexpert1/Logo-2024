//
//  TesterTableViewCell.swift
//  Logo
//
//  Created by Mobile on 14/08/24.
//

import UIKit

class TesterTableViewCell: UITableViewCell {

    @IBOutlet weak var testerCollectionView:UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        testerCollectionView.delegate = self
        testerCollectionView.dataSource = self
//
//        testerCollectionView.register(UINib(nibName: "LoadConditionsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LoadConditionsCollectionViewCell")
        testerCollectionView.register(UINib(nibName: "GraphsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "GraphsCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: - collectionView delegates,dataSources
extension TesterTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 2
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        if indexPath.section == 0 {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LoadConditionsCollectionViewCell", for: indexPath)
//            return cell
//        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GraphsCollectionViewCell", for: indexPath)
            return cell
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = testerCollectionView.layer.frame.width
        return CGSize(width: width, height: 200)
    }
    
}
