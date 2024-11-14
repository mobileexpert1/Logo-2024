//
//  DetailVC.swift
//  Logo
//
//  Created by Mobile on 04/04/24.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var txtFld_Name: UITextField!
    @IBOutlet weak var txtFld_Email: UITextField!
    @IBOutlet weak var txtFld_PhoneNo: UITextField!
    @IBOutlet weak var txtFld_State: UITextField!
    @IBOutlet weak var txtFld_City: UITextField!
    @IBOutlet weak var txtFld_PostalCode: UITextField!
    @IBOutlet weak var txtFld_AddressLine: UITextField!
    @IBOutlet weak var txtFld_BillTo: UITextField!
    @IBOutlet weak var txtFld_AssignDate: UITextField!
    @IBOutlet weak var txtFld_AssignTime: UITextField!
    @IBOutlet weak var txtFld_InspectorType: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBackgroundColor()
        txtFld_Name.layer.cornerRadius = 12
        txtFld_Email.layer.cornerRadius = 12
        txtFld_PhoneNo.layer.cornerRadius = 12
        txtFld_State.layer.cornerRadius = 12
        txtFld_City.layer.cornerRadius = 12
        txtFld_PostalCode.layer.cornerRadius = 12
        txtFld_AddressLine.layer.cornerRadius = 12
        txtFld_BillTo.layer.cornerRadius = 12
        txtFld_AssignDate.layer.cornerRadius = 12
        txtFld_AssignTime.layer.cornerRadius = 12
        txtFld_InspectorType.layer.cornerRadius = 12
        
        self.txtFld_Name.setLeftPaddingPoints(10)
        self.txtFld_Email.setLeftPaddingPoints(10)
        self.txtFld_PhoneNo.setLeftPaddingPoints(10)
        self.txtFld_State.setLeftPaddingPoints(10)
        self.txtFld_AssignTime.setLeftPaddingPoints(10)
      
        self.txtFld_City.setLeftPaddingPoints(10)
        self.txtFld_PostalCode.setLeftPaddingPoints(10)
        self.txtFld_AddressLine.setLeftPaddingPoints(10)
        self.txtFld_BillTo.setLeftPaddingPoints(10)
        self.txtFld_AssignDate.setLeftPaddingPoints(10)
        self.txtFld_InspectorType.setLeftPaddingPoints(10)
        txtFld_Name.attributedPlaceholder = NSAttributedString(string: "Time off type",attributes:[NSAttributedString.Key.foregroundColor: UIColor.black])
        
    }
    
   
         
    func updateBackgroundColor() {
        if #available(iOS 13.0, *) {
            if traitCollection.userInterfaceStyle == .dark {
            }else{
                txtFld_Name.attributedPlaceholder = NSAttributedString(string: "Time off type",attributes:[NSAttributedString.Key.foregroundColor: UIColor.black])
            }
        }
        
    }
    

}
