//
//  CompletedRequestModel.swift
//  Logo
//
//  Created by Mobile on 11/04/23.
//

import Foundation

// MARK: - CompletedRequestModel
struct CompletedRequestModel: Codable {
    let message: String?
    let error: CompletedRequestError
    let status: Bool?
    let data: CompletedRequestDataClass
}

// MARK: - DataClass
struct CompletedRequestDataClass: Codable {
    let completedRequest: [CompletedRequest]
}

// MARK: - CompletedRequest
struct CompletedRequest: Codable {
    let id, fullName, email, report: String
    let mobileNumber, address: String
}

// MARK: - Error
struct CompletedRequestError: Codable {
}

