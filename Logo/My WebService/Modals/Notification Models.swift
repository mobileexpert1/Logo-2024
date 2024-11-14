//
//  Notification Models.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 23/03/22.
//

import Foundation

// MARK: - Welcome
struct NotificationModel: Codable {
    let message: String
    let error: NotificationError
    let status: Bool
    let data: NotificationData
}

// MARK: - DataClass
struct NotificationData: Codable {
    let requests: [NotificatonMatirial]
    let totalPages: Int
}

// MARK: - Request
struct NotificatonMatirial: Codable {
    let id, title, description, addedOn, status: String

    enum CodingKeys: String, CodingKey {
        case id, title ,addedOn
        case description = "description"
        case status
    }
}

// MARK: - Error
struct NotificationError: Codable {
}
