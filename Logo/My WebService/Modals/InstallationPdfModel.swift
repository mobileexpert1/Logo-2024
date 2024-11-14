//
//  InstallationPdfModel.swift
//  Logo
//
//  Created by MOBILE on 31/07/23.
//

import Foundation

// MARK: - GetInstallationPDFModel
struct GetInstallationPDFModel: Codable {
    let message: String
    let error: InstallationPDFError
    let status: Bool
    let data: InstallationPDFDataClass
}

// MARK: - InstallationPDFDataClass
struct InstallationPDFDataClass: Codable {
    let link: String
}

// MARK: - Error
struct InstallationPDFError: Codable {
}
