//
//  LeavesModel.swift
//  Logo
//
//  Created by Mobile on 23/05/23.
//

import Foundation

// MARK: - LeavesModel
struct LeavesModel: Codable {
    let message: String?
    let error: LeavesError
    let status: Bool?
    let data: LeavesDataClass
}

// MARK: - DataClass
struct LeavesDataClass: Codable {
    let vacationsLeaves: [String]
}

// MARK: - Error
struct LeavesError: Codable {
}


// MARK: - EmergencyRequestModel
struct EmergencyRequestModel: Codable {
    let message: String
    let error: EmergencyRequestError
    let status: Bool
    let data: EmergencyRequestDataClass
}

// MARK: - DataClass
struct EmergencyRequestDataClass: Codable {
    let emergencyRequest: [EmergencyRequest]
}

// MARK: - EmergencyRequest
struct EmergencyRequest: Codable {
    let id, userID, name, terms: String
    let orderTakenBy, orderNumber, dateOfOrder, phone: String
    let jobName, jobLocation, jobPhone, startingDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case name, terms, orderTakenBy, orderNumber, dateOfOrder, phone, jobName, jobLocation, jobPhone, startingDate
    }
}

// MARK: - Error
struct EmergencyRequestError: Codable {
}


// MARK: - DeleteEmergencyRequestModel
struct DeleteEmergencyRequestModel: Codable {
    let message: String
    let error: DeleteEmergencyRequestDataClass
    let status: Bool
    let data: DeleteEmergencyRequestDataClass
}

// MARK: - DataClass
struct DeleteEmergencyRequestDataClass: Codable {
}
