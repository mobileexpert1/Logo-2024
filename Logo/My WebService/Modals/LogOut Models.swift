//
//  LogOut Models.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 28/03/22.
//

import Foundation

import Foundation

// MARK: - Welcome
struct LogoutModel: Codable {
    let message: String
    let error: LogoutData
    let status: Bool
    let data: LogoutData
}

// MARK: - DataClass
struct LogoutData: Codable {
}
