//
//  ChatSubjectsModel.swift
//  Logo
//
//  Created by MOBILE on 02/08/23.
//

import Foundation

// MARK: - ChatSubjectsModel
struct ChatSubjectsModel: Codable {
    let message: String
    let error: ChatSubjectsError
    let status: Bool
    let data: ChatSubjectsDataClass
}

// MARK: - DataClass
struct ChatSubjectsDataClass: Codable {
    let notesList: [NotesList]
}

// MARK: - NotesList
struct NotesList: Codable {
    let id, userID, subject, note: String
    let createdAt, updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case subject, note, createdAt, updatedAt
    }
}

// MARK: - Error
struct ChatSubjectsError: Codable {
}
