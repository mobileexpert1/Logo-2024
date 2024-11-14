//
//  Request Modals.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 21/03/22.
//


import Foundation

// MARK: - RequestModel
struct RequestModel: Codable {
    let message: String
    let error: Error
    let status: Bool
    let data: DataClass
}

// MARK: - DataClass
struct DataClass: Codable {
    let requests: [Request]
    let inspectorName: String
}

// MARK: - Request
struct Request: Codable {
    let id, organizationID, userID, fullName: String
    let email, report, mobileNumber, streetNumber: String
    let addressLine1, addressLine2, city, state: String
    let postalCode, message, assignTo, status: String
    let type, remind, inspectionType, timeTake: String
    let addedOn, assignedDate, assignedTime, addedOnTimeStamp: String
    let modifiedOn, questionJSON, inspectorInspectionStatus, notifyOneYear: String
    let billedStatus, notes, profileImage, userName: String
    let userEmail, userGender, userMobileNumber, userAddressLine1: String
    let userStreetNumber, userAddressLine2, userCity, userState: String
    let userPostalCode: String

    enum CodingKeys: String, CodingKey {
        case id
        case organizationID = "organizationId"
        case userID = "userId"
        case fullName, email, report, mobileNumber, streetNumber, addressLine1, addressLine2, city, state, postalCode, message, assignTo, status, type, remind, inspectionType, timeTake, addedOn, assignedDate, assignedTime, addedOnTimeStamp, modifiedOn
        case questionJSON = "questionJson"
        case inspectorInspectionStatus, notifyOneYear, billedStatus, notes, profileImage, userName, userEmail, userGender, userMobileNumber, userAddressLine1, userStreetNumber, userAddressLine2, userCity, userState, userPostalCode
    }
}

// MARK: - Error
struct Error: Codable {
}


/*
 // MARK: - RequestModel
 struct RequestModel: Codable {
     let message: String
     let error: Error
     let status: Bool
     let requests: [Request]?
     let inspectorName: String
 }

 // MARK: - Error
 struct Error: Codable {
 }

 // MARK: - Request
 struct Request: Codable {
     let id, userID, fullName, email: String
     let report, mobileNumber, location, streetNumber: String
     let addressLine1, addressLine2, city, state: String
     let postalCode, message, assignTo, status: String
     let type, remind, inspectionType, addedOn: String
     let assignedDate, addedOnTimeStamp, modifiedOn, profileImage: String
     let userName, userEmail, userGender, userMobileNumber: String
     let userAddressLine1, userStreetNumber, userAddressLine2, userCity: String
     let userState, userPostalCode: String

     enum CodingKeys: String, CodingKey {
         case id
         case userID = "userId"
         case fullName, email, report, mobileNumber, location, streetNumber, addressLine1, addressLine2, city, state, postalCode, message, assignTo, status, type, remind, inspectionType, addedOn, assignedDate, addedOnTimeStamp, modifiedOn, profileImage, userName, userEmail, userGender, userMobileNumber, userAddressLine1, userStreetNumber, userAddressLine2, userCity, userState, userPostalCode
     }
 }
 */



