//  PdfViewerVC.swift
//  Logo
//  Created by Mobile on 28/12/22.

import UIKit
import WebKit
import PKHUD

class PdfViewerVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backBtn: UIImageView!
    
    var pdfLink = String()
    var comeFrom = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        backBtn.actionBlock { [self] in
            if comeFrom{
                self.executHome()
            }
            else{
                self.navigationController?.popViewController(animated: true)
            }
        }
        let link = URL(string:pdfLink)!
        let request = URLRequest(url: link)
        HUD.show(.progress, onView: self.view)
        webView.load(request)
        webView.uiDelegate = self
        webView.navigationDelegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
//    func executHome() {
//      //  let homeRootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DashboardVC")
//        let homeRootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CalanderHomeVC")
//        let navC = UINavigationController(rootViewController: homeRootVC)

//        UIApplication.shared.currentWindow?.rootViewController =  navC
//      UIApplication.shared.currentWindow?.makeKeyAndVisible()
//    }
//    
   
    func executHome() {
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "Dashboard_Nav")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    
    }
   


    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        HUD.hide()
    }

    private func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        HUD.hide()
    }
    
}
