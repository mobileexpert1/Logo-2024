//
//  CreateProjectModel.swift
//  Logo
//
//  Created by Mobile on 24/05/23.
//

import Foundation

// MARK: - CreateProjectModel
struct CreateProjectModel: Codable {
    let message: String?
    let error: CreateProjectDataClass
    let status: Bool?
    let data: CreateProjectDataClass
}

// MARK: - DataClass
struct CreateProjectDataClass: Codable {
}
