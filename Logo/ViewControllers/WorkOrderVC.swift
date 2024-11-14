//
//  WorkOrderVC.swift
//  Logo
//
//  Created by Mobile on 05/04/24.
//

import UIKit

class WorkOrderVC: UIViewController {
   
    
    @IBOutlet weak var tbl_EmgRequest: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tbl_EmgRequest.delegate = self
        tbl_EmgRequest.dataSource = self
        tbl_EmgRequest.separatorStyle = .none
        WorkOrderViewCell.registerTableCell(for: tbl_EmgRequest)
    }
    
    func applyStyling(to view: UIView) {
           
           view.layer.cornerRadius = 12
           //view.backgroundColor = UIColor.white
           view.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
           view.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)
           view.layer.shadowOpacity = 1.5
           view.layer.shadowRadius = 4
        
       }
    
}
extension WorkOrderVC : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
   
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tbl_EmgRequest.dequeueReusableCell(withIdentifier: "WorkOrderViewCell", for: indexPath) as! WorkOrderViewCell
        
      //  tblVw.showsVerticalScrollIndicator = false
        
        cell.selectionStyle = .none
       
        cell.lbl_Appointment.text = "ABC appointment"
            
            cell.lbl_Time.text = "9:30 AM - 10:30 AM"
              
          
      
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    
}
