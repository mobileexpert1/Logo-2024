//
//  MeetingsVC.swift
//  Logo
//
//  Created by MOBILE on 28/07/23.
//

import UIKit
import WebKit
import SwiftSignatureView

class MeetingsVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var webVw: UIView!
    @IBOutlet weak var backBtn: UIImageView!
    @IBOutlet weak var submitBtn: UIButton!
    
    @IBOutlet weak var headerLbl: UILabel!
    @IBOutlet weak var wholeSignatureVw: UIView!
    @IBOutlet weak var signatureView: SwiftSignatureView!
    
    var webView : WKWebView!
    var pdfUrl = ""
    var submitClick = false
    var myId = "0"
    var showSign = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !showSign{
            submitBtn.isHidden = true
        }
        
        wholeSignatureVw.isHidden = true
        webView = WKWebView(frame: webVw.bounds, configuration: WKWebViewConfiguration())
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.uiDelegate = self
        webView.navigationDelegate = self
        self.webVw.addSubview(webView)
        signatureView.backgroundColor = UIColor(red: 251/255, green: 251/255, blue: 251/255, alpha: 1)
        self.webView.allowsBackForwardNavigationGestures = true
        let myURL = URL(string: ApiUrl.pdfBaseUrl + pdfUrl)
        let myRequest = URLRequest(url: myURL!)
        
        webView.load(myRequest)
        print(ApiUrl.pdfBaseUrl + pdfUrl)
        // Do any additional setup after loading the view.
        signatureView.backgroundColor = .lightGray
        signatureView.tintColor = .yellow
        
        backBtn.actionBlock { [self] in
            if submitClick{
                submitClick = false
                webVw.alpha = 1
                wholeSignatureVw.isHidden = true
                signatureView.clear()
            }
            else{
                self.navigationController?.popViewController(animated: true)
            }
        }
        headerLbl.textColor = ThemeColor.lightThemeImageTintColor
        backBtn.tintColor = ThemeColor.lightThemeImageTintColor
        //updateBackgroundColor()
    }
    
    
    func updateBackgroundColor() {
            if #available(iOS 13.0, *) {
               
                if traitCollection.userInterfaceStyle == .dark {
              // Dark mode is enabled
                    headerLbl.textColor = ThemeColor.darkThemeTextColor
                    backBtn.tintColor = ThemeColor.darkThemeImageTintColor
                    self.view.backgroundColor = ThemeColor.darkThemeViewBGColor
                    submitBtn.backgroundColor = ThemeColor.lightThemeViewBGColor
                    submitBtn.setTitleColor(ThemeColor.lightThemeImageTintColor, for: .normal)
                    webView.backgroundColor = ThemeColor.darkThemeViewBGColor
                    webVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                    
                } else {

                    headerLbl.textColor = ThemeColor.lightThemeImageTintColor
                    backBtn.tintColor = ThemeColor.lightThemeImageTintColor
                    self.view.backgroundColor = ThemeColor.lightThemeViewBGColor
                    webView.backgroundColor = ThemeColor.lightThemeViewBGColor
                    webVw.backgroundColor = ThemeColor.darkThemeViewBGColor
                }
            } else {
                // Fallback for earlier versions
          //      UIView.appearance().backgroundColor = .white
            }

            // Refresh the view hierarchy to apply the new background color
            view.setNeedsDisplay()
        }
    
    
    @IBAction func submitPdfAction(_ sender: Any) {
        
        if submitClick{
            if let img = self.signatureView.getCroppedSignature() {
                let imgData = img.jpegData(compressionQuality: 0.4)
                let base64Data = (imgData?.base64EncodedString())!
                SignSubmitAPI(img: base64Data)
            }
            else{
                
            }
        }
        else{
            submitClick = true
            webVw.alpha = 0
            wholeSignatureVw.isHidden = false
        }
    }
    
    
    
    // MARK: - PUNCH_DAY_API
    func SignSubmitAPI(img : String){
        let params = ["sessionToken" : SingleTon.shared.userToken,"id" : myId,"image" :img] as [String : Any]
        ApiFunc.shared.APIHeaderMethod(url: ApiUrl.safetySignSubmitUrl, method: .post, parameters: params) { [self] (success : AddExpenseModel?) in
            AlertControl.shared.showAlert("", message: "Signature added successfully", buttons: ["OK"]) { i in
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    
}
