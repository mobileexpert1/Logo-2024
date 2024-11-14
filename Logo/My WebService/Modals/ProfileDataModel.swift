//
//  ProfileDataModel.swift
//  Logo
//
//  Created by Vishal on 16/05/24.
//

//import Foundation
//
//// MARK: - Welcome
//struct ProfileDataModel: Codable {
//    let message: String
//    let error: Error
//    let status: Bool
//    let data: DataClasses
//}
//
//// MARK: - DataClass
//struct DataClasses: Codable {
//    let userData: UserData
//}
//
//// MARK: - UserData
//struct UserData: Codable {
//    let id, uniqueToken, sessionToken, userName: String
//    let email, gender, password, mobileNumber: String
//    let profileImage, address, streetNumber, addressLine1: String
//    let addressLine2, city, state, postalCode: String
//    let longitude, latitude, deviceToken, role: String
//    let status, hourlyPrice, noOfVacation, deleteStatus: String
//    let isSallaried, addedOn, addedOnTimeStamp, modifiedOn: String
//}
//
////// MARK: - Error
////struct Error: Codable {
////}

import Foundation

// MARK: - Welcome
struct ProfileDataModel: Codable {
    let message: String
    let error: Errors
    let status: Bool
    let data: ProfileDataClass
}

// MARK: - DataClass
struct ProfileDataClass: Codable {
    let userData: UserData
}

// MARK: - UserData
struct UserData: Codable {
    let id, uniqueToken, sessionToken, userName: String
    let email, gender, password, mobileNumber: String
    let profileImage, address, streetNumber, addressLine1: String
    let addressLine2, city, state, postalCode: String
    let longitude, latitude, deviceToken, role: String
    let status, hourlyPrice, noOfVacation, deleteStatus: String
    let isSallaried, addedOn, addedOnTimeStamp, modifiedOn: String
}

// MARK: - Error
struct Errors: Codable {
}
