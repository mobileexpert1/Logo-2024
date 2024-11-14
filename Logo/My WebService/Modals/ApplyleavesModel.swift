//
//  LeavesModel.swift
//  Logo
//
//  Created by Mobile on 23/05/23.
//

import Foundation

// MARK: - LeavesModel
struct ApplyLeavesModel: Codable {
    let message: String?
    let error: ApplyLeavesDataClass
    let status: Bool?
    let data: ApplyLeavesDataClass
}

// MARK: - DataClass
struct ApplyLeavesDataClass: Codable {
}
