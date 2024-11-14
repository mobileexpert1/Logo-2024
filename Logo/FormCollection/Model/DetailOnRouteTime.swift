//
//  DetailOnRouteTime.swift
//  Logo
//
//  Created by Vishal on 30/05/24.
//



import Foundation

// MARK: - Welcome
struct DetailOnRouteTime: Codable {
    let message: String
    let error: Error
    let status: Bool
    let data: DetailDataClass
}

// MARK: - DataClass
struct DetailDataClass: Codable {
    let type: Int
}

// MARK: - Error
struct error: Codable {
}
