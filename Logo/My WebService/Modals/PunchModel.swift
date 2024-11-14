//
//  PunchModel.swift
//  Logo
//
//  Created by Mobile on 23/03/23.
//

import Foundation

// MARK: - PunchModel
struct PunchModel: Codable {
    let message: String?
    let error: PunchError
    let status: Bool?
    let data: PunchDataClass
}

// MARK: - DataClass
struct PunchDataClass: Codable {
    let punch: Bool?
}

// MARK: - Error
struct PunchError: Codable {
}

struct PunchDayModel: Codable {
    let message: String?
    let error: PunchDayError
    let status: Bool?
    let data: PunchDayDataClass
}

// MARK: - DataClass
struct PunchDayDataClass: Codable {
    let punch: Bool?
}

// MARK: - Error
struct PunchDayError: Codable {
}
