//
//  myCustomView.swift
//  aa
//
//  Created by CS on 30/03/22.
//

import UIKit

class myCustomView: UIView {
   
     var contentView: UIView?

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            guard let view = loadViewFromNib() else{return}
            view.frame = self.bounds
            self.addSubview(view)
            contentView = view
        }
 
 
    func loadViewFromNib() -> UIView? {

        let bundle =  Bundle(for: type(of: self))
        let nib = UINib(nibName: "myCustomView", bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
        myLabei.text = "kjhhjgehjrhj"
        }

    @IBOutlet weak var myLabei: UILabel!
    
    @IBAction func BackBtn(_ sender: Any) {
        print("Back")
    }
}
