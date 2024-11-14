//
//  NewAddBulidingModel.swift
//  Logo
//
//  Created by Vishal on 13/06/24.
//


import Foundation

// MARK: - Welcome
struct NewAddBulidingModel: Codable {
    let message: String
    let data, error: NewAddBulidingDataClass
    let status: Bool
}

// MARK: - DataClass
struct NewAddBulidingDataClass: Codable {
}
