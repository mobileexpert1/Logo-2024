//
//  OnRouteModel.swift
//  Logo
//
//  Created by Vishal on 29/05/24.
//

import Foundation

// MARK: - Welcome
struct OnRouteModel: Codable {
    let message: String
    let error: OnRouteModelDataClass
    let status: Bool
    let data: OnRouteModelDataClass
}

// MARK: - DataClass
struct OnRouteModelDataClass: Codable {
}
