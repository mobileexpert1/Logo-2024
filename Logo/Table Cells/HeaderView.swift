//
//  HeaderView.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 23/03/22.
//

import UIKit

class MyCustomHeader: UITableViewHeaderFooterView {
    let toplbl = UILabel()
    let subjLbl = UILabel()
    let vertilineLbl = UILabel()
    let horiLbl = UILabel()
    let adressLabel = UILabel()
    let ClientInfoLbl = UILabel()
    let vertiLbl2 = UILabel()
    let clientNameLbl = UILabel()
    let clientname = UILabel()
    let inspactionDetailLbl = UILabel()
    let vertiLbl3 = UILabel()
    let dateHeadingLbl = UILabel()
    let dateLabel = UILabel()
    let inspectConduLabel = UILabel()
    let vertiLbl4 = UILabel()
    let logoimg = UIImageView()
    let horiLbl1 = UILabel()
    let companyAddressLbl = UILabel()
    let companyMiddleAddressLbl = UILabel()
    let companyBottonmAddressLbl = UILabel()
    let vertiLbl5 = UILabel()
    let inspectByLabel = UILabel()
    let inspectNameLabel = UILabel()
    let inspectSignlabel = UILabel()
    let inspectSignlabeltext = UILabel()
    
    
    let baseView = UIView()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configureContents()
        setvlabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureContents() {
         
        baseView.translatesAutoresizingMaskIntoConstraints = false

        
          contentView.addSubview(baseView)

          // Center the image vertically and place it near the leading
          // edge of the view. Constrain its width and height to 50 points.
          NSLayoutConstraint.activate([
              
                 
            baseView.trailingAnchor.constraint(equalTo:
                     contentView.layoutMarginsGuide.trailingAnchor),
            baseView.leadingAnchor.constraint(equalTo:
                     contentView.layoutMarginsGuide.leadingAnchor),
            baseView.topAnchor.constraint(equalTo:
                     contentView.layoutMarginsGuide.topAnchor),
              
            baseView.bottomAnchor.constraint(equalTo:
                     contentView.layoutMarginsGuide.bottomAnchor)
          ])
     
  }
    func setvlabels(){
    
   
    toplbl.frame = CGRect(x: 10, y: 0, width: contentView.frame.width, height: 26)
    toplbl.text = "Fire Sprinkler Inspection Report"
    toplbl.font = .boldSystemFont(ofSize: 22)
    //-----
    
    subjLbl.frame = CGRect(x: 10, y: 50, width:  baseView.frame.width, height: 25)
    subjLbl.text = "Subject Property"
    subjLbl.font = .boldSystemFont(ofSize: 18)
    //-----
    
    vertilineLbl.frame = CGRect(x: 10, y: 75, width: baseView.frame.width - 20, height: 1.2)
    vertilineLbl.backgroundColor = UIColor(named: "Shadow_Color")
    //-----
    
    horiLbl.frame = CGRect(x: baseView.frame.width / 2 - 30, y: 77, width: 1.5, height: 80)
    horiLbl.backgroundColor = UIColor(named: "Shadow_Color")
    //-----
    
  adressLabel.frame = CGRect(x: baseView.frame.width / 2 - 25 , y: 77, width: 150, height: 80)
    adressLabel.numberOfLines = 0
    adressLabel.font = .systemFont(ofSize: 14)
    adressLabel.text = "256 Reock St City of Orange 07050  United States"
    
    //-----
    
    ClientInfoLbl.frame = CGRect(x: 10, y: 150, width: baseView.frame.width / 2, height: 25)
    ClientInfoLbl.text = "Client Information"
    ClientInfoLbl.font = .boldSystemFont(ofSize: 18)
    //-----
    
          vertiLbl2.frame = CGRect(x: 10, y: 180, width: contentView.frame.width - 20, height: 1.2)
          vertiLbl2.backgroundColor = UIColor(named: "Shadow_Color")
    //-----
   
    clientNameLbl.frame = CGRect(x: 30, y: 185, width:  120, height: 25)
    clientNameLbl.text = "Client name:"
    clientNameLbl.font = .boldSystemFont(ofSize: 18)
        //-----
   
    clientname.frame = CGRect(x: 140, y: 185, width:  80, height: 25)
    clientname.text =  "SIRJ NJ LLC"
    clientname.font = .systemFont(ofSize: 14)
        //-----
   
    inspactionDetailLbl.frame = CGRect(x: 10, y: 220, width:  contentView.frame.width / 2, height: 25)
    inspactionDetailLbl.text =  "Inspection Details"
    inspactionDetailLbl.font = .boldSystemFont(ofSize: 18)
        //-----
    
          vertiLbl3.frame = CGRect(x: 10, y: 250, width: contentView.frame.width - 20, height: 1.2)
          vertiLbl3.backgroundColor = UIColor(named: "Shadow_Color")
        //-----
   
    dateHeadingLbl.frame = CGRect(x: 30, y: 255, width:  100, height: 25)
    dateHeadingLbl.text = "Date/Time: "
    dateHeadingLbl.font = .boldSystemFont(ofSize: 18)
        //-----
    
    dateLabel.frame = CGRect(x: 125, y: 255, width:  150, height: 25)
    dateLabel.text =  "06/Aug/2022"
    dateLabel.font = .systemFont(ofSize: 14)
        //-----
    
    inspectConduLabel.frame = CGRect(x: 10, y: 285, width: contentView.frame.width , height: 25)
    inspectConduLabel.text =  "Inspection Conducted By"
    inspectConduLabel.font = .boldSystemFont(ofSize: 18)
        //-----
  
          vertiLbl4.frame = CGRect(x: 10, y: 310, width: contentView.frame.width - 20, height: 1.2)
          vertiLbl4.backgroundColor = UIColor(named: "Shadow_Color")
        //-----
   
    logoimg.frame = CGRect(x: 10, y: 350, width: (contentView.frame.width / 2) - 20, height: 180)
    logoimg.image = UIImage(named: "car")
    logoimg.contentMode = .scaleToFill
        //-----
   
    horiLbl1.frame = CGRect(x: contentView.frame.width / 2, y: 320, width: 1.5, height: 260)
    horiLbl1.backgroundColor = UIColor(named: "Shadow_Color")
        //-----
    
    companyAddressLbl.frame = CGRect(x: (contentView.frame.width / 2) + 10, y: 320, width: 180 , height: 60)
    companyAddressLbl.numberOfLines = 0
    companyAddressLbl.font = .boldSystemFont(ofSize: 18)
    companyAddressLbl.text = "24/7 Fire Protection Inc."
        //-----
    
    companyMiddleAddressLbl.frame = CGRect(x: (contentView.frame.width / 2) + 10, y: 380, width: 180 , height: 80)
    companyMiddleAddressLbl.numberOfLines = 0
    companyMiddleAddressLbl.font = .systemFont(ofSize: 14)
    companyMiddleAddressLbl.text = "32 Heckel St Belleville NJ 07109 Inspected by:\(SingleTon.shared.inspectorName)"
        //-----
   
    companyBottonmAddressLbl.frame = CGRect(x: (contentView.frame.width / 2) + 10, y: 460, width: 180 , height: 120)
    companyBottonmAddressLbl.numberOfLines = 0
    companyBottonmAddressLbl.font = .systemFont(ofSize: 14)
    companyBottonmAddressLbl.text = "Phone: 973-525-9163 Fax: 877-643-8252 247fire.inspection@gmail.com www.24-7fireprotection.com"
        //-----
    
          vertiLbl5.frame = CGRect(x: 10, y: 585, width: contentView.frame.width - 20, height: 1.2)
          vertiLbl5.backgroundColor = UIColor(named: "Shadow_Color")
        //-----
    
    inspectByLabel.frame = CGRect(x: 10, y: 590, width: 180 , height: 25)
    inspectByLabel.text = "Inspected by:"
    inspectByLabel.font = .boldSystemFont(ofSize: 18)
        //-----
    
    inspectNameLabel.frame = CGRect(x: 190, y: 590, width: 180 , height: 25)
        inspectNameLabel.text = SingleTon.shared.inspectorName
    inspectNameLabel.font = .systemFont(ofSize: 18)
        //-----
    
    inspectSignlabel.frame = CGRect(x: 10, y: 620, width: 180 , height: 25)
    inspectSignlabel.text = "Inspector's Signature:"
    inspectSignlabel.font = .boldSystemFont(ofSize: 18)
        //-----
    
    inspectSignlabeltext.frame = CGRect(x: 40, y: 645, width:contentView.frame.width  , height: 80)
    inspectSignlabel.numberOfLines = 0
    inspectSignlabeltext.text = "[signature not uploaded] P01281"
    inspectSignlabeltext.font = .systemFont(ofSize: 14)
        //-----
//      146 Ralph Street Belleville NJ 07109 Inspected by:ELIS ROSADO Phone: 973-525-9163 Fax: 877-643-8252 247fire.inspection@gmail.com www.24-7fireprotection.com"
    
    
        baseView.addSubview(toplbl)
        baseView.addSubview(subjLbl)
        baseView.addSubview(vertilineLbl)
        baseView.addSubview(horiLbl)
        baseView.addSubview(ClientInfoLbl)
        contentView.addSubview(vertiLbl2)
        contentView.addSubview(clientNameLbl)
        contentView.addSubview(clientname)
        contentView.addSubview(inspactionDetailLbl)
        contentView.addSubview(vertiLbl3)
        contentView.addSubview(dateHeadingLbl)
        contentView.addSubview(dateLabel)
        contentView.addSubview(inspectConduLabel)
        contentView.addSubview(vertiLbl4)
        contentView.addSubview(logoimg)
        contentView.addSubview(horiLbl1)
        contentView.addSubview(companyAddressLbl)
        contentView.addSubview(companyMiddleAddressLbl)
        contentView.addSubview(companyBottonmAddressLbl)
        contentView.addSubview(vertiLbl5)
        contentView.addSubview(inspectByLabel)
        contentView.addSubview(inspectNameLabel)
        contentView.addSubview(inspectSignlabel)
        contentView.addSubview(inspectSignlabeltext)
    
        contentView.addSubview(adressLabel)

}
}
