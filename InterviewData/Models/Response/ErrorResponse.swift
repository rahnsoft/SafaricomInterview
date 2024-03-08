//
//  ErrorResponse.swift
//  InterviewData
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import Foundation

struct ErrorResponse: Decodable {
    var code: Int?
    var message: String?
    var reason: String?

    enum CodingKeys: String, CodingKey {
        case code
        case message
        case reason
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        reason = try values.decodeIfPresent(String.self, forKey: .reason)
    }
}
