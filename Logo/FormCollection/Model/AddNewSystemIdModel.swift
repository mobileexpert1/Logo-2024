//
//  AddNewSystemIdModel.swift
//  Logo
//
//  Created by Vishal on 13/06/24.
//

import Foundation
// MARK: - Welcome
struct AddNewSystemIdModel: Codable {
    let message: String
    let data, error: AddNewSystemDataClass
    let status: Bool
}

// MARK: - DataClass
struct AddNewSystemDataClass: Codable {
}
