//
//  PilotCollectionViewCell.swift
//  Logo
//
//  Created by Mobile on 20/08/24.
//

import UIKit

//custom delegate
protocol textFieldDataDelegates1: AnyObject {
    func textFieldDataForChartTwo(_ data:[String:Any])
}

class PilotCollectionViewCell: UICollectionViewCell {

    //MARK: - IBoutlets/Variables
    
    @IBOutlet weak var test0SuctionTxtFld: UITextField!
    @IBOutlet weak var test0DriverTxtFld: UITextField!
    @IBOutlet weak var test0DischargeTxtFld: UITextField!
    
    @IBOutlet weak var test0NozzleTxtFld: UITextField!
    
    @IBOutlet weak var test100NozzleTxtFld: UITextField!
    @IBOutlet weak var test100DischargeTxtFld: UITextField!
    @IBOutlet weak var test100DriverTxtFld: UITextField!
    @IBOutlet weak var test100SuctionTxtFld: UITextField!
    
    @IBOutlet weak var test150SuctionTxtFld: UITextField!
    @IBOutlet weak var test150DriverTxtFld: UITextField!
    @IBOutlet weak var test150DischargeTxtFld: UITextField!
    @IBOutlet weak var test150NozzleTxtFld: UITextField!
       
    var delegate: textFieldDataDelegates1?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTextFieldDelegate()
    }
    
    //MARK: - functions
    func setUpTextFieldDelegate() {
        test0DriverTxtFld.delegate = self
        test0SuctionTxtFld.delegate = self
        test0DischargeTxtFld.delegate = self
        test0NozzleTxtFld.delegate = self
        test100DriverTxtFld.delegate = self
        test100SuctionTxtFld.delegate = self
        test100DischargeTxtFld.delegate = self
        test100NozzleTxtFld.delegate = self
        test150DriverTxtFld.delegate = self
        test150SuctionTxtFld.delegate = self
        test150DischargeTxtFld.delegate = self
        test150NozzleTxtFld.delegate = self
    }
}

//MARK: - textFiled delegates
extension PilotCollectionViewCell: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let data: [String:Any] = [
            "test0DriverSpeed": test0DriverTxtFld.text ?? "",
            "test0Suction" : test0SuctionTxtFld.text ?? "",
            "test0Discharge" : test0DischargeTxtFld.text ?? "",
            "test0Nozle" : test0NozzleTxtFld.text ?? "",
            
            "test100DriverSpeed": test100DriverTxtFld.text ?? "",
            "test100Suction": test100SuctionTxtFld.text ?? "",
            "test100Discharge": test100DischargeTxtFld.text ?? "",
            "test100Nozle": test100NozzleTxtFld.text ?? "",
            
            "test150DriverSpeed": test150DriverTxtFld.text ?? "",
            "test150Suction": test150SuctionTxtFld.text ?? "",
            "test150Discharge": test150DischargeTxtFld.text ?? "",
            "test150Nozle": test150NozzleTxtFld.text ?? ""
        ]
        delegate?.textFieldDataForChartTwo(data)
    }
}
