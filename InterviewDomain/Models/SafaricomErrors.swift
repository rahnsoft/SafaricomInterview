//
//  SafaricomErrors.swift
//  InterviewDomain
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import Foundation

public enum SafaricomErrors: Error {
    case genericError
    case internetError
    case timeout
    case parseData
    case fileNotFound
    case localUserNotFound
    case dataBaseError
    case apiError(code: Int, message: String, reason: String, dict: [String: Any]?)
    case retryError(message: String, retryAction: () -> Void)
    case unauthorized

    // MARK: Public

    public enum Reason: String {
        case invalidCredentials = "invalid_credentials"
        case invalidPassword = "invalid_password"
    }

    // MARK: Internal

    public func errorMessage() -> String {
        switch self {
        case .apiError(_, let message, _, _):
            return message
        case .retryError(let message, _):
            return message
        default:
            return ""
        }
    }
}
