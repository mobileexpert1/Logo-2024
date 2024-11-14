//
//  LOgin.swift
//  LoginProject
//
//  Created by MD Razaul on 15/03/22.
//
import Foundation
// MARK: - Login



//struct LoginModel: Codable {
//    let message: String
//    let error: Error1
//    let status: Bool
//    let data: DataClas
//}
//
//// MARK: - DataClass
//struct DataClas: Codable {
//    let token: String?
//}
//
//// MARK: - Error
//struct Error1: Codable {
//}
//
//struct loginData: Codable {
//    let login: String
//    let passWrd: String
//    let token: String
//}

// MARK: - LoginModel
struct LoginModel: Codable {
    let message: String?
    let error: Error1?
    let status: Bool?
    let data: DataClas?
}

// MARK: - DataClass
struct DataClas: Codable {
    let inspectorData: InspectorData?
    let token: String?
}

// MARK: - InspectorData
struct InspectorData: Codable {
    let id, uniqueToken, sessionToken, userName: String?
    let email, gender, password, mobileNumber: String?
    let profileImage, address, streetNumber, addressLine1: String?
    let addressLine2, city, state, postalCode: String?
    let longitude, latitude, deviceToken, role: String?
    let status, deleteStatus, addedOn, addedOnTimeStamp: String?
    let modifiedOn: String?
    let isClockedIn:Int?
}

// MARK: - Error
struct Error1: Codable {
}




//==-=-=-=-=-=-=-==-



// MARK: - Welcome
//struct Welcome: Codable {
//    let message: String
//    let error: Error
//    let status: Bool
//    let data: DataClass
//}
//
//// MARK: - DataClass
//struct DataClass: Codable {
//    let inspectorData: InspectorData
//    let token: String
//}
//
//// MARK: - InspectorData
//struct InspectorData: Codable {
//    let id, uniqueToken, sessionToken, userName: String
//    let email, gender, password, mobileNumber: String
//    let profileImage, address, streetNumber, addressLine1: String
//    let addressLine2, city, state, postalCode: String
//    let longitude, latitude, deviceToken, role: String
//    let status, deleteStatus, addedOn, addedOnTimeStamp: String
//    let modifiedOn: String
//}
//
//// MARK: - Error
//struct Error: Codable {
//}
//
                                                                  


import Foundation

// MARK: - Welcome
struct ResetPassword: Codable {
    let message: String
    let error: resetDataClass
    let status: Bool
    let data: resetDataClass
}

// MARK: - DataClass
struct resetDataClass: Codable {
}
