//  UIViewController.swift

import UIKit

let textViewForAlert = UITextView(frame: CGRect.zero)

extension UIViewController {
    
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    func isPresentedModally() -> Bool {
        return self.presentingViewController?.presentedViewController == self
    }
    
    func pushControl(_ viewController: UIViewController, animated: Bool = true) {
        navigationController?.pushViewController(viewController, animated: animated)
    }
    
    func showNavigationBar(_ show: Bool, animated: Bool = false) {
        navigationController?.setNavigationBarHidden(!show, animated: animated)
    }
    
    func findContentViewControllerRecursively() -> UIViewController {
        var childViewController: UIViewController?
        if (self is UITabBarController) {
            childViewController = (self as? UITabBarController)?.selectedViewController
        }
        else if (self is UINavigationController) {
            childViewController = (self as? UINavigationController)?.topViewController
        }
        else if (self is UISplitViewController) {
            childViewController = (self as? UISplitViewController)?.viewControllers.last
        }
        else if (self.presentedViewController != nil) {
            childViewController = self.presentedViewController
        }
        let shouldContinueSearch: Bool = (childViewController != nil) && !((childViewController?.isKind(of: UIAlertController.self))!)
        return shouldContinueSearch ? childViewController!.findContentViewControllerRecursively() : self
    }
    
    func customAddChildViewController(_ child: UIViewController) {
        self.customAddChildViewController(child, toSubview: self.view)
    }
    
    func customAddChildViewController(_ child: UIViewController, toSubview subview: UIView) {
        self.addChild(child)
        subview.addSubview(child.view)
        child.view.addConstraintToFillSuperview()
        child.didMove(toParent: self)
    }
    
    func customRemoveFromParentViewController() {
        self.willMove(toParent: nil)
        self.view.removeFromSuperview()
        self.removeFromParent()
    }
    
    func customRemoveAllChildViewControllers() {
        for control: UIViewController in self.children {
            control.customRemoveFromParentViewController()
        }
    }

    func popOrDismissViewController(_ animated: Bool) {
        if self.isPresentedModally() {
            self.dismiss(animated: animated, completion:nil)
        } else if (self.navigationController != nil) {
            _ = self.navigationController?.popViewController(animated: animated)
        }
    }
    
    func pushOnly(_ controllerId: String, _ animation: Bool) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: controllerId)
        self.navigationController?.pushViewController(vc!, animated: animation)
    }
    
    func presentOnly(_ controllerId: String) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: controllerId)
        vc?.modalPresentationStyle = .currentContext
        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    func popOnly() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func popToAnotherVC(_ controller: UIViewController) {
        self.navigationController?.popToViewController(controller, animated: true)
    }
    
    func getVC(_ id:String) -> UIViewController {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        return storyBoard.instantiateViewController(withIdentifier: id)
    }
    
    func sendFeedback(_ sender: Any) {
                
        let alertController = UIAlertController(title: "Feedback \n\n\n\n\n", message: nil, preferredStyle: .alert)

        let cancelAction = UIAlertAction.init(title: "Cancel", style: .default) { (action) in
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(cancelAction)

        let saveAction = UIAlertAction(title: "Submit", style: .default) { (action) in
            _ = textViewForAlert.text
            alertController.view.removeObserver(self, forKeyPath: "bounds")
        }
        alertController.addAction(saveAction)

        alertController.view.addObserver(self, forKeyPath: "bounds", options: NSKeyValueObservingOptions.new, context: nil)
        textViewForAlert.backgroundColor = UIColor.white
        textViewForAlert.textContainerInset = UIEdgeInsets.init(top: 8, left: 5, bottom: 8, right: 5)
        alertController.view.addSubview(textViewForAlert)

        self.present(alertController, animated: true, completion: nil)
    }
    
    override open func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "bounds"{
            if let rect = (change?[NSKeyValueChangeKey.newKey] as? NSValue)?.cgRectValue {
                let margin: CGFloat = 8
                let xPos = rect.origin.x + margin
                let yPos = rect.origin.y + 54
                let width = rect.width - 2 * margin
                let height: CGFloat = 90

                textViewForAlert.frame = CGRect.init(x: xPos, y: yPos, width: width, height: height)
            }
        }
    }
}

extension UINavigationController {
  func popToViewController(ofClass: AnyClass, animated: Bool = true) {
    if let vc = viewControllers.last(where: { $0.isKind(of: ofClass) }) {
      popToViewController(vc, animated: animated)
    }
  }
}


@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
}
