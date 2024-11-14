//
//  ElectricMotorTableViewCell.swift
//  Logo
//
//  Created by Mobile on 14/08/24.
//

import UIKit

protocol textFieldDataVolatgeDelegates: AnyObject {
    func textFieldDataForChartOne(_ data:[String:Any])
}

class ElectricMotorTableViewCell: UITableViewCell {

    //MARK: - IBOutlets/Variables
    @IBOutlet weak var test0VoltageTxtFld: UITextField!
    @IBOutlet weak var test0AmpereTxtFld: UITextField!
    
    @IBOutlet weak var test100VoltageTxtFld: UITextField!
    
    @IBOutlet weak var test150AmpereTxtFld: UITextField!
    @IBOutlet weak var test150VoltageTxtFld: UITextField!
    @IBOutlet weak var test100AmpereTxtFld: UITextField!
    
    var delegates: textFieldDataVolatgeDelegates?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTextFieldDelegate()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK: - functions
    func setUpTextFieldDelegate(){
        test0VoltageTxtFld.delegate = self
        test0AmpereTxtFld.delegate = self
        test100VoltageTxtFld.delegate = self
        test100AmpereTxtFld.delegate = self
        test150VoltageTxtFld.delegate = self
        test150AmpereTxtFld.delegate = self
    }
    
    func textFieldDataToSend() {
        let data: [String:Any] = [
            "test0Voltage": test0VoltageTxtFld.text ?? "",
            "test0Ampere" : test0AmpereTxtFld.text ?? "",
            "test100Voltage" : test100VoltageTxtFld.text ?? "",
            "test100Ampere" : test100AmpereTxtFld.text ?? "",
            "test150Voltage": test150VoltageTxtFld.text ?? "",
            "test150Ampere": test150AmpereTxtFld.text ?? ""
        ]
        delegates?.textFieldDataForChartOne(data)
    }
}

//MARK: - textfield delgates
extension ElectricMotorTableViewCell: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        let data: [String:Any] = [
            "test0Voltage": test0VoltageTxtFld.text ?? "",
            "test0Ampere" : test0AmpereTxtFld.text ?? "",
            "test100Voltage" : test100VoltageTxtFld.text ?? "",
            "test100Ampere" : test100AmpereTxtFld.text ?? "",
            "test150Voltage": test150VoltageTxtFld.text ?? "",
            "test150Ampere": test150AmpereTxtFld.text ?? ""
        ]
        delegates?.textFieldDataForChartOne(data)
    }
 
}
