//
//  PdfUpload Model.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 23/03/22.
//

import Foundation

// MARK: - Welcome

    struct SendReportModel: Codable {
        let message: String
        let error: ReportError
        let status: Bool
        let data: ReportData
    }

    // MARK: - DataClass
    struct ReportData: Codable {
        let token: String
    }

    // MARK: - Error
    struct ReportError: Codable {
    }
