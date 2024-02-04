//
//  TestGetResponse.swift
//  BagzzDemoApp
//
//  Created by Gopu on 06/02/24.
//

import Foundation
// MARK: - GetTestResponseElement
struct GetTestResponseElement: Codable {
    let id: Int
    let column1: String

    enum CodingKeys: String, CodingKey {
        case id
        case column1 = "Column 1"
    }
}

typealias GetTestResponse = [GetTestResponseElement]
