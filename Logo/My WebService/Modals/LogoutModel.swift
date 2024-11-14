//
//  LogoutModel.swift
//  Logo
//
//  Created by Mobile on 23/03/23.
//

import Foundation

// MARK: - LogoutModel
struct LoggoutModel: Codable {
    let message: String?
    let error: LoggoutDataClass
    let status: Bool?
    let data: LoggoutDataClass
}

// MARK: - DataClass
struct LoggoutDataClass: Codable {
}
