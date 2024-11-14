//
//  PaymentSucessPopup.swift
//  TruliPay
//
//  Created by Mobile on 19/04/22.
//

import UIKit
//import Charts
//import m
class GraphView: UIView {
   
    
//    private var dataEntries: [MLPointEntry] = []
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var upoadBtn: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var graphView: UIView!
    
    @IBOutlet weak var UploadGraphBtn: UIButton!
    
    @IBOutlet weak var charmRPMsTxtF: UITextField!
    @IBOutlet weak var charmSuctionTxtF: UITextField!
    @IBOutlet weak var charmDisTxtF: UITextField!
    
    @IBOutlet weak var oneRPMsTxtF: UITextField!
    @IBOutlet weak var oneSuctionTxtF: UITextField!
    @IBOutlet weak var oneDisTxtF: UITextField!
    
    
    @IBOutlet weak var twoRPMsTxtF: UITextField!
    @IBOutlet weak var twoSuctionTxtF: UITextField!
    @IBOutlet weak var twoDisTxtF: UITextField!
    
    var lineChart:UIView?
    var selectedInsPectionType:InspectTypeEnum?
    
    private var cellReuseIdentifier = "cell"

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLineChart()
        
        
                       
     }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        setupView()
        setupLineChart()
        
     }
    
    @IBAction func uploadButton(_ sender: UIButton) {
        let image = generateImageFromUIView(graphView)
        
        
    }
    func setupView() {
        Bundle.main.loadNibNamed("GraphView", owner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
          
    }
    
    
    func generateImage() -> UIImage{
        return generateImageFromUIView(graphView)
    }
    
    func setupLineChart(){
        lineChart = UIView()
        graphView.addSubview(lineChart!)
        lineChart?.bringSubviewToFront(graphView)
        lineChart?.layout{
            $0.leading.equal(to: graphView.leadingAnchor,offsetBy: 5)
            $0.trailing.equal(to: graphView.trailingAnchor,offsetBy: -5)
            $0.bottom.equal(to: graphView.bottomAnchor,offsetBy: -5)
            $0.top.equal(to: graphView.topAnchor,offsetBy: 5)
        }
        
//        lineChart?.delegate = self
        makeData()
        setupChart()
    }
    private func makeData() {
//        dataEntries.append(MLPointEntry(value: 7, label: "0", color: .gray))
//        dataEntries.append(MLPointEntry(value: 5, label: "400", color: .green))
//        dataEntries.append(MLPointEntry(value: 4, label: "600", color: .blue))
//        dataEntries.append(MLPointEntry(value: 4, label: "3", color: .blue))
//        dataEntries.append(MLPointEntry(value: 4, label: "3", color: .blue))
//        dataEntries.append(MLPointEntry(value: 4, label: "3", color: .blue))
//        dataEntries.append(MLPointEntry(value: 4, label: "3", color: .blue))
    }
    
    private func setupChart() {
        
        
//        let data = ChartData()
        
        
//        lineChart?.data = data
//        lineChart?.dataEntries = dataEntries
//        lineChart?.lineColor = .gray
//        lineChart?.lineWidth = 2
//        lineChart?.showShadows = true
//        lineChart?.showAxisLine = true
//        lineChart?.gradienLinesColors = [UIColor.gray.cgColor, UIColor.green.cgColor, UIColor.blue.cgColor]
//        lineChart?.configLabelsBottom = MLLabelConfig(color: .black,
//                                                           backgroundColor: .clear,
//                                                           rounded: false,
//                                                           font: UIFont.systemFont(ofSize: 11),
//                                                           width: 60, height: 16, fontSize: 11)
    }
    
   
    
    private func generateImageFromUIView(_ view: UIView) -> UIImage {
       let opaque = false
       UIGraphicsBeginImageContextWithOptions(view.bounds.size, opaque, 0.0)
       view.layer.render(in: UIGraphicsGetCurrentContext()!)
       let img: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
       UIGraphicsEndImageContext()
       return img
   }
    
}
