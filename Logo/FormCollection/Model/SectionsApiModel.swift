//
//  SectionsApiModel.swift
//  Logo
//
//  Created by Mobile on 21/12/22.
//


import Foundation

// MARK: - Welcome
struct SectionApiModel: Codable {
    let message: String
    var data: [SectionApiErrorDatum]
    let error: SectionApiError
    let status: Bool
}

// MARK: - Datum
struct SectionApiErrorDatum: Codable {
    var id, systemId, systemLocationText , sectionName, isInclude: String
    var questionJSON: [QuestionJSON]?
    let createdAt: String
    
    enum CodingKeys: String, CodingKey {
        case id, sectionName, isInclude , systemLocationText
        case systemId = "systemId"
        case questionJSON = "questionJson"
        case createdAt = "created_at"
    }
}

// MARK: - QuestionJSON
struct QuestionJSON: Codable {
    var question, type, values, answer : String
}

// MARK: - Error
struct SectionApiError: Codable {
}


extension Encodable {
    
    /// Converting object to postable dictionary
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let json = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return json
    }
    
    /// Converting object to postable JSON
    func toJSON(_ encoder: JSONEncoder = JSONEncoder()) throws -> NSString {
        let data = try encoder.encode(self)
        let result = String(decoding: data, as: UTF8.self)
        return NSString(string: result)
    }
}


// MARK: - PDFSubmissionModel
struct PDFSubmissionModel: Codable {
    let message: String
    let error: PDFError
    let status: Bool
    let data: PDFData
}

// MARK: - PDFData
struct PDFData: Codable {
    let pdfName: String
}

// MARK: - PDFError
struct PDFError: Codable {
}



// MARK: - Manual Request Api Model
struct ManualRequestApiModel: Codable {
    let message: String
    let error: ManualRequestApiError
    let status: Bool
    let data: ManualRequestApiData
}

// MARK: - ManualRequestApiData
struct ManualRequestApiData: Codable {
}

// MARK: - ManualRequestApiError
struct ManualRequestApiError: Codable {
}



// MARK: - ImageUploadAPIModel
struct ImageUploadAPIModel: Codable {
    let message: String
    let error: ImageUploadError
    let status: Bool
    let data: ImageUploadDataClass
}

// MARK: - DataClass
struct ImageUploadDataClass: Codable {
    let imageName: String
}

// MARK: - Error
struct ImageUploadError: Codable {
}


// MARK: - ManualModel
struct ManualModel: Codable {
    let message: String
    let error: ManualModelDataClass
    let status: Bool
    let data: ManualModelDataClass
}

// MARK: - DataClass
struct ManualModelDataClass: Codable {
}
