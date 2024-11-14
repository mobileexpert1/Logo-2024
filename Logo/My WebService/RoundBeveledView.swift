//
//  RoundBeveledView.swift
//  Logo
//
//  Created by Vishal on 16/05/24.
//

import Foundation
import Foundation
import UIKit
class RoundBeveledView: UIView {
    
    public var gradColors: [UIColor] = [
        .init(red: 0.95, green: 0.95, blue: 1.0, alpha: 1.0),
        .init(red: 0.80, green: 0.80, blue: 0.90, alpha: 1.0),
    ]

    private let outerBevel = CAGradientLayer()
    private let innerBevel = CAGradientLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func commonInit() {
        
        outerBevel.colors = [
            gradColors[0].cgColor,
            gradColors[1].cgColor,
        ]
        innerBevel.colors = [
            gradColors[1].cgColor,
            gradColors[0].cgColor,
        ]
        
        outerBevel.startPoint = .init(x: 0.20, y: 0.0)
        outerBevel.endPoint = .init(x: 0.80, y: 1.0)
        innerBevel.startPoint = .init(x: 0.20, y: 0.0)
        innerBevel.endPoint = .init(x: 0.80, y: 1.0)
        
        layer.addSublayer(outerBevel)
        layer.addSublayer(innerBevel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        outerBevel.frame = bounds
        let obMask = CAShapeLayer()
        obMask.path = CGPath.init(ellipseIn: outerBevel.bounds.insetBy(dx: 8.0, dy: 8.0), transform: nil)
        outerBevel.mask = obMask
        
        innerBevel.frame = outerBevel.frame.insetBy(dx: 12.0, dy: 12.0)
        let ibMask = CAShapeLayer()
        ibMask.path = CGPath.init(ellipseIn: innerBevel.bounds.insetBy(dx: 12.0, dy: 12.0), transform: nil)
        innerBevel.mask = ibMask
    }
    
}
