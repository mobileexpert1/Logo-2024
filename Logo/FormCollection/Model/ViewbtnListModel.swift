//
//  ViewbtnListModel.swift
//  Logo
//
//  Created by Vishal on 12/06/24.
//

import Foundation

// MARK: - Welcome
struct ViewbtnListModel: Codable {
    let message: String
    let error: Error
    let status: Bool
    let data: ViewbtnListDataClass
}

// MARK: - DataClass
struct ViewbtnListDataClass: Codable {
    let address: [Address]
}

// MARK: - Address
struct Address: Codable {
    let id, addressLine, organizationsID, city: String
    let state, postalCode, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, addressLine
        case organizationsID = "organizationsId"
        case city, state, postalCode, createdAt
    }
}

// MARK: - Error
struct ViewbtnListError: Codable {
}
