//
//  PilotReadingColTableViewCell.swift
//  Logo
//
//  Created by Mobile on 20/08/24.
//

import UIKit

class PilotReadingColTableViewCell: UITableViewCell, textFieldDataDelegates1{
    
    func textFieldDataForChartTwo(_ data: [String : Any]) {
        SectionDataHandler.shared.chartTwoFinalData.merge(with: data)
//        print("dataDict load condition",data)
//        print(SectionDataHandler.shared.chartTwoFinalData)
    }
 

    //MARK: - IBOulets/Variables
    @IBOutlet weak var baseView: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(UINib(nibName: "PilotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PilotCollectionViewCell")
        collectionView.register(UINib(nibName: "AddPilotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AddPilotCollectionViewCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
   
}

//MARK: - CollectionView Delegates/DataSources
extension PilotReadingColTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
   
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PilotCollectionViewCell", for: indexPath) as! PilotCollectionViewCell
            cell.delegate = self
            return cell
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddPilotCollectionViewCell", for: indexPath) as! AddPilotCollectionViewCell
            cell.delegate = self
            return cell
        }
     
    }
     
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
