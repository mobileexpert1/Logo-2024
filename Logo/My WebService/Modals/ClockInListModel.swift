//
//  ClockInListModel.swift
//  Logo
//
//  Created by Mobile on 25/03/23.
//

import Foundation

// MARK: - ClockInListModel
    struct ClockInListModel: Codable {
        let message: String?
        let error: ClockInListError
        let status: Bool?
        let data: ClockInListDataClass
    }

struct ClockInListDataClass: Codable {
    let projects: [ClockInListData]
    let projectColockIn: ProjectColockIn
}

// MARK: - Datum
struct ProjectColockIn: Codable {
    let projectId,timeDifferece: Int
}
    
    // MARK: - Datum
    struct ClockInListData: Codable {
        let id, fullName, email, mobileNumber: String
        let address, distance: String
        let clockedInStatus: Int
    }


    
    // MARK: - Error
    struct ClockInListError: Codable {
    }

