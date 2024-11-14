//
//  PaymentSucessPopup.swift
//  TruliPay
//
//  Created by Mobile on 19/04/22.
//

import UIKit

class InspectionTypePopup: UIView {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var typeSelectionTableView: UITableView!
    
    var selectedInsPectionType:InspectTypeEnum?
    
    private var cellReuseIdentifier = "cell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        typeSelectionTableView.delegate = self
        typeSelectionTableView.dataSource = self
        self.typeSelectionTableView.register(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
                
     }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setupView()

     }
    
    func setupView() {
        Bundle.main.loadNibNamed("InspectionTypePopup", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
          
       //        DispatchQueue.main.async {
//            self.btn_Verfiy.gradientView(AppColor.gradient1, AppColor.gradient2)
//        }

    }
}
extension InspectionTypePopup: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        InspectTypeEnum.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = (self.typeSelectionTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as UITableViewCell?)!
        cell.selectionStyle = .none
        let type = InspectTypeEnum.allCases[indexPath.row]
        cell.textLabel?.text = type.rawValue
        if type == SingleTon.shared.inspectReportType{
            cell.imageView?.image = UIImage(named: "radio-on-button")
        }else{
            cell.imageView?.image = UIImage(named: "radio-off-button")
        }
       
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = typeSelectionTableView.cellForRow(at: indexPath)! as UITableViewCell
        cell.imageView?.image = UIImage(named: "radio-on-button")
        print(indexPath.row)
        let type = InspectTypeEnum.allCases[indexPath.row]
        selectedInsPectionType = type
        SingleTon.shared.inspectReportType = type
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = typeSelectionTableView.cellForRow(at: indexPath)! as UITableViewCell
        cell.imageView?.image = UIImage(named: "radio-off-button")
    }
     
}



enum InspectTypeEnum:String,CaseIterable{
    case Quaterly = "Quarterly"
    case semiAnual = "Semi-Annual"
    case Annual = "Annual"
    
}
