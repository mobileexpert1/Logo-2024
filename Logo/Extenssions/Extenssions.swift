//
//  Extenssions.swift
//  Logo
//
//  Created by Nihal kamboj on 04/03/22.
//

import UIKit
import SDWebImage

class PaddingLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)//CGRect.inset(by:)
        super.drawText(in: rect.inset(by: insets))
    }
}
class PdfPaddingLabel: UILabel {
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 2, left: 5, bottom: 2, right: 0)//CGRect.inset(by:)
        super.drawText(in: rect.inset(by: insets))
    }
}


class LessPaddingLabel: UILabel {
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 2)//CGRect.inset(by:)
        super.drawText(in: rect.inset(by: insets))
    }
}

extension UIControl {
    func touchUpInsideBlock(_ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        addTarget(sleeve, action: #selector(ClosureSleeve.invoke), for: .touchUpInside)
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
}

class ClosureSleeve {
    let closure: ()->()
    
    init (_ closure: @escaping ()->()) {
        self.closure = closure
    }
    
    @objc func invoke () {
        closure()
    }
}

extension UIView {
    func actionBlock(_ closure: @escaping ()->()) {
        let sleeve = ClosureSleeve(closure)
        
        let recognizer = UITapGestureRecognizer(target: sleeve, action: #selector(ClosureSleeve.invoke))
        addGestureRecognizer(recognizer)
        isUserInteractionEnabled = true
        
        objc_setAssociatedObject(self, String(format: "[%d]", arc4random()), sleeve, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
    }
    
    //-- SINGLE CORNER RADIUS SET
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    //-- CIRCLE ANY VIEW
    func circleView(view:UIView){
        view.layer.cornerRadius = (view.frame.size.height)/2
        view.clipsToBounds = true
    }
}
//--TEXTFIELD SHADOW COLOR SET
extension UIView {
    func addShadow(textField: UIView) {
        //Basic texfield Setup
        //        textField.borderStyle = .none
        textField.backgroundColor = UIColor(white: 100, alpha: 1)
        //To apply corner radius
        textField.layer.cornerRadius = 15
        //To apply border
        //        textField.layer.borderWidth = 0.25
        textField.layer.borderColor = UIColor.white.cgColor
        //To apply Shadow
        textField.layer.shadowOpacity = 1
        textField.layer.shadowRadius = 1.5
        textField.layer.shadowOffset = CGSize(width: 0.0, height: 0.50)// Use any CGSize
        textField.layer.shadowColor = UIColor(named: "Shadow_Color")?.cgColor
        //To apply padding
        //        let paddingView : UIView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: textField.frame.height))
        //        textField.leftView = paddingView
        //        textField.leftViewMode = UITextField.ViewMode.always
    }
    
    
}

//-- TABELVIEW CELL REGISTERATION
extension UITableViewCell {
    
    static func registerTableCell(for tableView: UITableView)  {
        let cellName = String(describing: self)
        let cellIdentifier = cellName
        let cellNib = UINib(nibName: String(describing: self), bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: cellIdentifier)
    }
    
}
//-- COLLECTION CELL REGISTER
extension UICollectionViewCell {
    static func registerCollectionCell(for collectnView: UICollectionView)  {
        let cellName = String(describing: self)
        let cellIdentifier = cellName
        let cellNib = UINib(nibName: String(describing: self), bundle: nil)
        collectnView.register(cellNib, forCellWithReuseIdentifier: cellIdentifier)
    }
}
//--########################################################

//--NAVIGATIONBAR EXTENSSIONS

extension UIViewController{
    
    //--SET NAVIGATION BAR
    func setNavigationBar(vc: UIViewController ,backBtnImg: UIImage = UIImage(named: "left-arrow")!,rightimg: UIImage = UIImage(),middleTitle: String,backBtbTitle: String = "",rightBtnTitle: String = "",leftAction: Selector? = #selector(backButtonAction(sender:)), rightAction: Selector?) {
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.hidesBackButton = true
        navigationItem.title = middleTitle
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let iphoneFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 21)]
        let ipadFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 44)]
        
        //assign button to navigationbar
        
        //-- RIGHT BUTTON
        let rightBtn: UIButton = UIButton()
        rightBtn.setTitle(rightBtnTitle, for: .normal)
        rightBtn.titleLabel?.text = "neckt"
        //        rightBtn.titleColor(for: .normal) = UIColor(named: "Main_Color")
        rightBtn.setTitleColor(UIColor(named: "Main_Color"), for: .normal)
        //        rightBtn.titleLabel?.text = rightBtnTitle
        rightBtn.titleLabel?.font =  UIFont(name: "Lato-Regular", size: 20)
        
        //        rightBtn.font = UIFont(name: "Lato-Regular", size: 14) ?? .systemFont(ofSize: 14)
        //        rightBtn.imageView?.contentMode = .scaleAspectFit
        rightBtn.contentVerticalAlignment = .fill
        rightBtn.contentHorizontalAlignment = .fill
        rightBtn.setImage(rightimg, for: .normal)
        
        let barButton = UIBarButtonItem(customView: rightBtn)
        //-- Back BUTTON
        let leftBtn = UIButton()
        
        leftBtn.imageView?.contentMode = .scaleAspectFit
        leftBtn.contentVerticalAlignment = .fill
        leftBtn.contentHorizontalAlignment = .fill
        leftBtn.setImage( backBtnImg, for: .normal)
       
        let leftBarButton = UIBarButtonItem(customView: leftBtn)
        
        //--BUTTON ACTIONS
        leftBtn.addTarget(vc, action: leftAction!, for: .touchUpInside)
        rightBtn.addTarget(vc, action: rightAction!, for: .touchUpInside)
        // MENAGES FOR PHONE AND IPAD
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            self.navigationController?.navigationBar.titleTextAttributes = ipadFont
            leftBtn.frame = CGRect(x: 0, y: 0, width: 45, height: 35)
            rightBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        } else {
            self.navigationController?.navigationBar.titleTextAttributes = iphoneFont
            leftBtn.frame = CGRect(x: 0, y: 0, width: 30, height: 25)
            rightBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        }
        self.navigationItem.leftBarButtonItem = leftBarButton
        self.navigationItem.rightBarButtonItem = barButton
    }
    
    @objc func backButtonAction(sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    //-- Buttons CAPSULE
    func capsuleButton(_ Btn: UIButton) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            Btn.layer.cornerRadius = 50
        } else {
            Btn.layer.cornerRadius = 30
        }
        Btn.clipsToBounds = true
        Btn.backgroundColor = UIColor(named: "Main_Color")
    }
    
    func capsuleButtons(_ Btn: UIButton) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            Btn.layer.cornerRadius = 45
        } else {
            Btn.layer.cornerRadius = 25
        }
        Btn.clipsToBounds = true
        Btn.backgroundColor =  UIColor(red: 20/255, green: 57/255, blue: 124/255, alpha: 1.0)
    }
    
    func capsuleonrouteButtons(_ Btn: UIButton) {
        if UIDevice.current.userInterfaceIdiom == .pad {
            Btn.layer.cornerRadius = 45
        } else {
            Btn.layer.cornerRadius = 25
        }
        Btn.clipsToBounds = true
        Btn.backgroundColor =  UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
    }
    
    
    func pushWithData<T>(_ controllerId:String, _ data:T) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: controllerId)
        vc!.dataFromLastVC = data
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    struct DataHolder {
        static var data:Any!
    }
    
    var dataFromLastVC:Any {
        get {
            return DataHolder.data
        } set(newValue) {
            DataHolder.data = newValue
        }
    }
    
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
//--String Extenssions
extension String {
    func widthofstring(usingfont font: UIFont)->CGFloat {
        let fontattributes = [NSAttributedString.Key.font:font]
        let size = self.size(withAttributes: fontattributes)
        return size.width
    }
    
    func isValidEmail()->Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return  NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
}
extension UIView {//--To Menage Keyboard
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func showKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.becomeFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func addtoolBAr(textVw: UITextView,textField: UITextField) {
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: self , action: #selector(doneButtonPressed1))
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        toolBar.sizeToFit()
        textVw.inputAccessoryView = toolBar
        textField.inputAccessoryView = toolBar
    }
    
    @objc func cancelPressed() {
        self.hideKeyboard()
    }
    
    @objc func doneButtonPressed1() {
        self.hideKeyboard()
    }
}

extension UIViewController {
    func showOnlyAlert(_ title: String,message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func PopToViewControllert(vc: AnyObject) {
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: vc as! AnyClass) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
    }
}

class ActivityVC: UIViewController {
    static let  share  = ActivityVC()
    
    func topViewController()-> UIViewController {
        var topViewController:UIViewController = UIApplication.shared.currentWindow!.rootViewController!
        
        while ((topViewController.presentedViewController) != nil) {
            topViewController = topViewController.presentedViewController!
        }
        
        return topViewController
    }
    
    func showShareActivity(msg:String?, image:UIImage?, url:String?,file: NSData?, sourceRect:CGRect?) {
        var objectsToShare = [AnyObject]()
        
        if let url = url {
            objectsToShare = [url as AnyObject]
        }
        if let image = image {
            objectsToShare = [image as AnyObject]
        }
        if let msg = msg {
            objectsToShare = [msg as AnyObject]
        }
        if let file = file {
            objectsToShare = [file as AnyObject]
        }
        let activityVC = UIActivityViewController(activityItems: objectsToShare, applicationActivities: nil)
        activityVC.modalPresentationStyle = .popover
        activityVC.popoverPresentationController?.sourceView = topViewController().view
        if let sourceRect = sourceRect {
            activityVC.popoverPresentationController?.sourceRect = sourceRect
        }
        topViewController().present(activityVC, animated: true, completion: nil)
    }
}
//=== TO GET KEYWINDOW
extension UIApplication {
    var currentWindow: UIWindow? {
        connectedScenes.filter({$0.activationState == .foregroundActive}).map({$0 as? UIWindowScene}).compactMap({$0}).first?.windows.filter({$0.isKeyWindow}).first
    }
}
//-- Measure Height 
extension String {
    func heightWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.height
    }
}

//MARK: - ImageView Properties
extension UIImageView {
    
    //SDWebImage Loader
    func setNetworkImage(_ imageContainer: UIImageView, _ imageStrUrl: String){
        imageContainer.sd_imageIndicator = SDWebImageActivityIndicator.gray
        imageContainer.sd_imageIndicator?.startAnimatingIndicator()
        imageContainer.sd_setImage(with: URL(string: imageStrUrl), placeholderImage: nil)
    }
}

@IBDesignable
class UISwitchCustom: UISwitch {
    @IBInspectable var OffTint: UIColor? {
        didSet {
            self.tintColor = OffTint
            self.layer.cornerRadius = 16
            self.backgroundColor = OffTint
        }
    }
}
