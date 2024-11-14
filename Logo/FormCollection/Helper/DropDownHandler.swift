//  DropDown.swift

/* ---- TO USE THIS :
 
pod 'DropDown'
 
anyTextField.actionBlock {
    DropDownHandler.shared.showDropDownWithItems(self.anyTextField, ["item-1", "item-2"])
    DropDownHandler.shared.itemPickedBlock = { (index, item) in
        print("selected item is :::  ", item)
    }
}*/

import Foundation
import UIKit
import DropDown

class DropDownHandler: NSObject{
    
    //MARK:- Shared Instance
    static let shared = DropDownHandler()
    
    let buttonDropDown = DropDown()

    //MARK: Internal Properties
    var itemPickedBlock: ((Int, String) -> Void)?
    
    func showDropDownWithItems(_ sender: UIView, _ items: [String]) {
        // dropDown
        buttonDropDown.anchorView = sender
        buttonDropDown.dataSource = items
        buttonDropDown.cellConfiguration = { (index, item) in return "\(item)" }
        buttonDropDown.selectionAction = { (index: Int, item: String) in
            self.itemPickedBlock?(index, item)
        }
        buttonDropDown.backgroundColor = .lightGray
        buttonDropDown.textColor = .white
        buttonDropDown.animationduration = 0.5
        buttonDropDown.selectionBackgroundColor = .clear
        buttonDropDown.selectedTextColor = .white
        
        buttonDropDown.bottomOffset = CGPoint(x: 0, y:((buttonDropDown.anchorView?.plainView.bounds.height)! + 5))
        buttonDropDown.show()
    }
}

