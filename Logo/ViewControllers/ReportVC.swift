//
//  ReportVC.swift
//  Logo
//
//  Created by Mobile on 12/04/23.
//

import UIKit
import WebKit

class ReportVC: UIViewController, WKUIDelegate, WKNavigationDelegate {

    @IBOutlet weak var webVw: UIView!
    
    
    var webView : WKWebView!
    let activityIndicator = UIActivityIndicatorView()
    let pdfUrl = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    
    func loadPdf(){
        activityIndicator.color = .red
        activityIndicator.style = .large
        activityIndicator.startAnimating()
        webView = WKWebView(frame: webVw.bounds, configuration: WKWebViewConfiguration())
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.webVw.addSubview(webView)
        self.webView.allowsBackForwardNavigationGestures = true
        
        let myURL = URL(string: ApiUrl.pdfBaseUrl+pdfUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        activityIndicator.stopAnimating()
    }

   
}
