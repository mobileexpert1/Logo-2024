//
//  AddPilotCollectionViewCell.swift
//  Logo
//
//  Created by Mobile on 20/08/24.
//

import UIKit

class AddPilotCollectionViewCell: UICollectionViewCell {

    //MARK: - IBoutlets/Variables
    @IBOutlet weak var topLabel: UILabel!
   
    @IBOutlet weak var test0Flow6TxtFld: UITextField!
    @IBOutlet weak var test0Flow5TxtFld: UITextField!
    @IBOutlet weak var test0Flow4TxtFld: UITextField!
    @IBOutlet weak var test0Flow3TxtFld: UITextField!
    @IBOutlet weak var test0Flow2TxtFld: UITextField!
    @IBOutlet weak var test0Flow1TxtFld: UITextField!
    
    @IBOutlet weak var test100Flow6TxtFld: UITextField!
    @IBOutlet weak var test100Flow5TxtFld: UITextField!
    @IBOutlet weak var test100Flow1TxtFld: UITextField!
    @IBOutlet weak var test100Flow3TxtFld: UITextField!
    
    @IBOutlet weak var test100Flow4TxtFld: UITextField!
    @IBOutlet weak var test100Flow2TxtFld: UITextField!
    
    @IBOutlet weak var test150Flow6TxtFld: UITextField!
    
    @IBOutlet weak var test150Flow5TxtFld: UITextField!
    @IBOutlet weak var tes150Flow4TxtFld: UITextField!
    @IBOutlet weak var test150Flow3TxtFld: UITextField!
    @IBOutlet weak var test150Flow2TxtFld: UITextField!
    @IBOutlet weak var test150Flow1TxtFld: UITextField!
       
    var delegate: textFieldDataDelegates1?
   
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpTxtFldDelegates()
        txtFldsToDisable()
    }
    
    //MARK: - Functions
    func setUpTxtFldDelegates() {
        test0Flow6TxtFld.delegate = self
        test0Flow5TxtFld.delegate = self
        test0Flow4TxtFld.delegate = self
        test0Flow3TxtFld.delegate = self
        test0Flow2TxtFld.delegate = self
        test0Flow1TxtFld.delegate = self
        test100Flow6TxtFld.delegate = self
        test100Flow5TxtFld.delegate = self
        test100Flow1TxtFld.delegate = self
        test100Flow3TxtFld.delegate = self
        test100Flow4TxtFld.delegate = self
        test100Flow2TxtFld.delegate = self
        test150Flow6TxtFld.delegate = self
        test150Flow5TxtFld.delegate = self
        tes150Flow4TxtFld.delegate = self
        test150Flow3TxtFld.delegate = self
        test150Flow2TxtFld.delegate = self
        test150Flow1TxtFld.delegate = self
    }
    
    func txtFldsToDisable() {
        test0Flow6TxtFld.isUserInteractionEnabled = false
        test0Flow5TxtFld.isUserInteractionEnabled = false
        test0Flow4TxtFld.isUserInteractionEnabled = false
        test0Flow3TxtFld.isUserInteractionEnabled = false
        test0Flow2TxtFld.isUserInteractionEnabled = false
        test0Flow1TxtFld.isUserInteractionEnabled = false
    }

}

//MARK: - textFiled delegates
extension AddPilotCollectionViewCell: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        
        let data: [String:Any] = [
            "test0Flow1": test0Flow1TxtFld.text ?? "",
            "test0Flow2" : test0Flow2TxtFld.text ?? "",
            "test0Flow3" : test0Flow3TxtFld.text ?? "",
            "test0Flow4" : test0Flow4TxtFld.text ?? "",
            "test0Flow5": test0Flow5TxtFld.text ?? "",
            "test0Flow6": test0Flow6TxtFld.text ?? "",
           
            "test100Flow1": test100Flow1TxtFld.text ?? "",
            "test100Flow2": test100Flow2TxtFld.text ?? "",
            "test100Flow3": test100Flow3TxtFld.text ?? "",
            "test100Flow4": test100Flow4TxtFld.text ?? "",
            "test100Flow5": test100Flow5TxtFld.text ?? "",
            "test100Flow6": test100Flow6TxtFld.text ?? "",
            
            "test150Flow1": test150Flow1TxtFld.text ?? "",
            "test150Flow2": test150Flow2TxtFld.text ?? "",
            "test150Flow3": test150Flow3TxtFld.text ?? "",
            "test150Flow4": tes150Flow4TxtFld.text ?? "",
            "test150Flow5": test150Flow5TxtFld.text ?? "",
            "test150Flow6": test150Flow6TxtFld.text ?? "",
        ]
        delegate?.textFieldDataForChartTwo(data)
        
    }
    
}
