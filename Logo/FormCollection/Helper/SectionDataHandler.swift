//
//  SectionDataHandler.swift
//  Logo
//
//  Created by Mobile on 23/12/22.
//

import UIKit

class SectionDataHandler: NSObject {
    
    static let shared = SectionDataHandler()
    
    var model : SectionApiModel!
    var isFormCompletelyFilledForIndexes = [Int]()
    var graphImage = UIImage()
    var graphImageStr = String()
    var alltempImageDictHolder = [[String:String]]()
    var allImagesArray = [[String:String]]()
    var allimageDictHolder = [[String:String]]()
    var imageDictHolder = [String:String]()
    var tempImageDictHolder = [String:String]()
    var tempImageDictHolders = [[String:String]]()
    var flowTestTableValues = String()
    
    var selectedReportId = String()
    var textValueForPicker = String()  // new added for testing 
    var Buildingids = String()
    
    var chartOneFinalData = [String:Any]()
    var chartTwoFinalData = [String:Any]()
   
    
    var selectedIndexForImage = Int()
    var indexpathRowForImage = Int()
    
    
    func getModelFromWebCall(_ apiModel : SectionApiModel) {
        model = apiModel
    }
    
    func bindInputModel() {
        do {
            //graphImageStr = convertImageToBase64String(img: graphImage)
            let response = try model.toJSON()
            let vc = UIApplication.visibleViewController.storyboard?.instantiateViewController(withIdentifier: "SignatureVC") as! SignatureVC
            vc.responseString = response
            UIApplication.visibleViewController.navigationController?.pushViewController(vc, animated: true)
        } catch let error {
            print(error.localizedDescription)
        }
        
    }
    
    func convertImageToBase64String (img: UIImage) -> String {
//        print(img)
//        let cImg = resizeImage(image: img)
//        print(cImg)
        //return "data:image/png;base64,"+(img.jpegData(compressionQuality: 0.5)?.base64EncodedString() ?? "")
        let size = CGSize(width: 300, height: 200)
        // print("data:image/png;base64,"+(img.imageResized(to: size).pngData()!.base64EncodedString()))
        return "data:image/png;base64,"+(img.imageResized(to: size).pngData()!.base64EncodedString())
    }
    
    func convertImageToBase64String2 (img: UIImage) -> String {
//        return img.jpegData(compressionQuality: 0.5)?.base64EncodedString() ?? ""
        return img.imageResized(to: CGSize(width: 100, height: 100)).pngData()?.base64EncodedString() ?? ""
    }
    
    func convertBase64StringToImage (imageBase64String:String) -> UIImage {
        //        let imageData = Data(base64Encoded: imageBase64String)
        //        let image = UIImage(data: imageData!)
        //        return image!
        
        //        if let url = URL(string: imageBase64String), let data = try? Data(contentsOf: url) {
        //            let img = UIImage(data: data)!
        //            return img
        //        }
        //        return UIImage()
        if let decData = Data(base64Encoded: imageBase64String, options: .ignoreUnknownCharacters), let image = UIImage(data: decData) {
            return image
        }
        return UIImage()
    }
       //vish
//        if let decData = Data(base64Encoded: imageBase64String, options: .ignoreUnknownCharacters) {
//                   return UIImage(data: decData)!
//               }
//               return UIImage()
//        
//    }
}

extension UIImage {
    func imageResized(to size: CGSize) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func resized(withPercentage percentage: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: size.width * percentage, height: size.height * percentage)
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
