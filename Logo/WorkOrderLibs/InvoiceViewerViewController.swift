//  InvoiceViewerViewController.swift
//  FireDepartment
//  Created by Akshay on 27/01/22.

import UIKit
import WebKit
import MessageUI
import PKHUD
import Alamofire

class InvoiceViewerViewController: UIViewController, MFMailComposeViewControllerDelegate, UINavigationControllerDelegate, MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        print("Mail Sent")
    }
    
    
    var pdfData = Data()
    @IBOutlet weak var invoiceViewer: WKWebView!
    @IBOutlet weak var shareIcon: UIImageView!
    let mailComposer = MFMailComposeViewController()
    var jobId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(JobNameInstance.shared.jobName)
        mailComposer.mailComposeDelegate = self
        mailComposer.delegate = self
        var pdfURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        pdfURL = pdfURL.appendingPathComponent("invoice.pdf") as URL
        
        let data = try! Data(contentsOf: pdfURL)
        pdfData = data
        self.invoiceViewer.load(data, mimeType: "application/pdf", characterEncodingName:"", baseURL: pdfURL.deletingLastPathComponent())
        
        shareIcon.actionBlock {
            self.sendEmail(data: self.pdfData)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showNavigationBar(true)
        self.sendEmailOnly(data: pdfData)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar(false)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            print("1212121212")
            self.uploadPdf()
            if !self.jobId.isEmpty{
                print("Job Id \(self.jobId)")
                self.DeleteEmergencyRequestsAPI()
            }
            else{
                print("Job Id Nil")
            }
        }
    }
    
    
    
    func sendEmail(data:Data?){
        let alert = UIAlertController(title: "Select an Option", message: "", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Share with mail", style: .default , handler:{ (UIAlertAction)in
            if( MFMailComposeViewController.canSendMail() ) {
                self.mailComposer.setToRecipients(["info@24-7fireprotection.com"])
                self.mailComposer.setSubject("Workorder Invoice")
                self.mailComposer.setMessageBody("My Workorder Invoice pdf attached below.", isHTML: true)
                if let fileData = data {
                    self.mailComposer.addAttachmentData(fileData, mimeType: "application/pdf", fileName: "invoice.pdf")
                }
                self.present(self.mailComposer, animated: true, completion: nil)
                return
            }
            print("Email is not configured")
            
            HUD.flash(.label("Mail is not configured in this device, please try other sharing options"), onView: self.view, delay: 3, completion: nil)
            //HUD.flash(.labeledError(title: "", subtitle: "Mail is not configured in this device, please try other sharing options"), delay: 2.0)
        }))
        
        alert.addAction(UIAlertAction(title: "Other sharing options", style: .default , handler:{ (UIAlertAction)in
            var pdfURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
            pdfURL = pdfURL.appendingPathComponent("invoice.pdf") as URL
            self.sharePdf(path: pdfURL)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler:{ (UIAlertAction)in
            print("User click Dismiss button")
        }))
        //uncomment for iPad Support
        alert.popoverPresentationController?.sourceView = self.shareIcon
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
    
    
    func sendEmailOnly(data:Data?){
        if( MFMailComposeViewController.canSendMail() ) {
            mailComposer.setToRecipients(["info@24-7fireprotection.com"])
            mailComposer.setSubject("Workorder Invoice")
            mailComposer.setMessageBody("My Workorder Invoice pdf attached below.", isHTML: true)
            
            if let fileData = data {
                mailComposer.addAttachmentData(fileData, mimeType: "application/pdf", fileName: "invoice.pdf")
            }
            
            
            self.present(mailComposer, animated: true, completion: nil)
            return
        }
        print("Email is not configured")
        HUD.flash(.label("Mail is not configured in this device, please try other sharing options"), onView: self.view, delay: 3, completion: nil)
    }
    
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Swift.Error?) {
        switch result {
        case .cancelled:
            print("Mail cancelled")
        case .saved:
            print("Mail saved")
        case .sent:
            print("Mail sent")
        case .failed:
            break
        @unknown default:
            print("UnKnown")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    //    // MFMailComposeViewControllerDelegate method
    //    private func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
    //        controller.dismiss(animated: true, completion: nil)
    //        print("sent!")
    //    }
    
    
    func sharePdf(path:URL) {
        
        let fileManager = FileManager.default
        
        if fileManager.fileExists(atPath: path.path) {
            let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: [path], applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.shareIcon
            self.present(activityViewController, animated: true, completion: nil)
        } else {
            print("document was not found")
            let alertController = UIAlertController(title: "Error", message: "Document was not found!", preferredStyle: .alert)
            let defaultAction = UIAlertAction.init(title: "ok", style: UIAlertAction.Style.default, handler: nil)
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
}

extension InvoiceViewerViewController {
    
    func uploadPdf() {
        uploadPdfToServer(workOrderName: JobNameInstance.shared.jobName, pdfFile: pdfData, url: "https://247.poseidons.io/api/inspector/workOrder") { (message, success) in
            print(success)
            print(message)
            /*if success == true {
             HUD.flash(.label(message), delay: 1.5)
             DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
             self.popOnly()
             }
             }*/
        }
        
        
        
        
    }
    
    
    //MARK: -- Multipart Form Data Signature Api
    func uploadPdfToServer(workOrderName: String, pdfFile: Data, url: String, finish: @escaping ((message: String, isSuccess: Bool)) -> Void) {
        var result:(message:String, isSuccess:Bool) = (message: "Fail", isSuccess : false)
        let params : [String: Any] = [
            "pdf" : pdfFile,
            "workOrderName" : workOrderName
        ]
        if Connectivity.isConnectedToInternet {
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in params {
                    if value is Data {
                        if let pdfData = self.pdfData as? Data {
                            multipartFormData.append(pdfData, withName: key, fileName: "invoice.pdf", mimeType: "application/pdf")
                        }
                    } else if value is String || value is Int {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
            }, to: url, usingThreshold: UInt64.init(), method: .post, headers: nil).response{ response in
                if response.response?.statusCode == 200 {
                    do {
                        if let jsonData = response.data {
                            let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                            print(parsedData)
                            
                            let status = parsedData["status"] as? Bool ?? false
                            let msg = parsedData["message"] as? String ?? ""
                            
                            if(status == true) {
                                result.isSuccess = true
                                result.message = msg
                            } else {
                                result.isSuccess = false
                                result.message = msg
                                HUD.flash(.labeledError(title: "", subtitle: msg), delay: 1.0)
                            }
                        }
                        finish(result)
                    } catch {
                        finish(result)
                    }
                } else if response.response?.statusCode == 400 {
                    do {
                        if let jsonData = response.data {
                            let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                            
                            let status = parsedData["status"] as? Bool ?? false
                            let msg = parsedData["message"] as? String ?? ""
                            
                            if(status == true) {
                                result.isSuccess = true
                                result.message = msg
                            } else {
                                result.isSuccess = false
                                result.message = msg
                                HUD.flash(.labeledError(title: "", subtitle: msg), delay: 1.0)
                            }
                        }
                        finish(result)
                    } catch {
                        finish(result)
                    }
                } else {
                    HUD.flash(.labeledError(title: "", subtitle: "Something went wrong"), delay: 1.0)
                }
            }
        } else{
            HUD.flash(.labeledError(title: "", subtitle: "Internet connection not working"), delay: 1.0)
        }
    }
}

class Connectivity {
    class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
}


extension InvoiceViewerViewController{
    // MARK: - DELETE_EMERGENCY_REQUESTS_API
    func DeleteEmergencyRequestsAPI(){
        ApiFunc.shared.APIHeaderMethod1(url: ApiUrl.deleteEmergencyRequestsUrl, method: .get, parameters: ["sessionToken" : SingleTon.shared.userToken, "serviceId" : jobId], completion: { [self] (success : DeleteEmergencyRequestModel?) in
            print("Request Deleted")
        })
    }
}
