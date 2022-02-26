//
//  ErrorDataModel.swift
//  ThirdwayvTask
//
//  Created by Ibrahim Mo Gedami on 24/02/2022.
//

import Foundation

// MARK: - ErrorDataModel
struct ErrorDataModel: Codable {
    let message: String?
    let data: DataClass?

    enum CodingKeys: String, CodingKey {
        case message = "Message"
        case data = "Data"
    }
}

// MARK: - DataClass
struct DataClass: Codable {}
