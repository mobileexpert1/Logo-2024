//
//  InstallationVC.swift
//  Logo
//
//  Created by MOBILE on 31/07/23.
//

import UIKit
import WebKit


class InstallationVC: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    @IBOutlet weak var webVw: UIView!
    @IBOutlet weak var backBtn: UIImageView!
    

    
    var webView : WKWebView!
    var pdfId = "0"
    var pdfUrl : String = "https://247.poseidons.io/installation/admin/generateReport?tok=2"
    var val = true
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let source: String = "var meta = document.createElement('meta');" +
            "meta.name = 'viewport';" +
            "meta.content = 'width=device-width, initial-scale=0.35, maximum-scale=1.0, user-scalable=no';" +
            "var head = document.getElementsByTagName('head')[0];" +
            "head.appendChild(meta);"

        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        
        webView = WKWebView(frame: webVw.bounds, configuration: WKWebViewConfiguration())
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.scrollView.showsVerticalScrollIndicator = false
        
        let userContentController = WKUserContentController()
        userContentController.add(self, name: "callbackHandler") // "callbackHandler" is the name of the message handler in JavaScript
        webView.configuration.userContentController = userContentController
        webView.configuration.userContentController.addUserScript(script)
        
        self.webVw.addSubview(webView)
        self.webView.allowsBackForwardNavigationGestures = true
        let myURL = URL(string: pdfUrl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)

        // Do any additional setup after loading the view.
                
        backBtn.actionBlock {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    // MARK: - GET_SCHEDULE_API
    func GetInstallationPdfAPI(){
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.getInstallationPdfUrl, method: .get, parameters: ["tok" : pdfId]) { [self] (success : GetInstallationPDFModel?) in
            let requestData = success!.data
            let link = requestData.link
            let myURL = URL(string: link)
            let myRequest = URLRequest(url: myURL!)
           // webView.load(myRequest)
        }
    }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        if message.name == "toastCallback", let messageBody = message.body as? String {
                    // Handle the toast callback data here
                    print("Toast callback received: \(messageBody)")
                }
       }
    
    // WKNavigationDelegate method to handle URL changes
      func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
          // Check if the navigation action is a link click
          if navigationAction.navigationType == .linkActivated {
              if let newURL = navigationAction.request.url {
                  // Handle the internal URL change here
                  // For example, check if it's a specific internal URL and pop the navigation controller
                  if newURL.host == "example.com" && newURL.path == "/specific-path" {
                      // Pop the navigation controller
                      navigationController?.popViewController(animated: true)
                      decisionHandler(.cancel)
                      return
                  }
              }
          }
          let myUrl = URL(string: pdfUrl)
          if navigationAction.request.description != pdfUrl{
//        let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstallationVC") as! PdfViewerVC
//              VC.pdfLink = ""
              if val{
                  val = false
                  webView.scrollView.scrollsToTop = true
//                  let myURL = URL(string: pdfUrl)
//                  let myRequest = URLRequest(url: myURL!)
//                  webView.load(myRequest)
                  DispatchQueue.main.asyncAfter(deadline: .now()+3.0) {
                      self.GetInstallationPdfAPI()
                  }
              }
              
//              AlertControl.shared.showOnlyAlert("Report added successfully", message: "")
//              DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
//                  self.navigationController?.popViewController(animated: true)
//              }
     //         self.navigationController?.pushViewController(VC, animated: true)
          }

             
          decisionHandler(.allow)
      }

}
