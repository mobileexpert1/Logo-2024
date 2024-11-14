//
//  OrganizationListModel.swift
//  Logo
//
//  Created by Vishal on 11/06/24.
//


import Foundation

import Foundation

// MARK: - Welcome
struct OrganizationListModel: Codable {
    let message: String
    let error: Error
    let status: Bool
    let data: OrganizationDataClass
}

// MARK: - DataClass
struct OrganizationDataClass: Codable {
    let organizations: [Organization]
}

// MARK: - Organization
struct Organization: Codable {
    let id, name, address, requestName: String
    let requestEmail, requestPhoneNumber, image, createdAt: String
    let updatedAt: String
}

// MARK: - Error
struct OrganizationError: Codable {
}

