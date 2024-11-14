//
//  NewOrganizationModel.swift
//  Logo
//
//  Created by Vishal on 13/06/24.
//


import Foundation

// MARK: - Welcome
struct NewOrganizationModel: Codable {
    let message: String
    let data, error: NewOrganizationDataClass
    let status: Bool
}

// MARK: - DataClass
struct NewOrganizationDataClass: Codable {
}
