//
//  ShadowExtension.swift
//  Lesleys Home
//
//  Created by MAC SOLUTIONSS on 07/12/21.
//

//import Foundation
import UIKit
extension UIView{

    func updatePopUpViewConstraints(Of View: UIView, to view: UIView) {
            View.translatesAutoresizingMaskIntoConstraints = false
            View.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 0).isActive = true
            View.rightAnchor.constraint(equalTo: view.rightAnchor,constant: 0).isActive = true
            View.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: 0).isActive = true
            View.heightAnchor.constraint(equalTo: view.heightAnchor,multiplier: 1.0, constant: 0).isActive = true
            View.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
        }

}
