//  AddServiceView.swift
//  FireDepartment
//  Created by Akshay on 22/02/22.

import UIKit

class AddServiceView: UIView {
   
    @IBOutlet weak var viewHeight: NSLayoutConstraint! // height : 350
    @IBOutlet weak var addServiceTextField: UITextField!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var descriptionViewHeight: NSLayoutConstraint! // height : 105
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var addServiceBtn: UIView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var descriptionLblHeight: NSLayoutConstraint! // height 25
    @IBOutlet weak var descriptionTextViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var serviceTextLabel: UILabel!
    @IBOutlet weak var fireSprinklerTextLabel: UILabel!
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var addTextLabel: UILabel!
    
}
