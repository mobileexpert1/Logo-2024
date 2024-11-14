//
//  MenuVC.swift
//  Logo
//
//  Created by Mobile on 04/05/23.
//

import UIKit

protocol menuBtnActionDelegate : AnyObject {
    func ActionCall(Action:Int)
}

class MenuVC: UIViewController {
    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNmLbl: UILabel!
    
    @IBOutlet weak var holidaysVw: UIView!
    @IBOutlet weak var expensesVw: UIView!
    @IBOutlet weak var logOutVw: UIView!
    
    weak var menuDelegate : menuBtnActionDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        holidaysVw.actionBlock {
            print("Holidays")
            self.menuDelegate?.ActionCall(Action: 1)
        }
        
        expensesVw.actionBlock {
            print("Expenses")
            self.menuDelegate?.ActionCall(Action: 2)
        }
        
        logOutVw.actionBlock {
            print("Logout")
            self.menuDelegate?.ActionCall(Action: 3)
        }
        
    }
    
    
    
    
}
