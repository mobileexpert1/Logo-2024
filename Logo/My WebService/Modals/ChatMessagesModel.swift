//
//  ChatMessagesModel.swift
//  Logo
//
//  Created by MOBILE on 02/08/23.
//

import Foundation

// MARK: - ChatMessagesModel
struct ChatMessagesModel: Codable {
    let message: String
    let error: ChatMessagesError
    let status: Bool
    let data: ChatMessagesDataClass
}

// MARK: - DataClass
struct ChatMessagesDataClass: Codable {
    let messages: [Message]
}

// MARK: - Message
struct Message: Codable {
    let id, userID, userNoteID, text: String
    let addedOn, addedOnTimeStamp: String

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "userId"
        case userNoteID = "userNoteId"
        case text, addedOn, addedOnTimeStamp
    }
}

// MARK: - Error
struct ChatMessagesError: Codable {
}
