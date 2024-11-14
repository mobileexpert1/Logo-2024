//
//  SingleTon Class.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 28/03/22.
//

import UIKit
import CoreLocation

class SingleTon{
    static let shared = SingleTon()
    var menualReportDetail:MenualReportModel?
    var isMakeMenualReport = false
    var inspectReportType:InspectTypeEnum?
    
    
    var tokenValue = "aa123"
    var LoginId = "IsLogin"
    var fcmTokenKey = "fcmTokenKey"
    var userTokenKey = "userTokenKey"
   // var userTokenKey = "JWtr6nz75s"
    var inspectorNameKey = "inspectorNameKey"
    var reqesedtUserId: String?
    var organizationsId: String?
    var meetingId: Int?
    
    var tokenvalue: String {
        get{ return UserDefaults.standard.string(forKey: tokenValue)! }
        set{ UserDefaults.standard.set(newValue, forKey: tokenValue) }
    }
    
    var punchImage: String {
        get{ return UserDefaults.standard.string(forKey: "punchImage") ?? "" }
        set{ UserDefaults.standard.set(newValue, forKey: "punchImage") }
    }
    
    var appSelected: Bool {
        get{ return UserDefaults.standard.bool(forKey: "appSelected") }
        set{ UserDefaults.standard.set(newValue, forKey: "appSelected") }
    }
    
    var scheduleData: [String:Any] {
        get {
            return UserDefaults.standard.value(forKey: "scheduleData") as? [String:Any] ?? [:]
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "scheduleData")
        }
    }
    
    var timeSheetData: [[String:String]] {
        get {
            return UserDefaults.standard.value(forKey: "timeSheetData") as? [[String:String]] ?? [[:]]
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "timeSheetData")
        }
    }
    
    
    var isClockedIn: Bool {
        get {
            return UserDefaults.standard.value(forKey: "isClockedIn") as? Bool ?? false
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "isClockedIn")
        }
    }
    
    var isPunchedIn: Bool {
        get {
            return UserDefaults.standard.value(forKey: "isPunchedIn") as? Bool ?? false
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "isPunchedIn")
        }
    }
    
    var appId : String{
        get {
            return UserDefaults.standard.value(forKey: "appId") as? String ?? "0"
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "appId")
        }
    }
    
    
    var appProfileArr: [String] {
        get {
            return UserDefaults.standard.value(forKey: "appProfileArr") as? [String] ?? []
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "appProfileArr")
        }
    }
    
    var notificationType: Bool {
        get {
            return UserDefaults.standard.value(forKey: "notificationType") as? Bool ?? false
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "notificationType")
        }
    }
    
    var forRequest: Bool {
        get {
            return UserDefaults.standard.value(forKey: "forRequest") as? Bool ?? false
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "forRequest")
        }
    }
    
    var onRequest: Bool {
        get {
            return UserDefaults.standard.value(forKey: "onRequest") as? Bool ?? false
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "onRequest")
        }
    }
    
    
    var Lat: CLLocationDegrees {
        get {
            return UserDefaults.standard.value(forKey: "Lat") as? CLLocationDegrees ?? 0
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "Lat")
        }
    }
    
    var MyLoginID: String {
        get {
            return UserDefaults.standard.value(forKey: "MyLoginID") as? String ?? "0"
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "MyLoginID")
        }
    }
    
    var Long: CLLocationDegrees {
        get {
            return UserDefaults.standard.value(forKey: "Long") as? CLLocationDegrees ?? 0
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "Long")
        }
    }
    
    
    var punchedDate: Date {
        get {
            if #available(iOS 15, *) {
                return UserDefaults.standard.value(forKey: "PunchedDate") as? Date ?? Date.now
            } else {
                // Fallback on earlier versions
                return UserDefaults.standard.value(forKey: "PunchedDate") as? Date ?? Date()
            }
        } set {
            UserDefaults.standard.setValue(newValue, forKey: "PunchedDate")
        }
    }

    
    var inspectorName: String {
        get{ return UserDefaults.standard.string(forKey: inspectorNameKey) ?? "" }
        set{ UserDefaults.standard.set(newValue, forKey: inspectorNameKey) }
    }
    
    var clientName: String {
        get{ return UserDefaults.standard.string(forKey: "clientNameKey") ?? "" }
        set{ UserDefaults.standard.set(newValue, forKey: "clientNameKey") }
    }
    
    var fcmToken: String {
        get{ return (UserDefaults.standard.string(forKey: fcmTokenKey) ?? "") }
        set{ UserDefaults.standard.set(newValue, forKey: fcmTokenKey) }
    }
    
    var userToken: String {
        get{ return (UserDefaults.standard.string(forKey: userTokenKey) ?? "") }
        set{ UserDefaults.standard.set(newValue, forKey: userTokenKey) }
    }
    
    var requestStreetNuber: String {
        get{ return UserDefaults.standard.string(forKey: "requestStreetNuberKey") ?? "" }
        set{ UserDefaults.standard.set(newValue, forKey: "requestStreetNuberKey") }
    }
    
    var systemLocationText : String {
        get{ return UserDefaults.standard.string(forKey: "systemLocationText") ?? "" }
        set{ UserDefaults.standard.set(newValue, forKey: "systemLocationText") }
    }
    
    
    var requestAddressLine1: String {
        get{ return UserDefaults.standard.string(forKey: "requestAddressLine1Key") ?? "" }
        set{ UserDefaults.standard.set(newValue, forKey: "requestAddressLine1Key") }
    }
    
    var requestAddressLine2: String {
        get{ return UserDefaults.standard.string(forKey: "requestAddressLine2Key") ?? "" }
        set{ UserDefaults.standard.set(newValue, forKey: "requestAddressLine2Key") }
    }
    
    var requestCity: String {
        get{ return UserDefaults.standard.string(forKey: "requestCityKey") ?? "" }
        set{ UserDefaults.standard.set(newValue, forKey: "requestCityKey") }
    }
    
    var requestState: String {
        get{ return UserDefaults.standard.string(forKey: "requestStateKey") ?? "" }
        set{ UserDefaults.standard.set(newValue, forKey: "requestStateKey") }
    }
    
    var postalCode: String {
        get{ return UserDefaults.standard.string(forKey: "postalCodeKey") ?? "" }
        set{ UserDefaults.standard.set(newValue, forKey: "postalCodeKey") }
    }
    var onRoute: String {
        get{ return UserDefaults.standard.string(forKey: "onRoute") ?? "" }
        set{ UserDefaults.standard.set(newValue, forKey: "onRoute") }
    }
    
    var organizationsIds: String {
        get{ return (UserDefaults.standard.string(forKey: "organizationsId" ) ?? "") }
        set{ UserDefaults.standard.set(newValue, forKey: "organizationsId" ) }
    }
    
    
    
    
    var addressId: String {
        get{ return (UserDefaults.standard.string(forKey: "addressId" ) ?? "") }
        set{ UserDefaults.standard.set(newValue, forKey: "addressId" ) }
    }
    
    
    
    
    var buildingId: String {
        get{ return (UserDefaults.standard.string(forKey: "buildingId" ) ?? "") }
        set{ UserDefaults.standard.set(newValue, forKey: "buildingId" ) }
    }
    var typeID: Int {
        get {
            return UserDefaults.standard.integer(forKey: "typeID")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "typeID")
        }
    }
}

