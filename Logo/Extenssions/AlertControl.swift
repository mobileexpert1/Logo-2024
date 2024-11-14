//
//  AlertControl.swift
//  MITSUBISHI
//
//  Created by Mobile on 15/03/22.
//

import UIKit

class AlertControl: NSObject {
    
    //MARK:- Shared Instance
    static let shared = AlertControl()
    private override init() { }
    
    
    //MARK:- Alert Methods
    func showAlert(_ title: String, message: String, buttons: [String], alertStyle: UIAlertController.Style = .alert, view: UIView = UIView(), completion: ((Int) -> Void)?) {
        let alertView: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for i in 0..<buttons.count {
            alertView.addAction(UIAlertAction(title: buttons[i], style: .default, handler: {(_ action: UIAlertAction) -> Void in
                if completion != nil {
                    completion!(i)
                }
            }))
        }
        if let popoverController = alertView.popoverPresentationController {
            popoverController.sourceView = view
            popoverController.sourceRect = view.frame
            popoverController.permittedArrowDirections = []
        }
        UIApplication.shared.keyWindow?.rootViewController!.present(alertView, animated: true, completion: nil)
    }
  
    
    func showOnlyAlert(_ title: String, message: String) {
        let alertController = UIAlertController(title:title,message:message,preferredStyle:.alert)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController,animated:true,completion:{Timer.scheduledTimer(withTimeInterval: 1.5, repeats:false, block: {_ in
            UIApplication.shared.keyWindow?.rootViewController?.dismiss(animated: true, completion: nil)
        })})
    }
    
}
