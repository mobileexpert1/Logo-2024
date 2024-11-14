//
//  ApiFunc.swift
//  AlamofireDemo
//
//  Created by MD Razaul on 03/03/22.
//

import Foundation
import UIKit
import Alamofire
import PKHUD
class ApiFunc : NSObject{
    
    //MARK:- Shared Instance
    static let shared = ApiFunc()
    var dictToken : [String:Any]!
    var yourToken = " "
    var message = " "
    
    private override init() {
    }
    
    // MARK: - Functions-
    
    func handleErrorCase(_ statusCode : Int?, _ dict : NSDictionary?) {
        let msg = dict?.value(forKey: "message") as! String
        print("msg - > ", msg)
        print("status code - > ",statusCode!)
        HUD.hide()
        
        if msg == "Session Expire, Please Relogin" {
            HUD.flash(.labeledError(title: "", subtitle: msg), onView: UIApplication.visibleViewController.view, delay: 1.5) { _ in
                self.goToLogin()
            }
        } else {
            HUD.show(.labeledError(title: "", subtitle: msg))
        }
    }
    
    func goToLogin(){
        let refreshAlert = UIAlertController(title: "Alert", message: "Token Expired", preferredStyle: UIAlertController.Style.alert)
        SingleTon.shared.userToken = ""
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
            UIApplication.shared.currentWindow?.rootViewController = loginVC
            UIApplication.shared.currentWindow?.makeKeyAndVisible()
        }))
        
        UIApplication.shared.currentWindow?.rootViewController?.present(refreshAlert, animated: true, completion: nil)
    }
    
    // -- To check whether the json is valid or not
    func isValidJson(check data: Data) -> Bool {
        do {
            if let _ = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                return true
            } else if let _ = try JSONSerialization.jsonObject(with: data, options: []) as? NSArray {
                return true
            } else {
                return false
            }
        } catch let error as NSError {
            print(error)
            return false
        }
    }
    
    // MARK: - Base Request API-
    func baseRequestApi<T: Codable>(_ url: String, _ method : HTTPMethod, _ params: [String: Any]? = nil, _ headers: [String: String]? = nil, completion: @escaping (_ response : T?) -> Void){
        
        print("HTTPMethod----> ", method)
                print("URL----> ", url)
//                 print("PARAMS----> ", params)
                 print(headers)
        
        if Connectivity.isConnectedToInternet {
            AF.request(url, method: method, parameters: params, headers: headers?.toHeader()) { $0.timeoutInterval = 120 }.validate().responseDecodable(of: T.self) { response in
               
//                if let data = response.data, let dataString = String(data: data, encoding: .utf8) { print("Response Data: \(dataString)")
//                }
            
                
                if response.data != nil {
                    if response.response?.statusCode == 200 {
                        do {
                            if let jsonData = response.data {
                                print(jsonData)
                                if self.isValidJson(check: jsonData) {
                                    let dataModel = try JSONDecoder().decode(T.self, from: jsonData)
                                    completion(dataModel)
                                } else {
                                    HUD.flash(.labeledError(title: "", subtitle: "Something went wrong"), delay: 1.0)
                                }
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    } else if response.response?.statusCode == 401 {
                        let refreshAlert = UIAlertController(title: "Alert", message: "Token Expired", preferredStyle: UIAlertController.Style.alert)
                        SingleTon.shared.userToken = ""
                        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
                            UIApplication.shared.currentWindow?.rootViewController = loginVC
                            UIApplication.shared.currentWindow?.makeKeyAndVisible()
                        }))
                        
                        UIApplication.shared.currentWindow?.rootViewController?.present(refreshAlert, animated: true, completion: nil)
                    } else {
                        do {
                            if let jsonData = response.data {
                                if self.isValidJson(check: jsonData) {
                                    print(jsonData)
                                    let dataModel = try JSONDecoder().decode(T.self, from: jsonData)
                                    completion(dataModel)
                                    self.handleErrorCase(response.response?.statusCode, dataModel as? NSDictionary)
                                } else {
                                    HUD.flash(.labeledError(title: "", subtitle: "Something went wrong"), delay: 1.0)
                                }
                            }
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    HUD.hide()
                } else {
                    HUD.hide()
                    HUD.flash(.labeledError(title: "",  subtitle: "Something went wrong"), delay: 1.0)
                }
            }
        } else {
            HUD.hide()
            HUD.flash(.labeledError(title: "", subtitle: "The Internet connection appears to be offline."), delay: 1.0)
        }
    }
    
    
    
// vish
    // MARK: - Base Request API-
    func baseRequestApi1<T: Codable>(_ url: String, _ method: HTTPMethod, _ params: [[String: Any]]? = nil, _ headers: [String: String]? = nil, completion: @escaping (T?) -> Void) {
        
        print("HTTPMethod----> ", method)
        print("URL----> ", url)
        
        if Connectivity.isConnectedToInternet {
            let parameters: Parameters? = params?.reduce(into: [:]) { (result, dict) in
                guard let key = dict.keys.first, let value = dict[key] else { return }
                result[key] = value
            }
            
            AF.request(url, method: method, parameters: parameters, headers: headers?.toHeader())
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let dataModel):
                        completion(dataModel)
                    case .failure(let error):
                        print("Request failed with error: \(error)")
                        completion(nil)
                    }
                }
        } else {
            HUD.hide()
            HUD.flash(.labeledError(title: "", subtitle: "The Internet connection appears to be offline."), delay: 1.0)
        }
    }

    
    //MARK: -- LOGIN API
    func loginApi(_ view: UIView, username: String, password: String, completion: @escaping(_ : LoginModel) -> Void) {
        HUD.show(.progress, onView: view)
        
        let loginParams : [String: String] = [
            "deviceToken" : SingleTon.shared.fcmToken,
            "email" : username,
            "password" : password,
        ]
        
        print(loginParams)
        
        baseRequestApi(ApiUrl.LogInUrl, .post, loginParams) { (result: LoginModel?) in
            print(result!)
            completion(result!)
        }
    }
    
    func AddressAddApi(_ view: UIView, city: String, state: String, postalCode: String, AddressLine: String, completion: @escaping(_ : AddressPopUpModel) -> Void) {
        HUD.show(.progress, onView: view)
        
        let loginParams : [String: String] = [
            "addressLine": AddressLine,
            "organizationsId" : SingleTon.shared.organizationsIds,
            "city" : city,
            "state" : state,
            "postalCode" : postalCode,
            
            
        ]
    
        print(loginParams)
        
        baseRequestApi(ApiUrl.AddAddress, .post, loginParams) { (result: AddressPopUpModel?) in
            print(result!)
            completion(result!)
        }
    }
   
    
    func BulidingAddApi(_ view: UIView, Name: String , completion: @escaping(_ : NewAddBulidingModel) -> Void) {
        HUD.show(.progress, onView: view)
        
        let loginParams : [String: String] = [
            "addressId": SingleTon.shared.addressId,
            "name" : Name,
          
        ]
    
        print(loginParams)
        
        baseRequestApi(ApiUrl.addBuilding, .post, loginParams) { (result: NewAddBulidingModel?) in
            print(result!)
            completion(result!)
        }
    }
    
    
    func SectionBulidingAddApi(_ view: UIView, Name: String , completion: @escaping(_ : NewAddBulidingModel) -> Void) {
        HUD.show(.progress, onView: view)
        
        let loginParams : [String: String] = [
            "requestId": SingleTon.shared.reqesedtUserId ?? "",
            "name" : Name,
          
        ]
    
        print(loginParams)
        
        baseRequestApi(ApiUrl.AddSectionBuliding, .post, loginParams) { (result: NewAddBulidingModel?) in
            print(result!)
            completion(result!)
        }
    }
    
    
    
    func addRequestSystemApi(_ view: UIView, billTo: String , assignDate: String , assignTime: String , inspectionType: String , notes: String , completion: @escaping(_ : NewAddBulidingModel) -> Void) {
        HUD.show(.progress, onView: view)
        
        let loginParams : [String: String] = [
            "sessionToken": SingleTon.shared.userToken,
            "organizationId" : SingleTon.shared.organizationsIds,
            "addressId" : SingleTon.shared.addressId,
            "buildingId" : SingleTon.shared.buildingId,
            "billTo" : billTo,
            "assignDate" : assignDate,
            "assignTime" : assignTime,
            "inspectionType" : inspectionType,
            "notes" : notes,
          
        ]
        
        print(loginParams)
        
        baseRequestApi(ApiUrl.addRequestSystem, .post, loginParams) { (result: NewAddBulidingModel?) in
            print(result!)
            completion(result!)
        }
    }
    
    
    func AddNewSystemIdApi(_ view: UIView, systemId: String, systemDescription: String, assignedQuestion: String , completion: @escaping(_ : NewAddBulidingModel) -> Void) {
        HUD.show(.progress, onView: view)
        
        let loginParams : [String: String] = [
            "systemId": systemId,
            "systemDescription": systemDescription,
            "assignedQuestion": assignedQuestion,
            "addressId": SingleTon.shared.buildingId,
          
        ]
    
        print(loginParams)
        
        baseRequestApi(ApiUrl.AddNewSystem, .post, loginParams) { (result: NewAddBulidingModel?) in
            print(result!)
            completion(result!)
        }
    }
    
    
    func AddSectionSystemIdApi(_ view: UIView, systemId: String, systemDescription: String, assignedQuestion: String , completion: @escaping(_ : NewAddBulidingModel) -> Void) {
        HUD.show(.progress, onView: view)
        
        let loginParams : [String: String] = [
            "systemId": systemId,
            "systemDescription": systemDescription,
            "assignedQuestion": assignedQuestion,
            "requestId":  SingleTon.shared.reqesedtUserId ?? "",
          
        ]
    
        print(loginParams)
        
        baseRequestApi(ApiUrl.AddSectionSystemId, .post, loginParams) { (result: NewAddBulidingModel?) in
            print(result!)
            completion(result!)
        }
    }
    
    
    func Changepassword(_ view: UIView, password: String, completion: @escaping(_ : ResetPassword) -> Void) {
        HUD.show(.progress, onView: view)
        
        let loginParams : [String: String] = [
           "password" : password,
           "sessionToken" : SingleTon.shared.userToken,
        ]
        
        print(loginParams)
        
        baseRequestApi(ApiUrl.resetPassRequestsUrl, .post, loginParams) { (result: ResetPassword?) in
            print(result!)
            completion(result!)
        }
    }
    
    
    
    
    
    // MARK: -- Logout Api
    func logoutApi(_ view: UIView, completion: @escaping(_ : LogoutModel) -> Void) {
        HUD.show(.progress, onView: view)
        
        let params : [String: String] = [
            "sessionToken" : SingleTon.shared.userToken
        ]
        
        baseRequestApi(ApiUrl.LogoutUrl, .post, params, nil) { (result: LogoutModel?) in
            print(result!)
            completion(result!)
        }
    }
    
    // MARK: - Requests Api With selected Date
    func requestApi(_ view: UIView, selectedDate: String, completion: @escaping(_ : RequestModel) -> Void) {
        HUD.show(.progress, onView: view)
        
        let params = [
            "filterByDate" : selectedDate,
            "sessionToken": SingleTon.shared.userToken
        ]
        
        baseRequestApi(ApiUrl.RequestUrl, .post, params) { (result: RequestModel?) in
            print(result!)
            completion(result!)
        }
    }
    
    
    // MARK: - All Requests Api
    func allRequestsApi(_ view: UIView, completion: @escaping(_ : RequestModel) -> Void) {
        HUD.show(.progress, onView: view)
        let params = [
            "sessionToken": SingleTon.shared.userToken,
        ]
        
        baseRequestApi(ApiUrl.RequestUrl, .post, params) { (result: RequestModel?) in
            print(result!)
            completion(result!)
        }
    }
    
    
    func allRequestsApis(_ view: UIView, date: String, completion: @escaping(_ : RequesURlModel) -> Void) {
        HUD.show(.progress, onView: view)
        let params = [
            "sessionToken": SingleTon.shared.userToken,
            "filterByDate": date,
            
        ]
        print(params)
        baseRequestApi(ApiUrl.RequestUrls, .post, params) { (result: RequesURlModel?) in
            print(result!)
            completion(result!)
        }
    }

   //onRoute
    
    func updateRouteApis(_ view: UIView,  completion: @escaping(_ : OnRouteModel) -> Void) {
        HUD.show(.progress, onView: view)
        let params = [
            "sessionToken": SingleTon.shared.userToken,
            "requestId": SectionDataHandler.shared.selectedReportId,
            
        ]
        print(params)
        baseRequestApi(ApiUrl.OnRoute, .post, params) { (result: OnRouteModel?) in
            print(result!)
            completion(result!)
        }
    }
    
  //   MARK: - Upload Image
//    func uploadImageApi(_ view: UIView, _ image: [String], completion: @escaping(_ : ImageUploadAPIModel) -> Void) {
//        let params = [
//            "image": image,
//        ]
//        
//        baseRequestApi("http://poseidon-fire.com/api/inspector/uploadImage", .post, params) { (result: ImageUploadAPIModel?) in
//          
//            completion(result!)
//        }
//    }
    
    //*************
//    func uploadImageApi(_ view: UIView, _ images: [[String: Any]], completion: @escaping (_ : ImageUploadAPIModel?) -> Void) {
//        // Constructing parameters for API request
//        let params = [
//            "image": images
//            
//        ]
//        print("image-------->",  params)
//        
//        baseRequestApi1("https://247.poseidons.io/api/inspector/uploadImage", .post, [params]) { (result: ImageUploadAPIModel?) in
//            completion(result)
//        }
//    }
//  
    // MARK: - Upload Image
    func uploadImageApi(_ view: UIView, _ image: String, completion: @escaping(_ : ImageUploadAPIModel) -> Void) {
        let params = [
            "image": image,
        ]
        
        baseRequestApi("https://247.poseidons.io/api/inspector/uploadImage", .post, params) { (result: ImageUploadAPIModel?) in
            print(result!)
            completion(result!)
        }
    }
    
////     new update
//    
//    func uploadImageApi(_ view: UIView, _ images: [UIImage], completion: @escaping (_ result: ImageUploadAPIModel?) -> Void) {
//        let boundary = UUID().uuidString
//        var urlRequest = URLRequest(url: URL(string: "http://poseidon-fire.com/api/inspector/uploadImage")!)
//        urlRequest.httpMethod = "POST"
//        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//        
//        var data = Data()
//        for (index, image) in images.enumerated() {
//            data.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
//            let fileName = "\(index)" + ".jpg"
//            data.append("Content-Disposition: form-data; name=\"image\(index)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
//            data.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
//            data.append(image.jpegData(compressionQuality: 0.5)!)
//            data.append("\r\n--\(boundary)--".data(using: .utf8)!)
//        }
//        
//        let session = URLSession.shared
//        session.uploadTask(with: urlRequest, from: data, completionHandler: { responseData, response, error in
//            if let error = error {
//                print("Upload error: \(error.localizedDescription)")
//                completion(nil)
//            } else if let responseData = responseData {
//                do {
//                    let result = try JSONDecoder().decode(ImageUploadAPIModel.self, from: responseData)
//                    completion(result)
//                } catch {
//                    print("Decoding error: \(error.localizedDescription)")
//                    completion(nil)
//                }
//            }
//        }).resume()
//    }

    
    // MARK: - Submit PDF api
    func submitPdfApi(_ view: UIView, _ sessionToken : String!, _ customerSignStr : String!,   _ inspectorSignStr : String!,_ fireExtinguisher : String!,_ winterization : String!, _ questionJson : String!,  _ flowTestTableValues : String!,  _ graphBase64 : String!, _ timeTake: String!, _ chart1Values: String!, _ chart2Values: String!, completion: @escaping(_ : PDFSubmissionModel) -> Void) {
        //HUD.show(.progress, onView: view)
        
        // "systemLocationText": SingleTon.shared.systemLocationText,
//        let paramsDict = [
//            "sessionToken": sessionToken!,
//            "requestId": SingleTon.shared.reqesedtUserId!,
//          "customerSign": customerSignStr!,
//            "inspectorSign": inspectorSignStr!,
//            "questionJson": questionJson!,
//            "flowTestTableValues": flowTestTableValues!,
//            "graphBase64": graphBase64!,
//            "timeTake": timeTake!,
//            "winterization": winterization!,
//            "fireExtinguisher" : fireExtinguisher!,
//        ]
        
        
        let paramsDict = [
            "sessionToken": sessionToken!,
            "requestId": SingleTon.shared.reqesedtUserId!,
             "customerSign": customerSignStr!,
            "inspectorSign": inspectorSignStr!,
            "questionJson": questionJson!,
            "flowTestTableValues": flowTestTableValues!,
            "graphBase64": graphBase64!,
            "timeTake": timeTake!,
            "winterization": winterization!,
            "fireExtinguisher" : fireExtinguisher!,
            "systemLocationText": SingleTon.shared.systemLocationText,
            "chart1": chart1Values!,
            "chart2": chart2Values!,
//            "chart1Pilot": chart1PilotValues,
//            "chart2Pilot": chart2PilotValues
            
        ]
        
        print(paramsDict.keys.count)
        print(paramsDict.values)
        print(paramsDict.values)

//        var params = [String:String]()
//
//        for dict in SectionDataHandler.shared.imageDictHolder {
//            //params = paramsDict.merging(dict) { $1 }
//            //let params = paramsDict.update(other: dict)
//            params = paramsDict.merged(with: dict)
//        }
        
//
//        var mergedImageDict = [String: String]()
//
//        // Iterate through each dictionary in alltempImageDictHolder and merge into mergedImageDict
//        for imageDict in SectionDataHandler.shared.alltempImageDictHolder {
//            for (key, value) in imageDict {
//                mergedImageDict[key] = value
//            }
//        }
//
//        // Merge paramsDict with mergedImageDict
//        let params = paramsDict.merging(mergedImageDict) { (_, new) in new }

        let params = paramsDict.merged(with: SectionDataHandler.shared.tempImageDictHolder)


        print(params.keys.count)
        print(params.keys)
        print(params.values)

        //let params = paramsDict.merging(sas) { $1 }
        
        print("params check+++++++**********", params)
//        baseRequestApi("https://247.poseidons.io/api/inspector/inspectorReportClone", .post, params) { (result : PDFSubmissionModel?) in
        baseRequestApi("https://247.poseidons.io/inspector/request/createPdf", .post, params) { (result : PDFSubmissionModel?) in
            print("ResultbaseRequestApi**************", result!)
            completion(result!)
            
        }
    }
    
    
    // MARK: - Submit Request
    /*
     sessionToken,fullName,emailAddress,phoneNumber,adddressLine1,billTo,city,state,postalCode,assignDate,inspectionType,assignTime
     */
    func submitManualRequestApi(_ view: UIView,  _ fullName : String!, _ emailAddress : String!, _ phoneNumber : String!, _ adddressLine1 : String!, _ billTo : String!, _ city : String!, _ state : String!, _ postalCode : String!, _ assignDate : String!, _ assignTime : String!, _ inspectionType : String!, _ buildingName : String!,_ installationType:String!, completion: @escaping(_ : ManualRequestApiModel) -> Void) {
        HUD.show(.progress, onView: view)
        let params = [
            "sessionToken": SingleTon.shared.userToken,
            "fullName": fullName!,
            "emailAddress": emailAddress!,
            "phoneNumber": phoneNumber!,
            "adddressLine1": adddressLine1!,
            "billTo": billTo!,
            "city": city!,
            "state": state!,
            "postalCode": postalCode!,
            "assignDate": assignDate!,
            "assignTime": assignTime!,
            "inspectionType": inspectionType!,
            "buildingName": buildingName!,
            "type": installationType!
        ]
        print("params", params)
        baseRequestApi("https://247.poseidons.io/api/inspector/inspectorAddReport", .post, params) { (result : ManualRequestApiModel?) in
            print(result!)
            completion(result!)
        }
    }
    
    
    func submitManualRequestApi1(_ view: UIView,  _ fullName : String!, _ emailAddress : String!, _ phoneNumber : String!, _ adddressLine1 : String!, _ city : String!, _ state : String!, _ postalCode :                                                                                                                     String!, _ assignDate : String!, _ assignTime : String!,_ instalationType: String!, completion: @escaping(_ : ManualModel) -> Void) {
        HUD.show(.progress, onView: view)
        let params = [
            "sessionToken": SingleTon.shared.userToken,
            "propertyName": fullName!,
            "email": emailAddress!,
            "phoneNumber": phoneNumber!,
            "address": adddressLine1!,
            "city": city!,
            "state": state!,
            "postalCode": postalCode!,
            "date": assignDate!,
            "assignedTime": assignTime!,
            "type": instalationType!
        ]
        print("params here",params)
        
        baseRequestApi("https://247.poseidons.io/api/inspector/installation/addAssignedRequest", .post, params) { (result : ManualModel?) in
            print(result!)
            completion(result!)
        }
    }
    // ****
    func submitbtnApi1(_ view: UIView,  _ fullName : String!, _ emailAddress : String!, _ phoneNumber : String!, _ adddressLine1 : String!, _ city : String!, _ state : String!, _ postalCode :                                                                                                                     String!, _ assignDate : String!, _ assignTime : String!, _ InspectorType : String! , _ BillTo : String! ,  completion: @escaping(_ : ManualModel) -> Void) {
        HUD.show(.progress, onView: view)
        let params = [
            "sessionToken": SingleTon.shared.userToken,
            "propertyName": fullName!,
            "email": emailAddress!,
            "phoneNumber": phoneNumber!,
            "address": adddressLine1!,
            "city": city!,
            "state": state!,
            "postalCode": postalCode!,
            "date": assignDate!,
            "assignedTime": assignTime!,
            "InspectorType": InspectorType!,
            "BillTo": BillTo
            
            ,
        ]
        
        baseRequestApi("https://247.poseidons.io/api/inspector/installation/addAssignedRequest", .post, params) { (result : ManualModel?) in
            print(result!)
            completion(result!)
        }
    }
//CreateProject
    func CreateProjectApi(_ view: UIView,  _ projectName : String!, _ contractorName : String!, _ adddress : String!, _ city : String!, _ state : String!, _ postalCode :                                                                                                                     String!,  completion: @escaping(_ : ManualModel) -> Void) {
        HUD.show(.progress, onView: view)
        let params = [
            "sessionToken": SingleTon.shared.userToken,
            "projectName": projectName!,
            "contractorName": contractorName!,
            "address": adddress!,
            "city": city!,
            "state": state!,
            "postalCode": postalCode!,
            
        ]
        
        baseRequestApi("https://247.poseidons.io/api/inspector/installation/addAssignedRequest", .post, params) { (result : ManualModel?) in
            print(result!)
            completion(result!)
        }
    }
    
    // MARK: - All Sections
    func allSectionsApi(_ view: UIView, requestId: String, completion: @escaping(_ : SectionApiModel) -> Void) {
        HUD.show(.progress, onView: view)
//        baseRequestApi("https://247.poseidons.io/inspector/request/question?requestId=\(requestId)", .get) { (result: SectionApiModel?) in
//            print(result!)
//            completion(result!)
//        }
   // https://247.poseidons.io/inspector/request/questionclone?requestId=2004
        baseRequestApi("https://247.poseidons.io/inspector/request/questionclone?requestId=\(requestId)", .get) { (result: SectionApiModel?) in
            print(result!)
            completion(result!)
        }
    }
    
   //profileUser
    func allSectionsprofie(_ view: UIView , completion: @escaping(_ : ProfileDataModel) -> Void) {
        Indicator.sharedInstance.showIndicator()

        baseRequestApi("https://247.poseidons.io/api/inspector/userProfile?sessionToken=\(SingleTon.shared.userToken)", .get) { (result: ProfileDataModel?) in
            print(result!)
            completion(result!)
            
        }
    }
    
    func OrganizationListApi(_ view: UIView , completion: @escaping(_ : OrganizationListModel) -> Void) {
        Indicator.sharedInstance.showIndicator()

        baseRequestApi("https://247.poseidons.io/api/inspector/organizations?sessionToken=\(SingleTon.shared.userToken)", .get) { (result: OrganizationListModel?) in
            print(result!)
            completion(result!)
            
        }
    }
    
    func ViewListApi(_ view: UIView , completion: @escaping(_ : ViewbtnListModel) -> Void) {
        Indicator.sharedInstance.showIndicator()

        baseRequestApi("https://247.poseidons.io/api/inspector/userAddress?sessionToken=\(SingleTon.shared.userToken)&organizationsId=\(SingleTon.shared.organizationsIds)", .get) { (result: ViewbtnListModel?) in
            print(result!)
            completion(result!)
            
        }
    }
    
    func ViewBuildApi(_ view: UIView , completion: @escaping(_ : buildingViewModel) -> Void) {
        Indicator.sharedInstance.showIndicator()

        baseRequestApi("https://247.poseidons.io/api/inspector/building?sessionToken=\(SingleTon.shared.userToken)&addressId=\(SingleTon.shared.addressId)", .get) { (result: buildingViewModel?) in
            print(result!)
            completion(result!)
            
        }
    }
    
    func SystemManagementApi(_ view: UIView , completion: @escaping(_ : SystemManagementModel) -> Void) {
        Indicator.sharedInstance.showIndicator()

        baseRequestApi("https://247.poseidons.io/api/inspector/systemId?sessionToken=\(SingleTon.shared.userToken)&buildingId=\(SingleTon.shared.buildingId)", .get) { (result: SystemManagementModel?) in
            print(result!)
            completion(result!)
            
        }
    }
    
    //newDetailApi
     func newDetailOnRouteTime(_ view: UIView , completion: @escaping(_ : DetailOnRouteTime) -> Void) {
         Indicator.sharedInstance.showIndicator()

         baseRequestApi("https://247.poseidons.io/api/inspector/checkRoute?sessionToken=\(SingleTon.shared.userToken)&requestId=\(SectionDataHandler.shared.selectedReportId)", .get) { (result: DetailOnRouteTime?) in
             print(result!)
             completion(result!)
             
         }
     }
    
    //MARK: - Common_API_Method
    func APIMethod<T: Codable>(url : String, method : HTTPMethod, parameters : Parameters! ,completion:@escaping (_ success: T?) -> Void){
        
        print(parameters!)
        
        Indicator.sharedInstance.showIndicator()
        if Connectivity.isConnectedToInternet {
            AF.request(url, method: method, parameters:parameters) { $0.timeoutInterval = Double.infinity }.validate().responseDecodable( of: T.self) { response in
                
                print(response)
                
                if response.data != nil {
                    if let data = response.data{
                        //       print(response)
                        let myData = response
                        print(myData)
                        if response.response?.statusCode == 200 {
                            //if (response.value as? [String: Any]) != nil {
                            if (response.value) != nil {
                                print("wewewewew")
                                self.parseResponseData(data: data, completion: completion)
                            }
                        } else if response.response?.statusCode == 401 {
                            let refreshAlert = UIAlertController(title: "Alert", message: "Token Expired", preferredStyle: UIAlertController.Style.alert)
                            SingleTon.shared.userToken = ""
                            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
                                UIApplication.shared.currentWindow?.rootViewController = loginVC
                                UIApplication.shared.currentWindow?.makeKeyAndVisible()
                            }))
                            
                            UIApplication.shared.currentWindow?.rootViewController?.present(refreshAlert, animated: true, completion: nil)
                        }
                        
                    }
                } else {
                    HUD.flash(.labeledError(title: "", subtitle: "Something went wrong"), delay: 1.0)
                }
                Indicator.sharedInstance.hideIndicator()
            }
        }
        else{
            UIApplication.shared.currentWindow?.rootViewController?.showOnlyAlert("", message: "Please Check Network Connection")
            Indicator.sharedInstance.hideIndicator()
        }
    }
    
    
    
    func APIHeaderMethod<T: Codable>(url : String, method : HTTPMethod, parameters : Parameters! , headers: [String: String]? = nil, completion:@escaping (_ success: T?) -> Void){
        
        Indicator.sharedInstance.showIndicator()
        if Connectivity.isConnectedToInternet {
            AF.request(url, method: method, parameters:parameters, headers: headers?.toHeader()){ $0.timeoutInterval = 15 }.validate().responseDecodable( of: T.self) { response in
                print("response.data", response.data)
                print("uri", url)
                print("parameters", parameters)
                if response.data != nil {
                    if let data = response.data {
                        //       print(response)
                        let myData = response
                        
                        print(myData)
                        
                        if response.response?.statusCode == 200 {
                            //if (response.value as? [String: Any]) != nil {
                            if (response.value) != nil {
                                self.parseResponseData(data: response.data!, completion: completion)
                            }
                        } else if response.response?.statusCode == 401 {
                            let refreshAlert = UIAlertController(title: "Alert", message: "Token Expired", preferredStyle: UIAlertController.Style.alert)
                            SingleTon.shared.userToken = ""
                            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
                                UIApplication.shared.currentWindow?.rootViewController = loginVC
                                UIApplication.shared.currentWindow?.makeKeyAndVisible()
                            }))
                            
                            
                            UIApplication.shared.currentWindow?.rootViewController?.present(refreshAlert, animated: true, completion: nil)
                        }
                    }
                } else {
                    HUD.flash(.labeledError(title: "", subtitle: "Something went wrong"), delay: 1.0)
                }
                Indicator.sharedInstance.hideIndicator()
            }
        }
        else {
            UIApplication.shared.currentWindow?.rootViewController?.showOnlyAlert("", message: "Please Check Network Connection")
            Indicator.sharedInstance.hideIndicator()
        }
    }
    
    
    func APIHeaderMethod1<T: Codable>(url : String, method : HTTPMethod, parameters : Parameters! , headers: [String: String]? = nil, completion:@escaping (_ success: T?) -> Void){
        
     //   Indicator.sharedInstance.showIndicator()
        if Connectivity.isConnectedToInternet {
            AF.request(url, method: method, parameters:parameters, headers: headers?.toHeader()){ $0.timeoutInterval = 15 }.validate().responseDecodable( of: T.self) { response in
                
                if response.data != nil {
                    if let data = response.data {
                        //       print(response)
                        let myData = response
                        
                        print(myData)
                        if response.response?.statusCode == 200 {
                            //if (response.value as? [String: Any]) != nil {
                            if (response.value) != nil {
                                self.parseResponseData(data: response.data!, completion: completion)
                            }
                        } else if response.response?.statusCode == 401 {
                            let refreshAlert = UIAlertController(title: "Alert", message: "Token Expired", preferredStyle: UIAlertController.Style.alert)
                            SingleTon.shared.userToken = ""
                            refreshAlert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
                                let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Login_Nav")
                                UIApplication.shared.currentWindow?.rootViewController = loginVC
                                UIApplication.shared.currentWindow?.makeKeyAndVisible()
                            }))
                            
                            
                            UIApplication.shared.currentWindow?.rootViewController?.present(refreshAlert, animated: true, completion: nil)
                        }
                    }
                } else {
                    HUD.flash(.labeledError(title: "", subtitle: "Something went wrong"), delay: 1.0)
                }
           //     Indicator.sharedInstance.hideIndicator()
            }
        }
        else {
            UIApplication.shared.currentWindow?.rootViewController?.showOnlyAlert("", message: "Please Check Network Connection")
        //    Indicator.sharedInstance.hideIndicator()
        }
    }
    
    
    func parseResponseData<T: Codable>( data: Data, completion: @escaping ( _ result : T?) -> Void) {
        let a = try? JSONDecoder().decode(T.self, from: data)
        completion(a)
    }
    func uploadApi(url: String, fileparams: [String: Any],reqstIdPeram: [String: String], pdfData:Data, fileTitle:String = "inspector",finish: @escaping ((message: String, isSuccess: Bool)) -> Void) {
        //Indicator.sharedInstance.showIndicator()
        if Connectivity.isConnectedToInternet {
            var result:(message:String, isSuccess:Bool) = (message: "Fail", isSuccess : false)
            AF.upload(multipartFormData: { (multipartFormData) in
                for (key, value) in fileparams {
                    if value is Data {
                        if let imageData = pdfData as? Data{
                            multipartFormData.append(imageData, withName: key, fileName: "\(fileTitle).pdf", mimeType: "application/pdf")
                        }
                        for (key, value) in reqstIdPeram {
                            multipartFormData.append(((value).data(using: .utf8))!, withName: key)
                        }
                    }
                }
            }, to: url, usingThreshold: UInt64.init(), method: .post).response { response in
                print(response)
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
                            }
                            else {
                                result.isSuccess = false
                                result.message = msg
                            }
                        }
                        finish(result)
                    }
                    catch {
                        finish(result)
                    }
                } else {
                    do {
                        if let jsonData = response.data {
                            let parsedData = try JSONSerialization.jsonObject(with: jsonData) as! Dictionary<String, AnyObject>
                            print(parsedData)
                            
                            let status = parsedData["status"] as? Bool ?? false
                            let msg = parsedData["message"] as? String ?? ""
                            
                            if !status {
                                UIApplication.shared.currentWindow?.rootViewController?.showOnlyAlert("", message: msg)
                            }
                        }
                        finish(result)
                    }
                    catch {
                        finish(result)
                    }
                }
                Indicator.sharedInstance.hideIndicator()
            }
        }
        else{
            UIApplication.shared.currentWindow?.rootViewController?.showOnlyAlert("", message: "Please Check Network Connection")
            Indicator.sharedInstance.hideIndicator()
        }
    }
}

extension Dictionary where Key == String, Value == String {
    func toHeader() -> HTTPHeaders {
        var headers: HTTPHeaders = [:]
        for (key, value) in self {
            headers.add(name: key, value: value)
        }
        return headers
    }
}



extension Dictionary {
    mutating func update(other:Dictionary) {
        for (key,value) in other {
            self.updateValue(value, forKey:key)
        }
    }
    
    mutating func merge(with dictionary: Dictionary) {
           dictionary.forEach { updateValue($1, forKey: $0) }
       }

       func merged(with dictionary: Dictionary) -> Dictionary {
           var dict = self
           dict.merge(with: dictionary)
           return dict
       }
}
