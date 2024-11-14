//
//  Urlession.swift
//  Logo
//
//  Created by MAC SOLUTIONSS on 16/03/22.
//

import Foundation
import UIKit
//--- privateUrl
//-----   http://dev74.csdevhub.com/poseidon/api/inspector/

//---- publicUrl
// ------ http://poseidon-fire.com/api/inspector/
//vish
//let baseUrl = "http://poseidon-fire.com/api/inspector/"
let baseUrl = "https://247.poseidons.io/api/inspector/"

struct ApiUrl {
    static let ProfileImgBase = "https://247.poseidons.io/public/uploads/"
    static let LogInUrl = baseUrl + "login"
    static let RequestUrl =  baseUrl + "dashboard"
    static let RequestUrls =  baseUrl + "dashboardInspection"
    static let NotificationUrl =  baseUrl + "notifications"
    static let LogoutUrl = baseUrl + "logout"
    static let SendReportUrl = baseUrl + "inspectorReport"
    static let MenualAddReport = baseUrl + "inspectorAddReport"
    static let PunchUrl = baseUrl + "clockIn"
    static let PunchDayUrl = baseUrl + "dayClockIn"
    static let ClockInListUrl = baseUrl + "clockInList"
    static let DashboardDataUrl = baseUrl + "homepage"
    static let ApplyLeavesUrl = baseUrl + "applyLeave"
    static let LeavesUrl = baseUrl + "leaves"
    static let AddExpensesUrl = baseUrl + "addExpense"
    static let AcceptRejectScheduleUrl = baseUrl + "respondMeetingReqest"
    static let CreateProjectUrl = baseUrl + "createProject"
    static let ScheduleRequestsUrl = baseUrl + "pendingRequest"
    static let ScheduleUrl = baseUrl + "schedules"
    static let MeetingsPdfUrl = baseUrl + "safetyMeeting"
    static let AskToAdminUrl = baseUrl + "feedback"
    static let UpdateLocationUrl = baseUrl + "updateLocation"
    static let TimeSheetSubmitUrl = baseUrl + "weekTimeSheet"
    static let safetySignSubmitUrl = baseUrl + "meetingUpdate"
    static let getInstallationListUrl = baseUrl + "installation/assignedRequest"
    static let getInstallationPdfUrl = baseUrl + "installation/viewPdf"
    static let chatSubjectsUrl = baseUrl + "chat/notes"
    static let chatMessagesUrl = baseUrl + "chat/messages"
    static let chatMessagesAddUrl = baseUrl + "chat/messages/add"
    static let emergencyRequestsUrl = baseUrl + "emergency/request"
    static let deleteEmergencyRequestsUrl = baseUrl + "emergency/delete"
   // static let ProfileRequestsUrl = baseUrl + "userProfile"
    static let resetPassRequestsUrl = baseUrl + "resetPassword"
    static let OnRoute =  baseUrl + "onRoute"
    static let AddAddress =  baseUrl + "addAddress"
    static let addBuilding =  baseUrl + "addBuilding"
    static let AddNewSystem =  baseUrl + "addSystemManagement"
    static let addRequestSystem =  baseUrl + "addRequestSystem"
    static let AddSectionSystemId =  baseUrl + "addSystemFromReport"
    static let  AddSectionBuliding =  baseUrl + "addBuildingToRequest"
   
 // static let CompltedReqListUrl = baseUrl + "completedRequest?sessionToken="
    static let CompltedReqListUrl = "https://247.poseidons.io/api/inspector/completedRequest"
    static let ChageRequestStatusUrl = baseUrl + "chageRequestStatus"
    static let pdfBaseUrl = "https://247.poseidons.io/public/uploads/"
}

//          let url = "http://dev74.csdevhub.com/poseidon/api/inspector/inspectorRequests?pageNumber=\(pageNumber)&limit=\(limit)"
