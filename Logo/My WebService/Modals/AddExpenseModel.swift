//
//  AddExpenseModel.swift
//  Logo
//
//  Created by Mobile on 24/05/23.
//

import Foundation
import UIKit

// MARK: - AddExpenseModel
struct AddExpenseModel: Codable {
    let message: String?
    let error: AddExpenseDataClass
    let status: Bool?
    let data: AddExpenseDataClass
}

// MARK: - DataClass
struct AddExpenseDataClass: Codable {
}


// MARK: - ScheduleModel
struct AcceptRejectScheduleModel: Codable {
    let message: String?
    let error: AcceptRejectScheduleDataClass
    let status: Bool?
    let data: AcceptRejectScheduleDataClass
}

// MARK: - DataClass
struct AcceptRejectScheduleDataClass: Codable {
}



// MARK: - ScheduleRequestModel
struct ScheduleRequestModel: Codable {
    let message: String?
    let error: ScheduleRequestError
    let status: Bool?
    let data: ScheduleRequestDataClass
}

// MARK: - DataClass
struct ScheduleRequestDataClass: Codable {
    let meetings: [ScheduleRequestMeeting]
}

// MARK: - Meeting
struct ScheduleRequestMeeting: Codable {
    let id, attachment, note, meetingDate, eventType, meetingTime: String
}

// MARK: - Error
struct ScheduleRequestError: Codable {
}


// MARK: - ScheduleModel
struct ScheduleModel: Codable {
    let message: String
    let error: ScheduleError
    let status: Bool
    let data: ScheduleDataClass
}

// MARK: - DataClass
struct ScheduleDataClass: Codable {
    let meetings: [ScheduleMeeting]
    let dates: [String]
}

// MARK: - Meeting
struct ScheduleMeeting: Codable {
    let id, eventType, meetingDate, meetingTime: String
    let note, attachment: String
}

// MARK: - Error
struct ScheduleError: Codable {
}


// MARK: - AskToAdminModel
struct AskToAdminModel: Codable {
    let message: String
    let error: AskToAdminDataClass
    let status: Bool
    let data: AskToAdminDataClass
}

// MARK: - DataClass
struct AskToAdminDataClass: Codable {
}


// MARK: - UpdateLocationModel
struct UpdateLocationModel: Codable {
    let message: String
    let error: UpdateLocationDataClass
    let status: Bool
    let data: UpdateLocationDataClass
}

// MARK: - DataClass
struct UpdateLocationDataClass: Codable {
}



enum ThemeColor {
    static let lightThemeTextColor = UIColor.black
    static let lightThemeImageTintColor = UIColor(red: 26/255, green: 50/255, blue: 120/255, alpha: 1.0)
    static let lightThemeViewBGColor = UIColor.white
    static let lightThemeCellBGColor = UIColor.white
    static let vishlightThemeCellBGColor = UIColor(red: 31/255, green: 92/255, blue: 194/255, alpha: 1.0)
   
    static let darkThemeTextColor = UIColor.white
    static let darkThemeImageTintColor = UIColor.white
    static let darkThemeViewBGColor = UIColor(red: 0/255, green: 104/255, blue: 205/255, alpha: 1.0)
    static let darkThemeCellBGColor = UIColor(red: 0/255, green: 105/255, blue: 247/255, alpha: 1.0)
    //vish
    static let lightThemeViewBGColorvw = UIColor(red: 233/255, green: 237/255, blue: 255/255, alpha: 1.0)
    static let lightThemeViewBGColorIMGVW = UIColor(red: 133/255, green: 160/255, blue: 231/255, alpha: 1.0)
    static let lightThemeViewBGColorClock = UIColor(red: 50/255, green: 81/255, blue: 160/255, alpha: 1.0)
}
