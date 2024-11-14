//
//  buildingViewModel.swift
//  Logo
//
//  Created by Vishal on 12/06/24.
//



import Foundation

// MARK: - Welcome
struct buildingViewModel: Codable {
    let message: String
    let error: Error
    let status: Bool
    let data: buildingDataClass
}

// MARK: - DataClass
struct buildingDataClass: Codable {
    let buildings: [Building]
}

// MARK: - Building
struct Building: Codable {
    let id, addressID, name, createdAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case addressID = "addressId"
        case name, createdAt
    }
}

// MARK: - Error
struct buildingError: Codable {
}
