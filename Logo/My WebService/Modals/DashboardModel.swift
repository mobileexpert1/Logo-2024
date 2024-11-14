//
//  DashboardModel.swift
//  Logo
//
//  Created by Mobile on 19/05/23.
//

import Foundation

// MARK: - DashboardModel
struct DashboardModel: Codable {
    let message: String?
    let error: DashboardError
    let status: Bool?
    let data: DashboardDataClass
}

// MARK: - DataClass
struct DashboardDataClass: Codable {
    let expenseData: [ExpenseDatum]
    let punchData: Int
    let userName, profilePic: String
    let projectCount, approvedLeaveCount: Int
    let isTimesheetAdded : Bool
}

// MARK: - ExpenseDatum
struct ExpenseDatum: Codable {
    let name, id  : String
}



// MARK: - Error
struct DashboardError: Codable {
}







