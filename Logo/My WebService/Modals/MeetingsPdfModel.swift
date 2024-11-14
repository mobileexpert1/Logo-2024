//
//  MeetingsPdfModel.swift
//  Logo
//
//  Created by MOBILE on 28/07/23.
//

import Foundation

// MARK: - MeetingsPDFModel
struct MeetingsPDFModel: Codable {
    let message: String
    let data: MeetingsPDFDataClass
    let error: MeetingsPDFError
    let status: Bool
}

// MARK: - DataClass
struct MeetingsPDFDataClass: Codable {
    let safety: [Safety]
}

// MARK: - Safety
struct Safety: Codable {
    let id, name, attachment, createdAt: String
    let updatedAt, signature: String
}

// MARK: - Error
struct MeetingsPDFError: Codable {
}
