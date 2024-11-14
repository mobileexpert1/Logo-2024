//
//  AddressPopUpModel.swift
//  Logo
//
//  Created by Vishal on 13/06/24.
//

import Foundation



// MARK: - Welcome
struct AddressPopUpModel: Codable {
    let message: String
    let data, error: AddressPopDataClass
    let status: Bool
}

// MARK: - DataClass
struct AddressPopDataClass: Codable {
}
