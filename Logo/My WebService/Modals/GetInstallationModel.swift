//
//  GetInstallationModel.swift
//  Logo
//
//  Created by MOBILE on 31/07/23.
//

import Foundation

// MARK: - GetInstallationModel
struct GetInstallationModel: Codable {
    let message: String
    let error: GetInstallationError
    let status: Bool
    let data: GetInstallationDataClass
}

// MARK: - GetInstallationDataClass
struct GetInstallationDataClass: Codable {
    let assignedRequest: [AssignedRequest]
}

// MARK: - AssignedRequest
struct AssignedRequest: Codable {
    let id, propertyName, address, date: String
    let phoneNumber, email, createdAt, updatedAt: String
    let assignedTo, report, city, state: String
    let postalCode,type, assignedTime: String
  
}

// MARK: - Error
struct GetInstallationError: Codable {
}
