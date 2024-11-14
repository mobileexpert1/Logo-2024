//
//  SystemManagementModel.swift
//  Logo
//
//  Created by Vishal on 13/06/24.
//

import Foundation

// MARK: - Welcome
import Foundation

// MARK: - Welcome
struct SystemManagementModel: Codable {
    let message: String
    let error: Error
    let status: Bool
    let data: SystemManagementDataClass
}

// MARK: - DataClass
struct SystemManagementDataClass: Codable {
    let systemLocation: [SystemLocation]
}

// MARK: - SystemLocation
struct SystemLocation: Codable {
    let id, systemID, systemDescription, assignedQuestion: String
    let type, addressID, createdAt, sectionName: String

    enum CodingKeys: String, CodingKey {
        case id
        case systemID = "systemId"
        case systemDescription, assignedQuestion, type
        case addressID = "addressId"
        case createdAt, sectionName
    }
}

// MARK: - Error
struct SystemManagementError: Codable {
}
