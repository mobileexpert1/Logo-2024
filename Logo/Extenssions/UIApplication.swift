//  UIApplication.swift

import UIKit

extension UIApplication {
    
    class var appWindow: UIWindow! {
        return (UIApplication.shared.delegate?.window!)!
    }
    
    class var rootViewController: UIViewController! {
        return self.appWindow.rootViewController!
    }
    
    class var visibleViewController: UIViewController! {
        return self.rootViewController.findContentViewControllerRecursively()
    }
    
    class var visibleNavigationController: UINavigationController! {
        return self.visibleViewController.navigationController!
    }
    
    class var visibleTabBarController: UITabBarController! {
        return self.visibleViewController.tabBarController!
    }
    
    class var visibleSplitViewController: UISplitViewController! {
        return self.visibleViewController.splitViewController!
    }
    
    class func pushOrPresent(_ viewController: UIViewController, animated: Bool) {
        if self.visibleNavigationController != nil {
            self.visibleNavigationController.pushViewController(viewController, animated: animated)
        } else {
            self.visibleViewController.present(viewController, animated: animated, completion: nil)
        }
    }
    
    class var appWindowFrame: CGRect {
        return self.appWindow.frame
    }
    
    class var navigationBarFrame: CGRect {
        return self.visibleNavigationController.navigationBar.frame
    }
    
    class var navigationBarHeight: CGFloat {
        return self.navigationBarFrame.size.height
    }
    
    class var statusBarHeight: CGFloat {
        return self.shared.statusBarFrame.size.height
    }
    
    class var tabBarFrame: CGRect {
        return self.visibleTabBarController.tabBar.frame
    }
    
    class var tabBarHeight: CGFloat {
        return self.tabBarFrame.size.height
    }
    
    class var interfaceOrientation: UIInterfaceOrientation {
        return self.shared.statusBarOrientation
    }
    
    class var interfaceOrientationIsLandscape: Bool {
        return self.interfaceOrientation == .landscapeLeft || self.interfaceOrientation == .landscapeRight
    }
    
    class var interfaceOrientationIsPortrait: Bool {
        return self.interfaceOrientation == .portrait
    }
    
    class var interfaceOrientationIsPortraitOrUpsideDown: Bool {
        return self.interfaceOrientation == .portrait || self.interfaceOrientation == .portraitUpsideDown
    }
}


import UIKit

enum Theme {
    case light
    case dark
}

class ThemeManager {
    static var currentTheme: Theme = .light
    
    static func applyTheme(_ theme: Theme) {
        currentTheme = theme
        
        // Set the appropriate appearance based on the selected theme
        switch theme {
        case .light:
            LocalStore.shared.isDarkMode = false
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .light
            }
        case .dark:
            LocalStore.shared.isDarkMode = true
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = .dark
            }
        }
    }
}

class LocalStore : NSObject {
    
    static let shared = LocalStore()
    
    var isDarkMode : Bool {
        get { return UserDefaults.standard.bool(forKey: "isDarkModeKey") }
        set { return UserDefaults.standard.set(newValue, forKey: "isDarkModeKey") }
    }
}

