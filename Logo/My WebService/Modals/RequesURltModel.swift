//
//  RequesURltModel.swift
//  Logo
//
//  Created by Vishal on 25/04/24.
//

import Foundation
struct RequesURlModel: Codable {
    let message: String
    let error: Error
    let status: Bool
    let data: requestDataClass
}

// MARK: - DataClass
struct requestDataClass: Codable {
    let requests: [Requestdata]
    let inspectorName: String
}

// MARK: - Request
struct Requestdata: Codable {
    let assignedDate: String
    let data: [Datum]
}

// MARK: - Datum
struct Datum: Codable {
    let id, organizationID : String
    let buildingNo: String
    let userID, fullName, email, report: String
    let mobileNumber, streetNumber, addressLine1, addressLine2: String
    let city, state, postalCode, message: String
    let assignTo, status, type, remind: String
    let inspectionType: String
    let timeTake, addedOn, assignedDate, assignedTime: String
    let addedOnTimeStamp, modifiedOn, questionJSON, inspectorInspectionStatus: String
    let notifyOneYear, billedStatus: String
    let notes: String
    let winterization, fireExtinguisher, commentsStatus, organizationName: String
    let profileImage: String
    let userName: String
    let userEmail: String
    let userGender: String
    let userMobileNumber: String
    let userAddressLine1: String
    let userStreetNumber: String
    let userAddressLine2: String
    let userCity: String
    let userState: String
    let userPostalCode: String

    enum CodingKeys: String, CodingKey {
        case id
        case organizationID = "organizationId"
        case buildingNo
        case userID = "userId"
        case fullName, email, report, mobileNumber, streetNumber, addressLine1, addressLine2, city, state, postalCode, message, assignTo, status, type, remind, inspectionType, timeTake, addedOn, assignedDate, assignedTime, addedOnTimeStamp, modifiedOn
        case questionJSON = "questionJson"
        case inspectorInspectionStatus, notifyOneYear, billedStatus, notes, winterization, fireExtinguisher, commentsStatus, organizationName, profileImage, userName, userEmail, userGender, userMobileNumber, userAddressLine1, userStreetNumber, userAddressLine2, userCity, userState, userPostalCode 
    }
}





