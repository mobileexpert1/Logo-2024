//
//  DemoPdf_VC.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 17/03/22.
//

import UIKit
import PDFKit
import Alamofire

class PDFform_VC: UIViewController, PDFDocumentDelegate, UIPopoverPresentationControllerDelegate {
    let pdfView = PDFView(frame: UIScreen.main.bounds)
    var pdfData = NSData()
    var pdfimg = UIImage()
    let pdfArr = [ReportData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(pdfView)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setNavigationBar(vc: self, middleTitle: "PDF", rightBtnTitle: "Share",leftAction:  #selector(leftBtnAction(sender:)), rightAction:  #selector(rightButtonAction(sender:)))
        setPdfView()
    }
    
    func setPdfView() {
        let doc = PDFDocument(data: pdfData as Data)
        pdfView.backgroundColor = UIColor.lightGray
        doc?.delegate = self
        pdfView.document = doc
        pdfView.autoScales = true
        doc?.delegate = self
    }
    
    @objc func leftBtnAction(sender: UIButton) {
        self.navigationController?.popViewController(animated: false)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func rightButtonAction(sender: UIBarButtonItem) {
        openActionSheet(sender: sender)
    }
    
    func openActionSheet(sender:UIBarButtonItem) {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let firstAction: UIAlertAction = UIAlertAction(title: "Upload", style: .default) { action -> Void in
            self.UploadPdf()
            print("Upload")
        }
        let secondAction: UIAlertAction = UIAlertAction(title: "Share", style: .default) { action -> Void in
            print("Share")
            self.sharePdf()
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        // add actions
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(cancelAction)
        
        if let presenter = actionSheetController.popoverPresentationController {
            presenter.sourceView = self.view
            presenter.delegate = self
            presenter.permittedArrowDirections = .up
            presenter.sourceRect = CGRect(x: self.view.frame.maxX, y: 0, width: 100, height: 100)
        }
        
        present(actionSheetController, animated: true) {
            print("option menu presented")
        }
    }
    
    func UploadPdf() {
        let getdata = self.pdfView.document?.dataRepresentation()
                print(getdata as Any)
        UploadPdf(PdfData: getdata!, id: SingleTon.shared.reqesedtUserId ?? "")
    }
    
    func sharePdf() {
        let getdata = self.pdfView.document?.dataRepresentation()
                print(getdata as Any)
        ActivityVC.share.showShareActivity(msg: nil, image: nil, url: nil, file: getdata as NSData?, sourceRect: nil)
        ClearDataClass.removeAllValues()
    }
    
    func UploadPdf(PdfData:Data,id: String) {
        
        DispatchQueue.main.async {
            Indicator.sharedInstance.showIndicator()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let fileparameters = ["requestReport": PdfData] as [String : Any]
            
            var requestPeram = [String:String]()
            var apiUrl:String?
            
            if SingleTon.shared.isMakeMenualReport == true{
                
                apiUrl = ApiUrl.MenualAddReport
                
                let menulReport = SingleTon.shared.menualReportDetail
                if let userId = menulReport?.userId,let userName = menulReport?.name,let contact = menulReport?.contact,let email = menulReport?.email,let address1 = menulReport?.addressLine1,let address2 = menulReport?.addressLine2,let city = menulReport?.city,let state = menulReport?.state,let postal = menulReport?.postalCode{
                    
                
                    
                    let reqPerameters =  [ "requestId": userId,"name":userName,"number":contact,"email":email,"city":city,"state":state,"streetNumber":"street","postalCode":postal,"addressLine1":address1,"addressLine2":address2, "sessionToken": SingleTon.shared.userToken]
                    
                    let oldreqPerameters =  [ "requestId": userId,"name":userName,"number":contact,"email":email,"location":address1, "sessionToken": SingleTon.shared.userToken]
                    requestPeram = reqPerameters
                    
                    
                }
              
            }
            else{
                apiUrl = ApiUrl.SendReportUrl
                let reqPerameters =  [ "requestId": id, "sessionToken": SingleTon.shared.userToken]
                requestPeram = reqPerameters
                }
           // let headers: HTTPHeaders = ["sessionToken": SingleTon.shared.userToken]
            
            ApiFunc.shared.uploadApi(url: apiUrl!, fileparams: fileparameters, reqstIdPeram: requestPeram, pdfData: PdfData, fileTitle: "demo") {  sucess in
                print(sucess.isSuccess)
                if sucess.isSuccess == true {
    //                self.showOnlyAlert("Finish", message: sucess.message)
                    self.setAlert("Uploaded", message: sucess.message)
                }
              else {
                    self.showOnlyAlert("Error", message: sucess.message)
                }
            }
        }
    }
    
    func setAlert(_ title: String , message : String) {
        var orignal_Dictioneries = [generalDic,pipeDic,fdcDic,headsDic,wetpipeDic,drypipeDic,tanksDic,foamDic,standpipeDic,pumpDic,FlowTestDic,whilePumpIsRunningDic,checkListDic,transferSwitchDic,extinguishersDic,fireHydrantDic]

        let alert = UIAlertController(title: "", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { action -> Void in
            ClearDataClass.removeAllValues()
            self.PopToViewControllert(vc: Home_VC.self)
            
            
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
//    func PopToViewControllert(vc: AnyObject){
//        for controller in self.navigationController!.viewControllers as Array {
//            if controller.isKind(of: vc as! AnyClass) {
//                       self.navigationController!.popToViewController(controller, animated: true)
//                       break
//                   }
//               }
//
//    }
}
   
    

    
    
    

   
