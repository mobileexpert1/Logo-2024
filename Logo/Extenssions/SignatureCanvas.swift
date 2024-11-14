//  SignatureCanvas.swift
//  Created by Akshay on 20/01/22.

import Foundation
import UIKit

struct Line {
    var points: [CGPoint]
}

class SignatureCanvas: UIView {

    // public function
    fileprivate var strokeColor = UIColor.red
    fileprivate var strokeWidth: Float = 1

    func setStrokeWidth(width: Float) {
        self.strokeWidth = width
    }

    func setStrokeColor(color: UIColor) {
        self.strokeColor = color
    }

    func undo() {
        _ = lines.popLast()
        setNeedsDisplay()
    }

    func clear() {
        lines.removeAll()
        setNeedsDisplay()
    }

    var lines = [Line]()

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        guard let context = UIGraphicsGetCurrentContext() else { return }

        lines.forEach { (line) in
            context.setStrokeColor(UIColor.black.cgColor)
            context.setLineWidth(CGFloat(2))
            context.setLineCap(.round)
            for (i, p) in line.points.enumerated() {
                if i == 0 {
                    context.move(to: p)
                } else {
                    context.addLine(to: p)
                }
            }
            context.strokePath()
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        lines.append(Line.init(points: []))
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
       // guard let point = touches.first?.location(in: nil) else { return }
        guard let point = touches.first?.location(in: self) else { return }
        guard var lastLine = lines.popLast() else { return }
        lastLine.points.append(point)
        lines.append(lastLine)
        setNeedsDisplay()
    }
}

/*
 USAGE : In controller class
 
 @IBOutlet weak var signatureView: SignatureCanvas!
 @IBOutlet weak var signatureImage: UIImageView!
 
 
 override func viewDidLoad() {
     super.viewDidLoad()
     setupViews()
     signatureView.setStrokeColor(color: .white)
 }
 
 func setupViews(){
     signatureView.layer.borderWidth = 1
     signatureView.layer.borderColor = UIColor.black.cgColor
 }
 
 
 @IBAction func clearButtonTapped(_ sender: UIButton) {
     signatureView.clear()
     signatureImage.isHidden = true
 }
 
 @IBAction func convertToImage(_ sender: UIButton) {
     let signImg : UIImage = convertViewToImage(view: signatureView)!
     signatureImage.image = signImg
     signatureImage.isHidden = false
 }

 
 // ---- if we need to convert the view to image
 
 func convertViewToImage(view: UIView) -> UIImage? {
     UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.isOpaque, 0.0)
     defer { UIGraphicsEndImageContext() }
     if let context = UIGraphicsGetCurrentContext() {
         view.layer.render(in: context)
         let image = UIGraphicsGetImageFromCurrentImageContext()
         return image
     }
     return nil
 }
 
 
 */
