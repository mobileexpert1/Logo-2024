//
//  ChatMessagesAddModel.swift
//  Logo
//
//  Created by MOBILE on 02/08/23.
//

import Foundation

// MARK: - ChatMessagesAddModel
struct ChatMessagesAddModel: Codable {
    let message: String
    let error: ChatMessagesAddDataClass
    let status: Bool
    let data: ChatMessagesAddDataClass
}

// MARK: - DataClass
struct ChatMessagesAddDataClass: Codable {
}
