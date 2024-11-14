//  GraphVC.swift
//  Logo
//  Created by Mobile on 27/12/22.

import UIKit
import Charts

class GraphVC: UIViewController {
    
    @IBOutlet weak var lineGraphView: LineChartView!
    
    @IBOutlet weak var sideLabelHeight: NSLayoutConstraint!
    
    @IBOutlet weak var sideHolderView: UIView!
    @IBOutlet weak var bottomHolderView: UIView!
    
    @IBOutlet weak var labelCnterY: NSLayoutConstraint!
    @IBOutlet weak var labelCenterX: NSLayoutConstraint!
    @IBOutlet weak var graphCenterX: NSLayoutConstraint!
    @IBOutlet weak var graphCenterY: NSLayoutConstraint!
    @IBOutlet weak var sideLabelWidth: NSLayoutConstraint!
    @IBOutlet weak var sideLabelHolderWidth: NSLayoutConstraint!
    @IBOutlet weak var sideLabelHolderHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomLabelText: UILabel!
    @IBOutlet weak var sideTextLabel: UILabel!
    @IBOutlet weak var driverSpeedAtChurn: UITextField!
    @IBOutlet weak var suctionAtChurn: UITextField!
    @IBOutlet weak var dischargeAtChurn: UITextField!
    
    @IBOutlet weak var driverSpeedAt100: UITextField!
    @IBOutlet weak var suctionAt100: UITextField!
    @IBOutlet weak var dischargeAt100: UITextField!
    
    @IBOutlet weak var driverSpeedAt150: UITextField!
    @IBOutlet weak var suctionAt150: UITextField!
    @IBOutlet weak var dischargeAt150: UITextField!
    
    @IBOutlet weak var doneBtn: UIButton!
    
    
    var ratedPressure = String()
    var ratedVolume = String()
    
    var flowTestTableValuesArray = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.sideHolderView.isHidden = true
        self.bottomHolderView.isHidden = true
        self.lineGraphView.isHidden = true
        
        setNavigationBar(vc: self, middleTitle: "Form", leftAction: #selector(leftBtnAction(sender:)),rightAction: #selector(leftBtnAction(sender:)))
        
        doneBtn.actionBlock {
            
            //label setting on gragh side towards y-axis
            self.sideHolderView.isHidden = false
            self.bottomHolderView.isHidden = false
            
            self.sideLabelHeight.constant = self.sideLabelHolderWidth.constant
            self.sideLabelWidth.constant = self.sideLabelHolderHeight.constant
                        
            self.labelCnterY.constant = self.graphCenterX.constant - 40
            self.labelCenterX.constant = self.graphCenterY.constant
            
            self.lineGraphView.isHidden = false
            
            let value1 = Double(self.driverSpeedAtChurn.text ?? "0.0") ?? 0.0
            let value3 = Double(self.dischargeAtChurn.text ?? "0.0") ?? 0.0
            let value2 = Double(self.suctionAtChurn.text ?? "0.0") ?? 0.0
            
            let value4 = Double(self.driverSpeedAt100.text ?? "0.0") ?? 0.0
            let value6 = Double(self.dischargeAt100.text ?? "0.0") ?? 0.0
            let value5 = Double(self.suctionAt100.text ?? "0.0") ?? 0.0
            
            let value7 = Double(self.driverSpeedAt150.text ?? "0.0") ?? 0.0
            let value9 = Double(self.dischargeAt150.text ?? "0.0") ?? 0.0
            let value8 = Double(self.suctionAt150.text ?? "0.0") ?? 0.0
            
            
            self.flowTestTableValuesArray.append(value1)
            self.flowTestTableValuesArray.append(value2)
            self.flowTestTableValuesArray.append(value3)
            self.flowTestTableValuesArray.append(value4)
            self.flowTestTableValuesArray.append(value5)
            self.flowTestTableValuesArray.append(value6)
            self.flowTestTableValuesArray.append(value7)
            self.flowTestTableValuesArray.append(value8)
            self.flowTestTableValuesArray.append(value9)
            
            var strArr = [String]()
            
            self.flowTestTableValuesArray.forEach { value in
                strArr.append(String(value))
            }
            print(strArr)
            SectionDataHandler.shared.flowTestTableValues = strArr.joined(separator: ",")
            
           // let data = LineChartData()
            
            let chartDataEntry1 = ChartDataEntry(x: 0, y: (value3 - value2))
            let chartDataEntry2 = ChartDataEntry(x: Double(self.ratedVolume) ?? 0.0, y: (value6 - value5))
            let chartDataEntry3 = ChartDataEntry(x: ((Double(self.ratedVolume) ?? 0.0)*1.5), y: (value9 - value8))
            
            let chartDataEntry11 = ChartDataEntry(x: 0, y: (value3 - value2))
            let chartDataEntry22 = ChartDataEntry(x: Double(self.ratedVolume) ?? 0.0, y: Double(self.ratedPressure) ?? 0.0)
            let chartDataEntry33 = ChartDataEntry(x: ((Double(self.ratedVolume) ?? 0.0)*1.5), y: ((Double(self.ratedPressure) ?? 0.0)*0.65))
            
            var dataEntries = [ChartDataEntry]()
            dataEntries.append(chartDataEntry1)
            dataEntries.append(chartDataEntry2)
            dataEntries.append(chartDataEntry3)
            
            let dataset = LineChartDataSet(entries: dataEntries, label: Date.getCurrentDate())
            dataset.colors = [NSUIColor.orange]
            // data.append(dataset)
            
            
            var dataEntries1 = [ChartDataEntry]()
            dataEntries1.append(chartDataEntry11)
            dataEntries1.append(chartDataEntry22)
            dataEntries1.append(chartDataEntry33)
            
            let dataset1 = LineChartDataSet(entries: dataEntries1, label: "Theoretical")
            dataset1.colors = [NSUIColor.cyan]
            
            let data = LineChartData(dataSets: [dataset, dataset1])
            
            self.lineGraphView.data = data
            
            
            
            self.lineGraphView.gridBackgroundColor = NSUIColor.white
            self.lineGraphView.xAxis.drawGridLinesEnabled = true;
            self.lineGraphView.xAxis.labelPosition = XAxis.LabelPosition.bottom
            self.lineGraphView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
            
        }
    }
    
    @objc func leftBtnAction(sender: UIButton){
        if !self.lineGraphView.isEmpty() {
            SectionDataHandler.shared.graphImage = self.lineGraphView.asImage()
            SectionDataHandler.shared.graphImageStr = SectionDataHandler.shared.convertImageToBase64String(img: SectionDataHandler.shared.graphImage)
        }
        navigationController?.popViewController(animated: true)
    }
    
}

/*
 Tags:
 
 201 : Driver speed at churn
 202 : Suction at churn
 203 : Discharge at churn
 
 204 : Driver speed at 100%
 205 : Suction at 100%
 206 : Discharge at 100%
 
 207 : Driver speed at 150%
 208 : Suction at 150%
 209 : Discharge at 150%
 
 */

extension UIView {
    
    // Using a function since `var image` might conflict with an existing variable
    // (like on `UIImageView`)
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
}


extension Date {

 static func getCurrentDate() -> String {

        let dateFormatter = DateFormatter()

        dateFormatter.dateFormat = "MMM d, yyyy"

        return dateFormatter.string(from: Date())

    }
}

