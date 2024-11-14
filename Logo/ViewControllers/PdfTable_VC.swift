//
//  PdfTable_VC.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 17/03/22.
//

import UIKit
import SimplePDF
class PdfTable_VC: UIViewController {
    
    var orignal_Dictioneries = [generalDic,pipeDic,fdcDic,headsDic,wetpipeDic,drypipeDic,tanksDic,foamDic,standpipeDic,pumpDic,FlowTestDic,whilePumpIsRunningDic,checkListDic,transferSwitchDic,extinguishersDic,fireHydrantDic]
    
    let headerView = UIView()
    var questions = [String]()
    var textinput = [String]()
    var textBox = [String]()
    var yesBtnArr = [String]()
    var noBtnArr = [String]()
    var nilBtnArr = [String]()
    var imagesArr = [UIImage]()
    
    var collectnArr: [[String]] = []
    var localCollecArr:[String] = []
    var demoArr = [Int]()
    
    var clientSignature = UIImage()
    var inspectorSignature = UIImage()
    
    var requestSelectedIndex = 0
    var tblTextIndex = 0
    var a4PaperSize = CGSize()
    var txtIndex = 0
    
    @IBOutlet weak var pdfTableView: UITableView!
    @IBOutlet weak var pdfTable_height: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PdfTable_Cell.registerTableCell(for: pdfTableView)
        
        let dataDict = dataFromLastVC as! [String:UIImage]
        print(dataDict)
        
        clientSignature = dataDict["clientSign"]!
        inspectorSignature = dataDict["inspectorSign"]!
        //
        //        let requestModelTempDict = dataDict["modelDict"] as! [String:Any]
        //        print(requestModelTempDict)
        //
        //        requestModel = requestModelTempDict["model"] as? Request
        //
        //        print(requestModel)
        ////        requestSelectedIndex = SingleTon.shared.requestDict["index"] as! Int
        ////        requestModel = SingleTon.shared.requestDict["model"] as! Request
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        tblTextIndex = 0
        txtIndex = 0
        setNavigationBar(vc: self, middleTitle: "",rightBtnTitle: "Next", rightAction: #selector(mybuttonAction(sender: )))
        emptyArrays()
        self.pdfTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        appendDataFromDictnriesToArrays()
        DispatchQueue.main.async {
            self.pdfTableView.reloadData()
            Indicator.sharedInstance.hideIndicator()
        }
    }
    
    func pdfDataWithTableView(tableView: UITableView) -> String {
        let priorBounds = tableView.bounds
        let fittedSize = tableView.sizeThatFits(CGSize(width:priorBounds.size.width, height:tableView.contentSize.height))
        tableView.bounds = CGRect(x: 0, y: 0, width: fittedSize.width, height: fittedSize.height)
        //let pdfPageBounds = CGRect(x:0, y:0, width:tableView.frame.width, height:self.view.frame.height)
        let pdfPageBounds = CGRect(x:0, y:0, width:tableView.frame.width, height:830)
        let pdfData = NSMutableData()
        UIGraphicsBeginPDFContextToData(pdfData, pdfPageBounds,nil)
        var pageOriginY: CGFloat = 0
        while pageOriginY < fittedSize.height {
            UIGraphicsBeginPDFPageWithInfo(pdfPageBounds, nil)
            UIGraphicsGetCurrentContext()!.saveGState()
            UIGraphicsGetCurrentContext()!.translateBy(x: 0, y: -pageOriginY)
            tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
            UIGraphicsGetCurrentContext()!.restoreGState()
            pageOriginY += pdfPageBounds.size.height
        }
        UIGraphicsEndPDFContext()
        tableView.bounds = priorBounds
        var docURL = (FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)).last! as URL
        docURL = docURL.appendingPathComponent("myDocumentNewPdf1.pdf")
        pdfData.write(to: docURL as URL, atomically: true)
        return docURL.path
    }
    
    @objc func mybuttonAction(sender: UIButton) {
        print("Notification Btn Tapped")
        let pdf = SimplePDF(pageSize: CGSize(width: self.view.frame.width + 10, height: 842))
        pdf.addLineSpace(2)
        pdf.setContentAlignment(.right)
        pdf.addText("NFPA Certified",font: UIFont(name: "Lato-Regular", size: 12)!)
       
        pdf.addLineSpace(20)
        pdf.setContentAlignment(.left)
        pdf.addText("Fire Sprinkler Inspection Report",font: UIFont(name: "Lato-Regular", size: 22)!)
        pdf.addLineSpace(15)
        pdf.addText("Subject Property",font: UIFont(name: "Lato-Regular", size: 17)!)
        
        pdf.addLineSpace(5)
        pdf.addLineSeparator(height: 1.2)
        
        pdf.addLineSpace(30)
        //pdf.setContentAlignment(.right)
        pdf.addText("    " + SingleTon.shared.requestStreetNuber + " " + SingleTon.shared.requestAddressLine1.uppercased() + " " + SingleTon.shared.requestAddressLine2.uppercased() + " " + SingleTon.shared.requestCity.uppercased() + " " + SingleTon.shared.requestState.uppercased(), font: UIFont(name: "Lato-Bold", size: 14)!)
        pdf.addLineSpace(30)
        
        pdf.setContentAlignment(.left)
        pdf.addText("Client Information",font: UIFont(name: "Lato-Regular", size: 17)!)
        pdf.addLineSpace(5)
        pdf.addLineSeparator(height: 1.2)
        
        pdf.addLineSpace(10)
        pdf.addText("    Client name: " + SingleTon.shared.clientName, font: UIFont(name: "Lato-Regular", size: 18)!)
        
        pdf.addLineSpace(30)
        pdf.setContentAlignment(.left)
        pdf.addText("Inspection Details",font: UIFont(name: "Lato-Regular", size: 18)!)
        pdf.addLineSpace(5)
        pdf.addLineSeparator(height: 1.2)
        
        pdf.addLineSpace(10)
        pdf.addText("    Date: " + Date().toString(dateFormat: "dd/MMM/yyyy"), font: UIFont(name: "Lato-Regular", size: 18)!)
        
        pdf.addLineSpace(30)
        pdf.addText("Inspection Conducted By", font: UIFont(name: "Lato-Regular", size: 18)!)
        pdf.addLineSpace(5)
        pdf.addLineSeparator(height: 1.2)

        // -- Set image
        pdf.addLineSpace(10)
        
     //   pdf.beginHorizontalArrangement()
        // newEdit
        pdf.setContentAlignment(.left)
        pdf.addImage2(UIImage(named: "logo2")!, width: self.view.frame.width - 30, height: (self.view.frame.width - 140))
        
        /*
        pdf.addHorizontalSpace(10)
        pdf.setContentAlignment(.right)
        pdf.addText("24/7 Fire Protection Inc.", font: UIFont(name: "Lato-Regular", size: 18)!)
        pdf.endHorizontalArrangement()
        
        pdf.beginHorizontalArrangement()
        pdf.addLineSpace(30)
        pdf.setContentAlignment(.right)
        pdf.addText("146 Ralph Street Belleville",font: UIFont(name: "Lato-Regular", size: 14)!)
        pdf.endHorizontalArrangement()
        
        pdf.beginHorizontalArrangement()
        pdf.addLineSpace(2)
        pdf.setContentAlignment(.right)
        pdf.addText("NJ 07109 inspected by:  ",font: UIFont(name: "Lato-Regular", size: 14)!)
        pdf.endHorizontalArrangement()
        
        pdf.beginHorizontalArrangement()
        pdf.addLineSpace(1)
        pdf.addText("ELIS ROSADO", font: UIFont(name: "Lato-Regular", size: 14)!)
        pdf.endHorizontalArrangement()
        
        pdf.beginHorizontalArrangement()
        pdf.addLineSpace(30)
        pdf.addText("Phone: 973-525-9163 \n Fax: 877-643-8252",font: UIFont(name: "Lato-Regular", size: 14)!)
        pdf.endHorizontalArrangement()
        
        pdf.beginHorizontalArrangement()
        pdf.addLineSpace(2)
        pdf.addText("247fire.inspection@gmail.com",font: UIFont(name: "Lato-Regular", size: 14)!)
        pdf.endHorizontalArrangement()
        
        pdf.beginHorizontalArrangement()
        pdf.addLineSpace(2)
        pdf.addText("www.24-7fireprotection.com",font: UIFont(name: "Lato-Regular", size: 14)!)
        pdf.endHorizontalArrangement()
        
        pdf.addLineSpace(30)
        pdf.addLineSeparator(height: 1.2)
        pdf.addLineSpace(15)
        */
        
        pdf.beginNewPage()
        pdf.setContentAlignment(.left)
        pdf.addText("Inspector name: " + SingleTon.shared.inspectorName, font: UIFont(name: "Lato-Regular", size: 18)!)
        
        
//        pdf.addLineSpace(10)
//        pdf.addText("Inspector's Signature: ", font: UIFont(name: "Lato-Regular", size: 16)!)
        
        pdf.addLineSpace(10)
        //pdf.setContentAlignment(.center)
        pdf.addImage2(inspectorSignature, width: self.view.frame.width - 30, height: (self.view.frame.width - 180))
        
        pdf.addLineSpace(20)
        pdf.setContentAlignment(.left)
        pdf.addText("Inspection Agreement", font: UIFont(name: "Lato-Bold", size: 22)!)
        
        pdf.addLineSpace(10)
        pdf.addText("PARTIES OF THIS INSPECTION AGREEMENT ANNUAL INSPECTION", font: UIFont(name: "Lato-Bold", size: 18)!, textColor: UIColor(named: "pdHeadingTxtColr")!)
        
        pdf.addLineSpace(10)
        pdf.addText("BETWEEN:",font: UIFont(name: "Lato-Bold", size: 18)!)
        pdf.addLineSpace(5)
        pdf.addLineSeparator(height: 1.2)
        
        pdf.addLineSpace(5)
        pdf.addText(SingleTon.shared.clientName,font: UIFont(name: "Lato-Bold", size: 18)!)
        pdf.addLineSpace(40)
        
        pdf.addText(SingleTon.shared.requestStreetNuber + " " + SingleTon.shared.requestAddressLine1 + " " + SingleTon.shared.requestAddressLine2 + " " + SingleTon.shared.requestCity + " " + SingleTon.shared.requestState + " " + SingleTon.shared.postalCode, font: UIFont(name: "Lato-Regular", size: 14)!)
        
        pdf.addLineSpace(40)
        pdf.addLineSeparator(height: 1.2)
        pdf.addLineSpace(2)
        pdf.addText("TO:",font: UIFont(name: "Lato-Bold", size: 18)!)
        pdf.addLineSpace(2)
        pdf.addLineSeparator(height: 1.2)
        pdf.addText("24/7 Fire Protection Inc.",font: UIFont(name: "Lato-Bold", size: 18)!)
        pdf.addLineSpace(30)
        
        pdf.addText("32 Heckel St Belleville NJ 07109 \n Phone: 973-525-9163247(fire.inspection@gmail.com) \n www.24-7fireprotection.com", font: UIFont(name: "Lato-Regular", size: 14)!)
        
        pdf.addLineSpace(30)
        pdf.addText("SUBJECT PROPERTY", font: UIFont(name: "Lato-Bold", size: 18)!, textColor: UIColor(named: "pdHeadingTxtColr")!)
        pdf.addLineSpace(30)
        pdf.addText("    " + SingleTon.shared.requestStreetNuber + " " + SingleTon.shared.requestAddressLine1.uppercased() + " " + SingleTon.shared.requestAddressLine2.uppercased() + " " + SingleTon.shared.requestCity.uppercased() + " " + SingleTon.shared.requestState.uppercased(), font: UIFont(name: "Lato-Bold", size: 14)!)
        //pdf.setContentAlignment(.right)
        //pdf.addText(SingleTon.shared.requestStreetNuber + " " + SingleTon.shared.requestAddressLine1 + " " + SingleTon.shared.requestAddressLine2 + " " + SingleTon.shared.requestCity + " " + SingleTon.shared.requestState,font: UIFont.systemFont(ofSize: 15))
        
        pdf.addLineSpace(5)
        pdf.setContentAlignment(.left)
        pdf.beginNewPage()
        pdf.addText("THE PARTIES UNDERSTAND AND VOLUNTARILY AGREE AS FOLLOWS", font: UIFont(name: "Lato-Bold", size: 18)!, textColor: UIColor(named: "pdHeadingTxtColr")!)
        pdf.addLineSpace(30)
        
        // -- Conditions
        pdf.addText(conditionsScope, font: UIFont(name: "Lato-Regular", size: 12)!)
        pdf.addText(conditionsScope2, font: UIFont(name: "Lato-Regular", size: 12)!)
        pdf.addText(conditionsScope3, font: UIFont(name: "Lato-Regular", size: 12)!)
        
        // -- Privacy
        pdf.addLineSpace(30)
        pdf.addText("PRIVACY POLICY", font: UIFont(name: "Lato-Bold", size: 18)!, textColor: UIColor(named: "pdHeadingTxtColr")!)
        
        pdf.addLineSpace(20)
        pdf.addText(privacyCondins,font: UIFont(name: "Lato-Regular", size: 12)!)
        
        // -- Acknowledgements
        pdf.addLineSpace(30)
        pdf.addText("AKNOWLEDEGEMENTS",font: UIFont(name: "Lato-Bold", size: 18)!, textColor: UIColor(named: "pdHeadingTxtColr")!)
        
        pdf.addLineSpace(20)
        pdf.addText("CLIENT has carefully read the foregoing, agrees to it, and acknowledges receipt of a copy of this agreement and acknowledges limitations placed upon the inspection. The CLIENT acknowledges that by signing this agreement, that the CLIENT has entered into this agreement without influence, duress or penalty.",font: UIFont.systemFont(ofSize: 12))
        
        pdf.addLineSpace(5)
        pdf.addImage2(clientSignature, width: self.view.frame.width - 30, height: (self.view.frame.width - 180))
        
        pdf.addLineSpace(10)
        pdf.setContentAlignment(.left)
        pdf.addText(SingleTon.shared.clientName + "   "  + Date().toString(dateFormat: "dd/MMM/yyyy"), font: UIFont(name: "Lato-Bold", size: 14)!)
        
        pdf.beginNewPage()
        pdf.addLineSpace(5)
        pdf.addText(acknowledgementsMidLbl,font: UIFont(name: "Lato-Regular", size: 12)!)
        
        pdf.addLineSpace(10)
        pdf.addImage2(inspectorSignature, width: self.view.frame.width - 30, height: (self.view.frame.width - 180))
        
        pdf.addLineSpace(10)
        pdf.setContentAlignment(.left)
        pdf.addText(SingleTon.shared.inspectorName + "   " + Date().toString(dateFormat: "dd/MMM/yyyy"), font: UIFont(name: "Lato-Bold", size: 14)!)
        
        pdf.addLineSpace(20)
        pdf.addLineSeparator()
        pdf.addLineSpace(10)
        pdf.setContentAlignment(.center)
        
        pdf.addText("Inspection Type",font: UIFont(name: "Lato-Bold", size: 18)!, textColor: UIColor(named: "pdHeadingTxtColr")!)
       
        pdf.addLineSpace(10)
        pdf.setContentAlignment(.center)
        pdf.addText(SingleTon.shared.inspectReportType?.rawValue ?? "None", font: UIFont(name: "Lato-Bold", size: 25)!, textColor: UIColor .black)
        
        
        //-----------------------General Section------------------//
        pdf.beginNewPage()
        pdf.setContentAlignment(.center)
        pdf.addText("General Section", font: UIFont(name: "Lato-Bold", size: 25)!, textColor: UIColor(named: "NoColor")!)
        pdf.addLineSpace(15)
//        DispatchQueue.main.async {
            
        
            for i in 0..<self.questions.count{
            pdf.addLineSpace(10)
            pdf.setContentAlignment(.left)
            //pdf.addText(questions[i] as? String ?? "no", font: UIFont(name: "Lato-Regular", size: 17)!, bgColor: UIColor(named: "pdfCellColor")!)
                pdf.addText(self.questions[i] as? String ?? "no", font: UIFont(name: "Lato-Regular", size: 17)!)
           
//        -----------------------          MARK: -   Start Adding Headings of Sections    -----------------------------
                if self.questions[i].contains("comments") {
                pdf.addText(self.textBox[i] == "" ? "" : "  " + self.textBox[i] + "  " as? String ?? "",font: UIFont(name: "Lato-Regular", size: 17)!, textColor: UIColor.white)
    /*           if txtIndex != 14 {
                    pdf.beginNewPage()
                   pdf.setContentAlignment(.center)
                    pdf.addText(titleArr1[txtIndex]  as? String ?? "",font: UIFont(name: "Lato-Bold", size: 25)!,textColor: UIColor(named: "NoColor")!)
                    pdf.addLineSpace(15)
                    txtIndex += 1
                }*/
                    if txtIndex < titleArr1.count - 1{
                        pdf.beginNewPage()
                    }
               
                pdf.setContentAlignment(.center)
                    pdf.addText(titleArr1[self.txtIndex]  as? String ?? "",font: UIFont(name: "Lato-Bold", size: 25)!,textColor: UIColor(named: "NoColor")!)
                pdf.addLineSpace(15)
                    self.txtIndex += 1
            }
            //        -------------------------------      End of Headings Sections  -----------------------------
            //        -----------------------          MARK: -   Start Adding Deficiencies Answers    -----------------------------
            else{
                pdf.addText(self.textBox[i] == "" ? "" : "  " + self.textBox[i] + "  " as? String ?? "",font: UIFont(name: "Lato-Regular", size: 17)!, textColor: UIColor.white)
                pdf.addLineSpace(1)
              
            }
            //        -----------------------          MARK: -   End Of Adding Deficiencies Answers    -----------------------------
            
                if  self.yesBtnArr[i] == "radio-on-button"{
                pdf.addText("  YES  ", font: UIFont(name: "Lato-Regular", size: 17)!, textColor: UIColor.white)
                }else{
                    pdf.addLineSpace(1)
                }
                 if self.noBtnArr[i] == "radio-on-button"{
                pdf.addText("  NO  ", font: UIFont(name: "Lato-Regular", size: 17)!, textColor: UIColor.white)
                }else{
                    pdf.addLineSpace(1)
                }
                 if self.nilBtnArr[i] == "radio-on-button"{
                pdf.addText("  NIL  ", font: UIFont(name: "Lato-Regular", size: 17)!, textColor: UIColor.white)
                //pdf.addText("  NIL  ", font: UIFont(name: "Lato-Regular", size: 17)!, textColor: UIColor.black)
                }else{
                    pdf.addLineSpace(1)
                }
                 if self.imagesArr[i] != UIImage(){
                    pdf.addImage2((self.imagesArr[i] as? UIImage)!, width: self.view.frame.width - 30, height: (self.view.frame.width - 180))
                pdf.addLineSpace(2)
            }else{
                pdf.addLineSpace(1)
            }
            
            
            
            
                 if self.collectnArr[i] != [String](){
                //pdf.addText(self.collectnArr[i] as? String ?? "no",textColor: UIColor.blue)
                    let colectnValues = self.collectnArr[i]
                colectnValues.forEach { myValue in
                    print(myValue)
                    pdf.addText("  " + myValue + "  ", font: UIFont(name: "Lato-Regular", size: 17)!, textColor: UIColor.white)
                    pdf.addLineSpace(2)
                    
                }
                //pdf.addText(self.collectnArr[i][0] ?? "",textColor: UIColor.gray)
                //print("\(collectnArr)")
            }else{
                pdf.addLineSpace(1)
            }
                if self.textinput[i] != "" {
                pdf.addText(self.textinput[i] == "" ? "" : "  " + self.textinput[i] + "  " as? String ?? "",font: UIFont(name: "Lato-Regular", size: 17)!, textColor: UIColor.white)
                }else{
                    pdf.addLineSpace(1)
                }
            
                print("txtIndex===", self.txtIndex)
            
            pdf.addLineSpace(5)
            pdf.addLineSeparator(height: 0.2)
            pdf.addLineSpace(5)
            
//            if txtIndex != 15 {
//                pdf.addLineSpace(5)
//                pdf.addLineSeparator(height: 0.2)
//                pdf.addLineSpace(5)
//            }
        }
//        }
        print("txtIndex>>>>", self.txtIndex)
        
        //let pdfData  = NSData(contentsOfFile: path)
        //Indicator.sharedInstance.hideIndicator()
        DispatchQueue.main.async {
            let pdfData = pdf.generatePDFdata()
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PDFform_VC") as? PDFform_VC
            vc?.pdfData = pdfData as NSData
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        // }
        //        let pdftableImage = self.tableToImg(self.pdfTableView)
        //        //-- MAKE IMAGE TO PDF
        //        let pdf = SimplePDF(pageSize: CGSize(width: self.view.frame.width, height: self.pdfTableView.contentSize.height + 100),pageMarginLeft: 5, pageMarginTop: 20, pageMarginBottom: 40, pageMarginRight: 20)
        //        pdf.addImage(pdftableImage)
        //
        //        let pdfData = pdf.generatePDFdata()
        //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PDFform_VC") as? PDFform_VC
        //        vc?.pdfData = pdfData as NSData
        //        self.navigationController?.pushViewController(vc!, animated: false)
    }
    
    /*
    @objc func mybuttonAction(sender: UIButton) {
        DispatchQueue.main.async {
            Indicator.sharedInstance.showIndicator()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            print("Notification Btn Tapped")
            
            let path = self.pdfDataWithTableView(tableView: self.pdfTableView)
            print(path)
            
            let pdfData = NSData(contentsOfFile: path)
            
            Indicator.sharedInstance.hideIndicator()
            
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PDFform_VC") as? PDFform_VC
            vc?.pdfData = (pdfData)! as NSData
            self.navigationController?.pushViewController(vc!, animated: false)
            
            //            do {
            //               let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PDFform_VC") as? PDFform_VC
            //               let compressedData = try (pdfData?.compressed(using: .zlib))! as NSData
            //              vc?.pdfData = compressedData
            //               self.navigationController?.pushViewController(vc!, animated: false)
            //         } catch {
            //             print(error.localizedDescription)
            //         }
            //      }
            
            
            
            //        let pdftableImage = self.tableToImg(self.pdfTableView)
            //
            //        //-- MAKE IMAGE TO PDF
            //        let pdf = SimplePDF(pageSize: CGSize(width: self.view.frame.width, height: self.pdfTableView.contentSize.height + 100),pageMarginLeft: 5, pageMarginTop: 20, pageMarginBottom: 40, pageMarginRight: 20)
            //        pdf.addImage(pdftableImage)
            //
            //        let pdfData = pdf.generatePDFdata()
            //        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "PDFform_VC") as? PDFform_VC
            //        vc?.pdfData = pdfData as NSData
            //        self.navigationController?.pushViewController(vc!, animated: false)
        }
    }
    
    */
    func appendDataFromDictnriesToArrays(){
        //--FOR GETTING ANSWERS
        
        
        for dict in orignal_Dictioneries{
            dict.forEach { dict in
                questions.append(dict["text"] as? String ?? "")
                textinput.append(dict["textFieldText"] as? String ?? "" )
                textBox.append(dict["textViewText"] as? String ?? "")
                yesBtnArr.append(dict["yesBtn"] as? String ?? "")
                noBtnArr.append(dict["noBtn"] as? String ?? "")
                nilBtnArr.append(dict["nilBtn"] as? String ?? "")
                imagesArr.append((dict["uploadImg"] as? UIImage ?? UIImage()))
                localCollecArr = (dict["pickerSelections"] as? [String] ?? [String]() )
                collectnArr.append(localCollecArr)
            }
        }
        
        print( " questions::\(questions),textinputs ::\(textinput),textbos::\(textBox),yes Button ::\(yesBtnArr),no btn ::\(noBtnArr),nil btm:: \(nilBtnArr),images Arrr:: \(imagesArr),collection View data ::\(collectnArr)")
    }
    
    //--TO Empty All Arrays
    func emptyArrays(){
        questions = [String]()
        textinput = [String]()
        textBox = [String]()
        yesBtnArr = [String]()
        noBtnArr = [String]()
        nilBtnArr = [String]()
        imagesArr = [UIImage]()
    }
}

extension PdfTable_VC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 4350
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        headerView.frame = CGRect(x: 0, y: 0, width: pdfTableView.frame.width, height: 4200)
        headerView.frame = CGRect(x: 0, y: 0, width: pdfTableView.frame.width, height: 4350)
        //=====================================   MARK: PAGE: 1
        let toplbl1 = UILabel()
        toplbl1.frame = CGRect(x: headerView.frame.width - 100 , y: 0, width: 100, height: 15)
        toplbl1.textAlignment = .center
        toplbl1.text = "NFPA Certified"
        toplbl1.font = UIFont(name: "Lato-Regular", size: 12)
        
        let toplbl = UILabel()
        toplbl.frame = CGRect(x: 10, y: 25, width: headerView.frame.width, height: 25)
        toplbl.text = "Fire Sprinkler Inspection Report"
        toplbl.font = UIFont(name: "Lato-Regular", size: 22)
        //-----
        let subjLbl = UILabel()
        subjLbl.frame = CGRect(x: 10, y: 55, width: headerView.frame.width, height: 20)
        subjLbl.text = "Subject Property"
        subjLbl.font = UIFont(name: "Lato-Regular", size: 17)
        //-----
        let vertilineLbl = UILabel()
        vertilineLbl.frame = CGRect(x: 10, y: 80, width: view.frame.width - 20, height: 1.2)
        vertilineLbl.backgroundColor = UIColor(named: "Shadow_Color")
        //-----
        let horiLbl = UILabel()
        horiLbl.frame = CGRect(x: view.frame.width / 2 - 30, y: 83, width: 1.5, height: 75)
        horiLbl.backgroundColor = UIColor(named: "Shadow_Color")
        //-----
        let adressLabel = UILabel()
        adressLabel.frame = CGRect(x: view.frame.width / 2 - 25 , y: 83, width: 150, height: 75)
        adressLabel.numberOfLines = 0
        adressLabel.font = UIFont(name: "Lato-Regular", size: 14)
        
        adressLabel.text = SingleTon.shared.requestStreetNuber + " " + SingleTon.shared.requestAddressLine1 + " " + SingleTon.shared.requestAddressLine2 + " " + SingleTon.shared.requestCity + " " + SingleTon.shared.requestState
        
        //-----
        let ClientInfoLbl = UILabel()
        ClientInfoLbl.frame = CGRect(x: 10, y: 150, width: view.frame.width/2, height: 25)
        ClientInfoLbl.text = "Client Information"
        ClientInfoLbl.font = UIFont(name: "Lato-Regular", size: 17)
        //-----
        let vertiLbl2 = UILabel()
        vertiLbl2.frame = CGRect(x: 10, y: 180, width: view.frame.width - 20, height: 1.2)
        vertiLbl2.backgroundColor = UIColor(named: "Shadow_Color")
        //-----
        let clientNameLbl = UILabel()
        clientNameLbl.frame = CGRect(x: 30, y: 185, width:  120, height: 25)
        clientNameLbl.text = "Client name:"
        clientNameLbl.font = UIFont(name: "Lato-Regular", size: 18)
        
        let clientname = UILabel()
        clientname.frame = CGRect(x: 142, y: 185.3, width:  180, height: 25)
        clientname.text = SingleTon.shared.clientName
        clientname.font = UIFont(name: "Lato-Regular", size: 14)
        
        let inspactionDetailLbl = UILabel()
        inspactionDetailLbl.frame = CGRect(x: 10, y: 220, width:  headerView.frame.width / 2, height: 25)
        inspactionDetailLbl.text = "Inspection Details"
        inspactionDetailLbl.font = UIFont(name: "Lato-Regular", size: 18)
        
        let vertiLbl3 = UILabel()
        vertiLbl3.frame = CGRect(x: 10, y: 250, width: view.frame.width - 20, height: 1.2)
        vertiLbl3.backgroundColor = UIColor(named: "Shadow_Color")
        
        let dateHeadingLbl = UILabel()
        dateHeadingLbl.frame = CGRect(x: 30, y: 255, width:  100, height: 25)
        dateHeadingLbl.text = "Date/Time: "
        dateHeadingLbl.font = UIFont(name: "Lato-Regular", size: 18)
        
        let dateLabel = UILabel()
        dateLabel.frame = CGRect(x: 126, y: 255.3, width:  150, height: 25)
        dateLabel.text = Date().toString(dateFormat: "dd/MMM/yyyy")
        dateLabel.font = UIFont(name: "Lato-Regular", size: 14)
        
        let inspectConduLabel = UILabel()
        inspectConduLabel.frame = CGRect(x: 10, y: 285, width: headerView.frame.width , height: 25)
        inspectConduLabel.text = "Inspection Conducted By"
        inspectConduLabel.font = UIFont(name: "Lato-Regular", size: 18)
        
        let vertiLbl4 = UILabel()
        vertiLbl4.frame = CGRect(x: 10, y: 310, width: headerView.frame.width - 20, height: 1.2)
        vertiLbl4.backgroundColor = UIColor(named: "Shadow_Color")
        
        let logoimg = UIImageView()
        logoimg.frame = CGRect(x: 10, y: 325, width: (headerView.frame.width / 2) - 15, height: 250)
        logoimg.image = UIImage(named: "appLogo2")
        //logoimg.image = clientSignature
        logoimg.contentMode = .scaleToFill
        
        let horiLbl1 = UILabel()
        horiLbl1.frame = CGRect(x: headerView.frame.width / 2, y: 320, width: 1.5, height: 260)
        horiLbl1.backgroundColor = UIColor(named: "Shadow_Color")
        
        let companyAddressLbl = UILabel()
        companyAddressLbl.frame = CGRect(x: (headerView.frame.width / 2) + 10, y: 320, width: (headerView.frame.width/2) - 10 , height: 60)
        companyAddressLbl.numberOfLines = 0
        companyAddressLbl.font = UIFont(name: "Lato-Regular", size:18)
        companyAddressLbl.text = "24/7 Fire Protection Inc."
        
        let companyMiddleAddressLbl = UILabel()
        companyMiddleAddressLbl.frame = CGRect(x: (headerView.frame.width / 2) + 10, y: 380, width: 180 , height: 80)
        companyMiddleAddressLbl.numberOfLines = 0
        companyMiddleAddressLbl.font = UIFont(name: "Lato-Regular", size: 14)
        companyMiddleAddressLbl.text = "32 Heckel St Belleville NJ 07109"
        // companyMiddleAddressLbl.text = "32 Heckel St Belleville NJ 07109 Inspected by:\(SingleTon.shared.inspectorName)"
        
        let companyBottonmAddressLbl = UILabel()
        companyBottonmAddressLbl.frame = CGRect(x: (headerView.frame.width / 2) + 10, y: 460, width: 180 , height: 120)
        companyBottonmAddressLbl.numberOfLines = 0
        companyBottonmAddressLbl.font = UIFont(name: "Lato-Regular", size: 14)
        companyBottonmAddressLbl.text = "Phone: 973-525-9163 Fax: 877-643-8252 247fire.inspection@gmail.com www.24-7fireprotection.com"
        
        let vertiLbl5 = UILabel()
        vertiLbl5.frame = CGRect(x: 10, y: 585, width: headerView.frame.width - 20, height: 1.2)
        vertiLbl5.backgroundColor = UIColor(named: "Shadow_Color")
        
        let inspectByLabel = UILabel()
        inspectByLabel.frame = CGRect(x: 10, y: 592, width: 170 , height: 25)
        inspectByLabel.text = "Inspector name:"
        inspectByLabel.font = UIFont(name: "Lato-Regular", size: 18)
        
        let inspectNameLabel = UILabel()
        inspectNameLabel.frame = CGRect(x: 140, y: 592.3, width: 180 , height: 25)
        inspectNameLabel.text = SingleTon.shared.inspectorName
        inspectNameLabel.font = UIFont(name: "Lato-Regular", size: 16)
        
        //        let inspectSignlabel = UILabel()
        //        inspectSignlabel.frame = CGRect(x: 10, y: 620, width: headerView.frame.width / 2 , height: 20)
        //        inspectSignlabel.text = "Inspector's Signature:"
        //        inspectSignlabel.font = UIFont(name: "Lato-Bold", size: 18)
        
        //        let inspectSignlabeltext = UILabel()
        //        inspectSignlabeltext.frame = CGRect(x: 20, y: 620, width:headerView.frame.width  , height: 80)
        //        inspectSignlabel.numberOfLines = 0
        //        inspectSignlabeltext.text = "[signature not uploaded] P01281"
        //        inspectSignlabeltext.font = UIFont(name: "Lato-Regular", size: 14)
        
        let signImg = UIImageView()
        signImg.frame = CGRect(x: 10, y: 620, width: (headerView.frame.width) - 15, height: 150)
        signImg.image = inspectorSignature
        //logoimg.contentMode = .scaleToFill
        
        
        //        let deviderlbl = UILabel()
        //        deviderlbl.frame = CGRect(x: 0, y: 840, width:headerView.frame.width  , height: 10)
        //        deviderlbl.backgroundColor = UIColor(named: "Shadow_Color")
        //        //'===================================
        
        //=====================================   MARK: PAGE: 2
        //        let bottomPageView = UIView()
        //        bottomPageView.frame = CGRect(x: 0, y: 840, width: headerView.frame.width, height: 4250)
        //      bottomPageView.backgroundColor = .red
        // --------------------
        let agrimenTitleLbl = UILabel()
        agrimenTitleLbl.frame = CGRect(x: 10, y: 830 + 5, width: headerView.frame.width, height: 25)
        agrimenTitleLbl.text = "Inspection Agreement"
        agrimenTitleLbl.font = UIFont(name: "Lato-Bold", size: 22)
        
        let title1_bpage = PdfPaddingLabel()
        title1_bpage.frame = CGRect(x: 10, y: 830 + 30, width: headerView.frame.width - 20, height: 50)
        title1_bpage.numberOfLines = 0
        title1_bpage.backgroundColor = UIColor(named: "pdfHeadingBgColor")
        title1_bpage.textColor = UIColor(named: "pdHeadingTxtColr")
        title1_bpage.text = "PARTIES OF THIS INSPECTION AGREEMENT ANNUAL INSPECTION"
        title1_bpage.font = UIFont(name: "Lato-Bold", size: 18)
        
        let betweenLbl = UILabel()
        betweenLbl.frame =  CGRect(x: 10, y: 830 + 85, width: headerView.frame.width - 20, height: 20)
        betweenLbl.text = "BETWEEN:"
        betweenLbl.font = UIFont(name: "Lato-Bold", size: 18)
        
        let BotmPgVertiLbl1 = UILabel()
        //BotmPgVertiLbl1.frame = CGRect(x: 10, y: 830 + 110, width: headerView.frame.width / 2, height: 1.5)
        BotmPgVertiLbl1.frame = CGRect(x: 10, y: 830 + 110, width: headerView.frame.width - 20, height: 1.5)
        BotmPgVertiLbl1.backgroundColor = UIColor(named: "Shadow_Color")
        
        let betNameLbl = UILabel()
        betNameLbl.frame =  CGRect(x: 10, y: 830 +  115, width: headerView.frame.width - 20, height: 20)
        betNameLbl.text = SingleTon.shared.clientName
        betNameLbl.font = UIFont(name: "Lato-Bold", size: 18)
        
        let betAdressLbl = UILabel()
        betAdressLbl.numberOfLines = 0
        betAdressLbl.frame =  CGRect(x: 10, y: 830 + 130, width: headerView.frame.width - 20, height: 100)
        /*
         let streetNumber, addressLine1, addressLine2, city: String
         let state, postalCode: String
         */
        betAdressLbl.text =
        
        SingleTon.shared.requestStreetNuber + " " + SingleTon.shared.requestAddressLine1 + " " + SingleTon.shared.requestAddressLine2 + " " + SingleTon.shared.requestCity + " " + SingleTon.shared.requestState + " " + SingleTon.shared.postalCode
        
        //requestModel.userAddressInfo.streetNumber + " " + requestModel.userAddressInfo.addressLine1 + " " + requestModel.userAddressInfo.addressLine2 + " " + requestModel.userAddressInfo.city + " " + requestModel.userAddressInfo.state + " " + requestModel.userAddressInfo.postalCode + "\n" + requestModel.mobileNumber + "\n" + requestModel.email
        betAdressLbl.font = UIFont(name: "Lato-Regular", size: 14)
        
        let BotmPgVertiLbl2 = UILabel()
        BotmPgVertiLbl2.frame = CGRect(x: 10, y: 830 + 230, width: headerView.frame.width - 20, height: 1.5)
        BotmPgVertiLbl2.backgroundColor = UIColor(named: "Shadow_Color")
        
        let toTitleLabel = UILabel()
        toTitleLabel.frame =  CGRect(x: 10, y: 830 + 232, width: headerView.frame.width / 2, height: 20)
        toTitleLabel.text = "TO:"
        toTitleLabel.font = UIFont(name: "Lato-Bold", size: 18)
        
        let BotmPgVertiLbl3 = UILabel()
      //  BotmPgVertiLbl3.frame = CGRect(x: 10, y: 830 + 252, width: headerView.frame.width / 2, height: 1.5)
        BotmPgVertiLbl3.frame = CGRect(x: 10, y: 830 + 252, width: headerView.frame.width - 20, height: 1.5)
        BotmPgVertiLbl3.backgroundColor = UIColor(named: "Shadow_Color")
        
        let toNameLbl = UILabel()
        toNameLbl.frame =  CGRect(x: 10, y: 830 + 254, width: headerView.frame.width - 20, height: 20)
        toNameLbl.text = "24/7 Fire Protection Inc."
        toNameLbl.font = UIFont(name: "Lato-Bold", size: 18)
        
        let toAdressLbl = UILabel()
        toAdressLbl.numberOfLines = 0
        toAdressLbl.frame =  CGRect(x: 10, y: 830 + 274, width: headerView.frame.width - 20, height: 100)
        toAdressLbl.text = "32 Heckel St Belleville NJ 07109\nPhone: 973-525-9163 247 (fire.inspection@gmail.com)\nwww.24-7fireprotection.com"
        toAdressLbl.font = UIFont(name: "Lato-Regular", size: 14)
        
        let title2_bpage = PdfPaddingLabel()
        title2_bpage.frame = CGRect(x: 10, y: 830 + 375, width: headerView.frame.width - 20, height: 25)
        title2_bpage.numberOfLines = 0
        title2_bpage.backgroundColor = UIColor(named: "pdfHeadingBgColor")
        title2_bpage.textColor = UIColor(named: "pdHeadingTxtColr")
        title2_bpage.text = "SUBJECT PROPERTY"
        title2_bpage.font = UIFont(name: "Lato-Bold", size: 18)
        
        let BotmPgHoriLbl1 = UILabel()
        BotmPgHoriLbl1.frame = CGRect(x: headerView.frame.width / 3 - 10, y: 830 + 400, width: 2.5, height: 100)
        BotmPgHoriLbl1.backgroundColor = UIColor(named: "Shadow_Color")
        
        let subjProAdressLbl = UILabel()
        subjProAdressLbl.numberOfLines = 0
        subjProAdressLbl.text =
        
        SingleTon.shared.requestStreetNuber + " " + SingleTon.shared.requestAddressLine1 + " " + SingleTon.shared.requestAddressLine2 + " " + SingleTon.shared.requestCity + " " + SingleTon.shared.requestState
        
        //requestModel.requestAddressInfo.requestStreetNuber + " " + requestModel.requestAddressInfo.requestAddressLine1 + " " + requestModel.requestAddressInfo.requestAddressLine2 + " " + requestModel.requestAddressInfo.requestCity + " " + requestModel.requestAddressInfo.requestState
        subjProAdressLbl.frame = CGRect(x: headerView.frame.width / 3, y: 830 + 400, width:  headerView.frame.width / 3, height: 100)
        
        let title3_bpage = PdfPaddingLabel()
        title3_bpage.frame = CGRect(x: 10, y: 830 + 510, width: headerView.frame.width - 20, height: 50)
        title3_bpage.numberOfLines = 0
        title3_bpage.backgroundColor = UIColor(named: "pdfHeadingBgColor")
        title3_bpage.textColor = UIColor(named: "pdHeadingTxtColr")
        title3_bpage.text = " THE PARTIES UNDERSTAND AND VOLUNTARILY AGREE AS FOLLOWS"
        title3_bpage.font = UIFont(name: "Lato-Bold", size: 18)
        
        let conditionsLabel = UILabel()
        conditionsLabel.numberOfLines = 0
        conditionsLabel.frame = CGRect(x: 10, y: 830+570, width: headerView.frame.width - 20, height: 230)
        conditionsLabel.text = conditionsScope
        conditionsLabel.font = UIFont(name: "Lato-Regular", size: 12)
        
        //=====================================   MARK: PAGE: 3
        let conditionsLabel2 = UILabel()
        conditionsLabel2.numberOfLines = 0
        conditionsLabel2.frame = CGRect(x: 10, y: 1650, width: headerView.frame.width - 20, height: 820)
        conditionsLabel2.text = conditionsScope2
        conditionsLabel2.font = UIFont(name: "Lato-Regular", size: 12)
        
        //=====================================   MARK: PAGE: 4
        let conditionsLabel3 = UILabel()
        conditionsLabel3.numberOfLines = 0
        conditionsLabel3.frame = CGRect(x: 10, y: 2470, width: headerView.frame.width - 20, height: 450)
        conditionsLabel3.text = conditionsScope3
        conditionsLabel3.font = UIFont(name: "Lato-Regular", size: 12)
        
        let title4_bpage = PdfPaddingLabel()
        title4_bpage.frame = CGRect(x: 10, y: 2930, width: headerView.frame.width - 20, height: 25)
        title4_bpage.numberOfLines = 0
        title4_bpage.backgroundColor = UIColor(named: "pdfHeadingBgColor")
        title4_bpage.textColor = UIColor(named: "pdHeadingTxtColr")
        title4_bpage.text = " PRIVACY POLICY"
        title4_bpage.font = UIFont(name: "Lato-Bold", size: 18)
        
        let privacyContentLbl = UILabel()
        privacyContentLbl.numberOfLines = 0
        privacyContentLbl.frame = CGRect(x: 10, y: 2960, width: headerView.frame.width - 20, height: 235)
        privacyContentLbl.text = privacyCondins
        privacyContentLbl.font = UIFont(name: "Lato-Regular", size: 12)
        
        //=====================================   MARK: PAGE: 5
        
        let title5_bpage = PdfPaddingLabel()
        title5_bpage.frame = CGRect(x: 10, y: 3320, width: headerView.frame.width - 20, height: 25)
        title5_bpage.numberOfLines = 0
        title5_bpage.backgroundColor = UIColor(named: "pdfHeadingBgColor")
        title5_bpage.textColor = UIColor(named: "pdHeadingTxtColr")
        title5_bpage.text = " ACKNOWLEDGEMENTS"
        title5_bpage.font = UIFont(name: "Lato-Bold", size: 18)
        
        let acknowledgLbl = UILabel()
        acknowledgLbl.numberOfLines = 0
        acknowledgLbl.frame = CGRect(x: 10, y: 3320 + 30, width: headerView.frame.width - 20, height: 100)
        acknowledgLbl.text = acknowledgementsTopTxt
        acknowledgLbl.font = UIFont(name: "Lato-Regular", size: 12)
        
        let clientSignImg = UIImageView()
        clientSignImg.frame = CGRect(x: 10, y: 3320 + 140, width: headerView.frame.width - 20 , height: 120)
        clientSignImg.image = clientSignature
        
        //        let noClientSignLbl = UILabel()
        //        noClientSignLbl.numberOfLines = 0
        //        noClientSignLbl.textAlignment = .center
        //        noClientSignLbl.backgroundColor = UIColor(red: 252/255, green: 144/255, blue: 0/255, alpha: 1)
        //        noClientSignLbl.frame = CGRect(x: 10, y: 2910, width: 150, height: 20)
        //        noClientSignLbl.text = " (no client signature)"
        //        noClientSignLbl.font = UIFont(name: "Lato-Bold", size: 18)
        //
        let noSignClientNameLbl  = UILabel()
        noSignClientNameLbl.textAlignment = .left
        //noSignClientNameLbl.frame = CGRect(x: 10, y: 2935, width: bottomPageView.frame.width / 2 , height: 20)
        noSignClientNameLbl.frame = CGRect(x: 10, y: 3320 + 270, width: headerView.frame.width, height: 20)
        noSignClientNameLbl.text = SingleTon.shared.clientName + "   "  + Date().toString(dateFormat: "dd/MMM/yyyy")
        noSignClientNameLbl.font = UIFont(name: "Lato-Bold", size: 14)
        
        
        //
        //        let acknowClintDateLbl = UILabel()
        //        acknowClintDateLbl.textAlignment = .left
        //        //acknowClintDateLbl.frame = CGRect(x: bottomPageView.frame.width / 2, y: 2960, width: bottomPageView.frame.width / 2 , height: 20)
        //        acknowClintDateLbl.frame = CGRect(x: bottomPageView.frame.width - 250 , y: 2960, width: 200 , height: 20)
        //        acknowClintDateLbl.text = "June 14, 2019"
        //        acknowClintDateLbl.font = UIFont(name: "Lato-Regular", size: 14)
        
        let acknowledgMidLbl = UILabel()
        acknowledgMidLbl.numberOfLines = 0
        acknowledgMidLbl.frame = CGRect(x: 10, y: 3320 + 300, width: headerView.frame.width - 20, height: 80)
        acknowledgMidLbl.text = acknowledgementsMidLbl
        acknowledgMidLbl.font = UIFont(name: "Lato-Regular", size: 12)
        
        let inspectorSignImg = UIImageView()
        inspectorSignImg.frame = CGRect(x: 10, y: 3320 + 390, width: headerView.frame.width - 20 , height: 120)
        inspectorSignImg.image = inspectorSignature
        
        //        let noInspactSignLbl = UILabel()
        //        noInspactSignLbl.numberOfLines = 0
        //        noInspactSignLbl.textAlignment = .center
        //        noInspactSignLbl.backgroundColor = UIColor(red: 252/255, green: 144/255, blue: 0/255, alpha: 1)
        //        noInspactSignLbl.frame = CGRect(x: 10, y: 3160, width: 170, height: 20)
        //        noInspactSignLbl.text = "(no inspector signature)"
        //        noInspactSignLbl.font = UIFont(name: "Lato-Regular", size: 14)
        
        let noInspactSignNameLbl  = UILabel()
        noInspactSignNameLbl.textAlignment = .left
        noInspactSignNameLbl.frame = CGRect(x: 10, y: 3320 + 530, width: headerView.frame.width / 2 , height: 20)
        noInspactSignNameLbl.text = SingleTon.shared.inspectorName + "   " + Date().toString(dateFormat: "dd/MMM/yyyy")
        noInspactSignNameLbl.font = UIFont(name: "Lato-Bold", size: 14)
        
        
        /*
         
         let title4_bpage = PdfPaddingLabel()
         title4_bpage.frame = CGRect(x: 10, y: 2460, width: bottomPageView.frame.width - 20, height: 25)
         title4_bpage.numberOfLines = 0
         title4_bpage.backgroundColor = UIColor(named: "pdfHeadingBgColor")
         title4_bpage.textColor = UIColor(named: "pdHeadingTxtColr")
         title4_bpage.text = " PRIVACY POLICY"
         title4_bpage.font = UIFont(name: "Lato-Bold", size: 18)
         
         let privacyContentLbl = UILabel()
         privacyContentLbl.numberOfLines = 0
         privacyContentLbl.frame = CGRect(x: 10, y: 2485, width: bottomPageView.frame.width - 20, height: 280)
         privacyContentLbl.text = privacyCondins
         privacyContentLbl.font = UIFont(name: "Lato-Regular", size: 12)
         
         let title5_bpage = PdfPaddingLabel()
         title5_bpage.frame = CGRect(x: 10, y: 2760, width: bottomPageView.frame.width - 20, height: 25)
         title5_bpage.numberOfLines = 0
         title5_bpage.backgroundColor = UIColor(named: "pdfHeadingBgColor")
         title5_bpage.textColor = UIColor(named: "pdHeadingTxtColr")
         title5_bpage.text = " ACKNOWLEDGEMENTS"
         title5_bpage.font = UIFont(name: "Lato-Bold", size: 18)
         
         
         let acknowledgLbl = UILabel()
         acknowledgLbl.numberOfLines = 0
         acknowledgLbl.frame = CGRect(x: 10, y: 2795, width: bottomPageView.frame.width - 20, height: 100)
         acknowledgLbl.text = acknowledgementsTopTxt
         acknowledgLbl.font = UIFont(name: "Lato-Regular", size: 12)
         
         
         let clientSignImg = UIImageView()
         clientSignImg.frame = CGRect(x: 10, y: 2910, width: bottomPageView.frame.width - 20 , height: 120)
         clientSignImg.image = clientSignature
         
         //        let noClientSignLbl = UILabel()
         //        noClientSignLbl.numberOfLines = 0
         //        noClientSignLbl.textAlignment = .center
         //        noClientSignLbl.backgroundColor = UIColor(red: 252/255, green: 144/255, blue: 0/255, alpha: 1)
         //        noClientSignLbl.frame = CGRect(x: 10, y: 2910, width: 150, height: 20)
         //        noClientSignLbl.text = " (no client signature)"
         //        noClientSignLbl.font = UIFont(name: "Lato-Bold", size: 18)
         //
         let noSignClientNameLbl  = UILabel()
         noSignClientNameLbl.textAlignment = .left
         //noSignClientNameLbl.frame = CGRect(x: 10, y: 2935, width: bottomPageView.frame.width / 2 , height: 20)
         noSignClientNameLbl.frame = CGRect(x: 10, y: 3040, width: bottomPageView.frame.width, height: 20)
         noSignClientNameLbl.text = SingleTon.shared.clientName + "   "  + Date().toString(dateFormat: "dd/MMM/yyyy")
         noSignClientNameLbl.font = UIFont(name: "Lato-Bold", size: 14)
         
         
         //
         //        let acknowClintDateLbl = UILabel()
         //        acknowClintDateLbl.textAlignment = .left
         //        //acknowClintDateLbl.frame = CGRect(x: bottomPageView.frame.width / 2, y: 2960, width: bottomPageView.frame.width / 2 , height: 20)
         //        acknowClintDateLbl.frame = CGRect(x: bottomPageView.frame.width - 250 , y: 2960, width: 200 , height: 20)
         //        acknowClintDateLbl.text = "June 14, 2019"
         //        acknowClintDateLbl.font = UIFont(name: "Lato-Regular", size: 14)
         
         let acknowledgMidLbl = UILabel()
         acknowledgMidLbl.numberOfLines = 0
         acknowledgMidLbl.frame = CGRect(x: 10, y: 3060, width: bottomPageView.frame.width - 20, height: 80)
         acknowledgMidLbl.text = acknowledgementsMidLbl
         acknowledgMidLbl.font = UIFont(name: "Lato-Regular", size: 12)
         
         let inspectorSignImg = UIImageView()
         inspectorSignImg.frame = CGRect(x: 10, y: 3140, width: bottomPageView.frame.width - 20 , height: 120)
         inspectorSignImg.image = inspectorSignature
         
         //        let noInspactSignLbl = UILabel()
         //        noInspactSignLbl.numberOfLines = 0
         //        noInspactSignLbl.textAlignment = .center
         //        noInspactSignLbl.backgroundColor = UIColor(red: 252/255, green: 144/255, blue: 0/255, alpha: 1)
         //        noInspactSignLbl.frame = CGRect(x: 10, y: 3160, width: 170, height: 20)
         //        noInspactSignLbl.text = "(no inspector signature)"
         //        noInspactSignLbl.font = UIFont(name: "Lato-Regular", size: 14)
         
         let noInspactSignNameLbl  = UILabel()
         noInspactSignNameLbl.textAlignment = .left
         noInspactSignNameLbl.frame = CGRect(x: 10, y: 3280, width: bottomPageView.frame.width / 2 , height: 20)
         noInspactSignNameLbl.text = SingleTon.shared.inspectorName + "   " + Date().toString(dateFormat: "dd/MMM/yyyy")
         noInspactSignNameLbl.font = UIFont(name: "Lato-Bold", size: 14)
         
         */
        
        //
        //        let acknowInspactDateLbl = UILabel()
        //        acknowInspactDateLbl.textAlignment = .left
        //        acknowInspactDateLbl.frame = CGRect(x: bottomPageView.frame.width / 2, y: 3105, width: bottomPageView.frame.width / 2 , height: 20)
        //        acknowInspactDateLbl.text = "June 15, 2019"
        //        acknowInspactDateLbl.font = UIFont(name: "Lato-Bold", size: 14)
        
        //        let deviderlbl2 = UILabel()
        //        deviderlbl2.frame = CGRect(x: 0, y: 3320, width:headerView.frame.width  , height: 10)
        //        deviderlbl2.backgroundColor = UIColor(named: "Shadow_Color")
        
        
       
        
        // page 5 ends ; page 6
        
        let vertiLbl6 = UILabel()
        vertiLbl5.frame = CGRect(x: 10, y: 3900, width: headerView.frame.width - 20, height: 1.2)
        vertiLbl5.backgroundColor = UIColor(named: "Shadow_Color")
        
        
        
        
        let inspectionTypeHeading = PdfPaddingLabel()
        inspectionTypeHeading.frame = CGRect(x: 10, y: 3920, width: (headerView.frame.width) - 10, height: 25)
        inspectionTypeHeading.numberOfLines = 0
        inspectionTypeHeading.backgroundColor = UIColor(named: "pdfHeadingBgColor")
        inspectionTypeHeading.textColor = UIColor(named: "pdHeadingTxtColr")
        inspectionTypeHeading.text = "InspectionType"
        inspectionTypeHeading.font = UIFont(name: "Lato-Bold", size: 18)
        
        
             
        
        let inspectionType = UILabel()
        inspectionType.textAlignment = .center
        inspectionType.text = SingleTon.shared.inspectReportType?.rawValue ?? "None"
        inspectionType.frame = CGRect(x: 10, y:3950, width: (headerView.frame.width) - 10, height: 30)
        inspectionType.textColor = .black//UIColor(named: "NoColor")
        inspectionType.font = UIFont(name: "Lato-Bold", size: 18)
        
        
        let generaHeadingLabel = UILabel()
        generaHeadingLabel.textAlignment = .center
        generaHeadingLabel.text = "General Section"
        generaHeadingLabel.frame = CGRect(x: 10, y:4235, width: (headerView.frame.width) - 10, height: 25)
//        generaHeadingLabel.frame = CGRect(x: 10, y:4150, width: (headerView.frame.width) - 10, height: 25)
        generaHeadingLabel.textColor = UIColor(named: "NoColor")
        generaHeadingLabel.font = UIFont(name: "Lato-Bold", size: 25)
        //=====================================   MARK: PAGE: 6
        let conditionsLabel6 = UILabel()
    //    conditionsLabel6.numberOfLines = 0
        conditionsLabel2.frame = CGRect(x: 10, y: 1650, width: headerView.frame.width - 20, height: 820)
        conditionsLabel6.text = conditionsScope34
        conditionsLabel6.font = UIFont(name: "Lato-Regular", size: 12)
        headerView.addSubview(conditionsLabel6)
        headerView.addSubview(toplbl1)
        headerView.addSubview(toplbl)
        headerView.addSubview(subjLbl)
        headerView.addSubview(vertilineLbl)
        headerView.addSubview(horiLbl)
        headerView.addSubview(ClientInfoLbl)
        headerView.addSubview(vertiLbl2)
        headerView.addSubview(clientNameLbl)
        headerView.addSubview(clientname)
        headerView.addSubview(inspactionDetailLbl)
        headerView.addSubview(vertiLbl3)
        headerView.addSubview(dateHeadingLbl)
        headerView.addSubview(dateLabel)
        headerView.addSubview(inspectConduLabel)
        headerView.addSubview(vertiLbl4)
        headerView.addSubview(logoimg)
        headerView.addSubview(horiLbl1)
        headerView.addSubview(companyAddressLbl)
        headerView.addSubview(companyMiddleAddressLbl)
        headerView.addSubview(companyBottonmAddressLbl)
        headerView.addSubview(vertiLbl5)
        headerView.addSubview(inspectByLabel)
        headerView.addSubview(inspectNameLabel)
        //headerView.addSubview(inspectSignlabel)
        //headerView.addSubview(inspectSignlabeltext)
        headerView.addSubview(signImg)
        headerView.addSubview(adressLabel)
        //headerView.addSubview(deviderlbl)
        //headerView.addSubview(bottomPageView)
        //---------------------
        headerView.addSubview(agrimenTitleLbl)
        headerView.addSubview(title1_bpage)
        headerView.addSubview(betweenLbl)
        headerView.addSubview(BotmPgVertiLbl1)
        headerView.addSubview(betNameLbl)
        headerView.addSubview(betAdressLbl)
        headerView.addSubview(BotmPgVertiLbl2)
        headerView.addSubview(toTitleLabel)
        headerView.addSubview(BotmPgVertiLbl3)
        headerView.addSubview(toNameLbl)
        headerView.addSubview(toAdressLbl)
        headerView.addSubview(title2_bpage)
        headerView.addSubview(BotmPgHoriLbl1)
        headerView.addSubview(subjProAdressLbl)
        headerView.addSubview(title3_bpage)
        headerView.addSubview(conditionsLabel)
        headerView.addSubview(conditionsLabel2)
        headerView.addSubview(conditionsLabel3)
        headerView.addSubview(title4_bpage)
        headerView.addSubview(privacyContentLbl)
        headerView.addSubview(title5_bpage)
        headerView.addSubview(acknowledgLbl)
        //bottomPageView.addSubview(noClientSignLbl)
        headerView.addSubview(clientSignImg)
        headerView.addSubview(noSignClientNameLbl)
        //bottomPageView.addSubview(acknowClintDateLbl)
        headerView.addSubview(acknowledgMidLbl)
        headerView.addSubview(inspectorSignImg)
        //bottomPageView.addSubview(noInspactSignLbl)
        headerView.addSubview(noInspactSignNameLbl)
        //bottomPageView.addSubview(acknowInspactDateLbl)
        //
        
        headerView.addSubview(vertiLbl6)
        headerView.addSubview(inspectionTypeHeading)
        headerView.addSubview(inspectionType)
        
        
        headerView.addSubview(generaHeadingLabel)
        //        //
        //        bottomPageView.addSubview(deviderlbl2)
        
        return headerView
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = pdfTableView.dequeueReusableCell(withIdentifier: "PdfTable_Cell", for: indexPath) as! PdfTable_Cell
        cell.bottomLabels_View.isHidden = true
        cell.imge_View.isHidden = true
        cell.yesLabel.isHidden = true
        cell.bottomLabels_View.isHidden = true
        cell.imge_View.isHidden = true
        cell.textViewr_BaseView.isHidden = true
        cell.pdfCollec_BaseView.isHidden = true
        cell.heading_BaseView.isHidden = true
        
        cell.pdfTable_CollectnView.tag = indexPath.row
        cell.sendDataToArry(data: collectnArr[indexPath.row])
        cell.textViewerLabel.text = textBox[indexPath.row]
        cell.quesLabel.text = questions[indexPath.row]
        cell.LeftBottomLabel.text = textinput[indexPath.row]
        cell.uploadImageView.image = imagesArr[indexPath.row]
        //-- Labels Height
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            cell.leftBottomLbl_Width.constant = (textinput[indexPath.row].widthofstring(usingfont: UIFont(name: "Lato-Regular", size: 22) ?? .systemFont(ofSize: 22)) + 30)
            cell.width_YesLbl.constant = ((cell.yesLabel.text?.widthofstring(usingfont: UIFont(name: "Lato-Regular", size: 22) ?? .systemFont(ofSize: 22)))! + 20 )
        }
        else{
            cell.leftBottomLbl_Width.constant = (textinput[indexPath.row].widthofstring(usingfont:UIFont(name: "Lato-Regular", size: 14) ?? .systemFont(ofSize: 26)) + 40)
            cell.width_YesLbl.constant = ((cell.yesLabel.text?.widthofstring(usingfont: UIFont(name: "Lato-Regular", size: 26) ?? .systemFont(ofSize: 26)))! + 10)
            
        }
        //--COLLECTIONVIEW HEIGHT MENTAIN
        let collectnheight = cell.pdfTable_CollectnView.collectionViewLayout.collectionViewContentSize.height
        cell.pdfCollectn_Height.constant = collectnheight
        cell.collecBase_Height.constant = collectnheight
        cell.pdfTable_CollectnView.layoutIfNeeded()
        cell.pdfTable_CollectnView.isScrollEnabled = false
        cell.layoutIfNeeded()
        self.view.layoutIfNeeded()
        
        let txtViewhgt = textBox[indexPath.row].heightWithConstrainedWidth(width: tableView.frame.width, font: UIFont(name: "Lato-Regular", size: 14) ?? .systemFont(ofSize: 14))
        
        cell.textViewer_Height.constant = txtViewhgt + 20
        cell.textViewrBaseView_Height.constant = txtViewhgt + 40
        
        cell.addTapGestureRecognizer(){
            print("my indexes are ::\(self.demoArr)")
        }
        
        self.view.layoutIfNeeded()
        
        if (yesBtnArr[indexPath.row] ) == "radio-on-button" {
            cell.yesLabel.isHidden = false
            cell.yesLabel.text = "YES"
            
            cell.yesLabel.backgroundColor = UIColor(named: "YesColor")
        }
        else if (noBtnArr[indexPath.row] ) == "radio-on-button" {
            cell.yesLabel.isHidden = false
            cell.yesLabel.text = "NO"
            cell.yesLabel.backgroundColor = UIColor(named: "NoColor")
        }
        else if (nilBtnArr[indexPath.row] ) == "radio-on-button" {
            cell.yesLabel.isHidden = false
            cell.yesLabel.text = "NIL"
            cell.yesLabel.backgroundColor = UIColor(named: "NaColor")
        }
        else if (textinput[indexPath.row] ) != ""
        {
            cell.bottomLabels_View.isHidden = false
        }
        else if imagesArr[indexPath.row] != UIImage()
        {
            cell.imge_View.isHidden = false
        }
        else if (textBox[indexPath.row] ) != ""{
            cell.textViewr_BaseView.isHidden = false
        }
        else if collectnArr[indexPath.row] != [String]()
        {
            cell.pdfCollec_BaseView.isHidden = false
        }
        else if questions[indexPath.row].contains("comments")
        {
            demoArr.append(indexPath.row)
            
            print("demo array value are _+_+__+__+_+_+_+__++__+_++_+___+ /n" , demoArr)
            
            
            let text = titleArr1[tblTextIndex]
            cell.pageHeadingLabel.text = text
            cell.heading_BaseView.isHidden = false
            if tblTextIndex < titleArr1.count{
                tblTextIndex += 1
            }
            if indexPath.row == (pdfTableView.numberOfRows(inSection: 0)) - 1{
                cell.heading_BaseView.isHidden = true
            }
        }
        
     /*   switch indexPath.row {
        case 25:
            cell.pageHeadingLabel.text = "Pipe Section"
        case 40:
            cell.pageHeadingLabel.text = "Fdc Section"
        case 51:
            cell.pageHeadingLabel.text = "Heads Section"
        case 76:
            cell.pageHeadingLabel.text = "WetPipe Section"
        case 114:
            cell.pageHeadingLabel.text = "DryPipe Section"
        case 163:
            cell.pageHeadingLabel.text = "Tanks Section"
        case 181:
            cell.pageHeadingLabel.text = "Foam Section"
        case 203:
            cell.pageHeadingLabel.text = "StandPipe Section"
        case 227:
            cell.pageHeadingLabel.text = "Pump Section"
        case 255:
            cell.pageHeadingLabel.text = "FlowTest Section"
        case 275:
            cell.pageHeadingLabel.text = "WhilePumpIsRunning Section"
        case 289:
            cell.pageHeadingLabel.text = "CheckList Section"
        case 339:
            cell.pageHeadingLabel.text = "TransferSwitch Section"
        case 347:
            cell.pageHeadingLabel.text = "Extengushers Section"
        case 365:
            cell.pageHeadingLabel.text = "Fire Hydrants Section"
            
        default:
            break
        }*/
        
        return cell
        
    }
    //--  HEIGHT FOR ROW
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
        //        }
        
    }
    
    //--MENAGE TABLEVIEW HEIGHT FUNCTION
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        pdfTableView.layer.removeAllAnimations()
        pdfTableView.layer.removeAllAnimations()
        pdfTable_height.constant = pdfTableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
            
        }
        
    }
    //--CONVERT TABLEVIEW TO IMAGE FUNCTION
    func tableToImg(_ view : UITableView) -> UIImage {
        UIGraphicsBeginImageContext(view.frame.size)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension UITableView {
    func lastIndexpath() -> IndexPath {
        let section = max(numberOfSections - 1, 0)
        let row = max(numberOfRows(inSection: section) - 1, 0)
        
        return IndexPath(row: row, section: section)
    }
}

extension Date {
    func toString( dateFormat format  : String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}


/*
pdf.addText("• SCOPE OF WORK", font: UIFont(name: "Lato-Regular", size: 12)!)
pdf.addLineSpace(2)
pdf.addText("Contractor shall inspect and or test the equipment described herein in accordance the contract option selected above and the Contractors then current Report Form. All in accordance with terms and conditions contained herein and on the reverse side hereof.", font: UIFont(name: "Lato-Regular", size: 12)!)
pdf.addLineSpace(15)
pdf.addText("TERM")
pdf.addLineSpace(2)
pdf.addText("The term of this agreement shall be one (I) year from date hereof and shall be automatically renewed each year thereafter until the same shall be terminated by either party on at least 'thirty (30) days Written notice being given to the other party prior to the anniversary date thereof. Contractors then current charges shall apply for each renewal period.",font: UIFont.systemFont(ofSize: 12))

pdf.addLineSpace(15)
pdf.addText("COST OF INSPECTION")
pdf.addLineSpace(2)
pdf.addText("The subscriber shall pay to Contractor within 30 days after the first inspection has been made. If subscriber fails to pay the full amount due,Contractor, may at its option, terminate this contract, and, in any event, will not be obligated to perform any additional work until payment of the amount past due has been received by contractor.",font: UIFont.systemFont(ofSize: 12))
pdf.addLineSpace(15)
pdf.addText("REPORT OF INSPECTION")
pdf.addLineSpace(2)
pdf.addText("Notice of this agreement and copies of all Reports of inspection and or will be forward by the Contractor to authority having jurisdiction, where required, and to the Subscriber. Notice of termination shall be reported to authority having jurisdiction by Contractor.",font: UIFont.systemFont(ofSize: 12))
pdf.addLineSpace(15)
pdf.addText("LIMITATION OF LIBILITY")
pdf.addLineSpace(2)
pdf.addText("The Contractor makes: N0 WARRANTIES, EXPRESS, OR IMPLIED, INCLUDING, WITHOUT LIMITATION, WARRANTIES OF MERCHANTABILITY AND WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE. No promise not contained herein or affirmation of fact made by any employee, agent or representative of the Contractor shall constitute a Warranty by the Seller or give rise to any liability or obligation.",font: UIFont.systemFont(ofSize: 12))
pdf.addLineSpace(5)
pdf.addText("Contractors liability to Subscriber for personal injury, death, or property damage arising from performance under this contract shall be limited to the contract price. Subscriber shall hold Contractor harmless from any and all third party claims for personal injury, death or property damage, arising from Subscribers failure to maintain these systems or keep them in operative condition, whether based upon contract, warranty, tort, strict liability or otherwise. In no event shall the Contractor be liable for any special, indirect, incidental, consequential or liquidated, penal or any economic loss damages of any character, including but not limited to loss of use of Subscribers property, lost profits or lost production, whether claimed by the Subscriber or by any third party, irrespective of whether claims or actions for such damages are based upon contract, warranty, negligence, tort, strict liability or otherwise.",font: UIFont.systemFont(ofSize: 12))
pdf.addLineSpace(15)
pdf.addText("TERM AND CONDITIONS")
pdf.addLineSpace(10)
pdf.addText("REPORTS")
pdf.addLineSpace(10)
pdf.addText("The inspection and or test shall be completed on the Contractors then current Report form, which shall be given to the Subscriber. The report and recommendations by the Contractor are only advisory in nature and are intended to assist Subscriber in reducing the possibility of loss of property by indicating obvious defects or impairments noted to the system and equipment inspected and or tested which require prompt consideration. They are not intended to imply that all other defects, hazards or aspects of the system and equipment are under control at the time of inspection. Final responsibility for the condition and operation of the sprinkler system and or fire alarm and detection system equipment lies with the Subsciber",font: UIFont.systemFont(ofSize: 12))
pdf.addLineSpace(15)
pdf.addText("EMERGENCY SERVICE")
pdf.addLineSpace(2)
pdf.addText("Emergency service requested by the Subscriber will be furnished at an extra charge.",font: UIFont.systemFont(ofSize: 12))
pdf.addLineSpace(15)
pdf.addText("ADDITIONAL EQUIPMENT")
pdf.addLineSpace(2)
pdf.addText("In the event additional equipment is installed after the date of this contract, the annual inspection charge shall be increased in accordance with contractors prevailing rates as of the first inspection of such additional equipment.",font: UIFont.systemFont(ofSize: 12))
pdf.addLineSpace(10)
pdf.addText("WORK NOT INCLUDED")
pdf.addLineSpace(2)
pdf.addText("The inspection and testing provided under this agreement does not include any maintenance, repairs, alterations and replacement of parts or any field adjustments whatsoever. Should any such work be requested by Subscriber they will be as an addition to this agreement. The contractor shall furnish the Subscriber with an estimate price before the additional work.",font: UIFont.systemFont(ofSize: 12))
pdf.addLineSpace(10)
pdf.addText("ACCEPTANCE OF TERMS")
pdf.addLineSpace(2)
pdf.addText("No changes or modifications are to be made without the written consent of executive officer of the contracting firm. Contractor is not bound by any provisions printed or otherwise at variance with this agreement that may appear on any acknowledgment or other form used by Subscriber, such provisions being hereby expressly rejected.",font: UIFont.systemFont(ofSize: 12))
pdf.addLineSpace(15)
pdf.addText("ENTRY")
pdf.addLineSpace(2)
pdf.addText("Contractor may enter Subscribers premises at all reasonable times to perform the inspections required by this contract.",font: UIFont.systemFont(ofSize: 12))
pdf.addLineSpace(15)
pdf.addText("ASSIGNMENT")
pdf.addLineSpace(2)
pdf.addText("This contract shall constitute a personal agreement between Contractor and Subscriber and shall be assignable by either party only with a written consent of the other.",font: UIFont.systemFont(ofSize: 12))
*/
