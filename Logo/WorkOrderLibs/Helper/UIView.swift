//  UIView.swift

import UIKit

extension UIView {
    
    var isAnimating: Bool {
        return layer.animationKeys()!.count > 0
    }
    
    var isVisible: Bool {
        get {
            return !isHidden
        }
        set {
            isHidden = !newValue
        }
    }
    
    var height: CGFloat {
        get {
            return bounds.size.height
        }
        set {
            frame.size.height = newValue
        }
    }
    
    //MARK:- GradientView
    func gradientView(_ firstColor:UIColor,_ secondColor:UIColor,_ width:CGFloat,_ height:CGFloat) -> UIView {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [firstColor.cgColor, secondColor.cgColor]
        gradient.locations = nil
        view.layer.insertSublayer(gradient, at: 0)
        return view
    }
    
    @IBInspectable var borderWidth: Double {
        get {
            return Double(self.layer.borderWidth)
        }
        set {
            self.layer.borderWidth = CGFloat(newValue)
        }
    }
    @IBInspectable var borderColor: UIColor? {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable
    var rotation: Int {
        get {
            return 0
        } set {
            let radians = CGFloat(CGFloat(Double.pi) * CGFloat(newValue) / CGFloat(180.0))
            self.transform = CGAffineTransform(rotationAngle: radians)
        }
    }
 
    var width: CGFloat {
        get {
            return bounds.size.width
        }
        set {
            frame.size.width = newValue
        }
    }

    
    func setHidden(_ hidden: Bool, animated: Bool) {
        if !animated {
            isHidden = hidden
        }
        else {
            alpha = isHidden ? 0.0 : 1.0
            isHidden = false
            UIView.animate(withDuration: 0.5, animations: {() -> Void in
                self.alpha = hidden ? 0.0 : 1.0
            }, completion: {(_ finished: Bool) -> Void in
                self.isHidden = hidden
                self.alpha = 1.0
            })
        }
    }
    
    func setVisible(_ visible: Bool, animated: Bool) {
        setHidden(!visible, animated: animated)
    }
    
    func fadeIn(_ duration: TimeInterval = 0.5, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 1.0
     }, completion: completion)  }

     func fadeOut(_ duration: TimeInterval = 0.5, delay: TimeInterval = 1.0, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.3
     }, completion: completion)
    }
    
    var control: UIViewController {
        return next as! UIViewController
    }
    
    var contentCompressionResistancePriority: UILayoutPriority {
        get {
            let horizontal: UILayoutPriority = contentCompressionResistancePriority(for: .horizontal)
            let vertical: UILayoutPriority = contentCompressionResistancePriority(for: .vertical)
            return UILayoutPriority(rawValue: (horizontal.rawValue + vertical.rawValue) * 0.5)
        }
        set {
            setContentCompressionResistancePriority(newValue, for: .horizontal)
            setContentCompressionResistancePriority(newValue, for: .vertical)
        }
    }
    
    var contentHuggingPriority: UILayoutPriority {
        get {
            let horizontal: UILayoutPriority = contentHuggingPriority(for: .horizontal)
            let vertical: UILayoutPriority = contentHuggingPriority(for: .vertical)
            return UILayoutPriority(rawValue: (horizontal.rawValue + vertical.rawValue) * 0.5)
        }
        set {
            setContentHuggingPriority(newValue, for: .horizontal)
            setContentHuggingPriority(newValue, for: .vertical)
        }
    }
    
    func bringSubviewToFront(_ subview: UIView, withSuperviews number: Int) {
        var subview = subview
        for _ in 0...number {
            subview.superview?.bringSubviewToFront(subview)
            subview = subview.superview!
        }
    }
    
    func addConstraint(_ view1: UIView, view2: UIView, att1: NSLayoutConstraint.Attribute, att2: NSLayoutConstraint.Attribute, mul: CGFloat, const: CGFloat) -> NSLayoutConstraint {
        if view2.responds(to: #selector(setter: self.translatesAutoresizingMaskIntoConstraints)) {
            view2.translatesAutoresizingMaskIntoConstraints = false
        }
        let constraint = NSLayoutConstraint(item: view1, attribute: att1, relatedBy: .equal, toItem: view2, attribute: att2, multiplier: mul, constant: const)
        addConstraint(constraint)
        return constraint
    }
    
    func addConstraint(_ view: UIView, att1: NSLayoutConstraint.Attribute, att2: NSLayoutConstraint.Attribute, mul: CGFloat, const: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: att1, relatedBy: .equal, toItem: view, attribute: att2, multiplier: mul, constant: const)
        addConstraint(constraint)
        return constraint
    }
    
    func addConstraintSameCenterX(_ view1: UIView, view2: UIView) {
        _ = addConstraint(view1, view2: view2, att1: .centerX, att2: .centerX, mul: 1.0, const: 0.0)
    }
    
    func addConstraintSameCenterY(_ view1: UIView, view2: UIView) {
        _ = addConstraint(view1, view2: view2, att1: .centerY, att2: .centerY, mul: 1.0, const: 0.0)
    }
    
    func addConstraintSameHeight(_ view1: UIView, view2: UIView) {
        _ = addConstraint(view1, view2: view2, att1: .height, att2: .height, mul: 1.0, const: 0.0)
    }
    
    func addConstraintSameWidth(_ view1: UIView, view2: UIView) {
        _ = addConstraint(view1, view2: view2, att1: .width, att2: .width, mul: 1.0, const: 0.0)
    }
    
    func addConstraintSameCenterXY(_ view1: UIView, and view2: UIView) {
        _ = addConstraintSameCenterX(view1, view2: view2)
        _ = addConstraintSameCenterY(view1, view2: view2)
    }
    
    func addConstraintSameSize(_ view1: UIView, and view2: UIView) {
        _ = addConstraintSameWidth(view1, view2: view2)
        _ = addConstraintSameHeight(view1, view2: view2)
    }
    
    func addConstraintSameAttribute(_ attribute: NSLayoutConstraint.Attribute, subviews: [UIView]) {
        for i in 1..<subviews.count {
            addConstraint(NSLayoutConstraint(item: subviews[0], attribute: attribute, relatedBy: .equal, toItem: subviews[i], attribute: attribute, multiplier: 1.0, constant: 0.0))
        }
    }
    
    func addVisualConstraints(_ constraints: [String], subviews: [String: UIView]) {
        addVisualConstraints(constraints, metrics: nil, subviews: subviews)
    }
    
    func addVisualConstraints(_ constraints: [String], metrics: [String: Any]?, subviews: [String: UIView]) {
        // Disable autoresizing masks translation for all subviews
        for subview in subviews.values {
            if subview.responds(to: #selector(setter: self.translatesAutoresizingMaskIntoConstraints)) {
                subview.translatesAutoresizingMaskIntoConstraints = false
            }
        }
        // Apply all constraints
        for constraint in constraints {
            addConstraints(NSLayoutConstraint.constraints(withVisualFormat: constraint, options: [], metrics: metrics, views: subviews))
        }
    }
    
    func addConstraintToFillSuperview() {
        superview?.addVisualConstraints(["H:|[self]|", "V:|[self]|"], subviews: ["self": self])
    }
    
    func addConstraintForAspectRatio(_ aspectRatio: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: self, attribute: .height, multiplier: aspectRatio, constant: 0.0)
        addConstraint(constraint)
        return constraint
    }
    
    func addConstraintForWidth(_ width: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: width)
        addConstraint(constraint)
        return constraint
    }
    
    func addConstraintForHeight(_ height: CGFloat) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint(item: self, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 0.0, constant: height)
        addConstraint(constraint)
        return constraint
    }
    
    func addSubviews(_ subviews: [UIView]) {
        for view in subviews {
            addSubview(view)
        }
    }
    
    var viewToImage: UIImage {
        UIGraphicsBeginImageContext(self.frame.size)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImage(cgImage: (image?.cgImage)!)
    }
    
    func addShadow(_ x: CGFloat, _ y: CGFloat, _ blur: CGFloat) {
        layer.shadowOpacity = 0.3 // opacity, 10%
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = blur // blur
        layer.shadowOffset = CGSize(width: x, height: y) // Spread x, y
        layer.masksToBounds =  false
    }
    
    func addBottomLabel(_ color: UIColor) {
        let lbl1 = UILabel()
        lbl1.backgroundColor = color
        addSubview(lbl1)
        addVisualConstraints(["H:|[label]|", "V:[label(1)]|"], subviews: ["label": lbl1])
    }
    
    /**
     It will get all subViews of target view.
     
     ## Important Notes ##
     In desired class: You can call it like
     1. let buttons = self.view.allSubViewsOf(type: UIButton.self)
     2. let labels = self.view.allSubViewsOf(type: UILabel.self)
     3. let views = self.view.allSubViewsOf(type: UIView.self) <- For All Objects ->
     */
    func getAllSubViewsOf<T : UIView>(type : T.Type) -> [T]{
        var all = [T]()
        func getSubview(view: UIView) {
            if let aView = view as? T{
                all.append(aView)
            }
            guard view.subviews.count>0 else { return }
            view.subviews.forEach{ getSubview(view: $0) }
        }
        getSubview(view: self)
        return all
    }

}
