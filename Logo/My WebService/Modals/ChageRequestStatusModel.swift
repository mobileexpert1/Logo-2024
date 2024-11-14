//
//  File.swift
//  Logo
//
//  Created by Mobile on 29/03/23.
//

import Foundation

// MARK: - ChageRequestStatusModel
struct ChageRequestStatusModel: Codable {
    let message: String?
    let error: ChageRequestStatusDataClass
    let status: Bool?
    let data: ChageRequestStatusDataClass
}

// MARK: - DataClass
struct ChageRequestStatusDataClass: Codable {
}
