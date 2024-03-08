//
//  URLRequest+Data.swift
//  InterviewData
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import Foundation

extension URLRequest {
    private static let baseUrl = "http://localhost:8088/api"

    init(_ endpoint: APIEndpoint, _ method: APIMethod, _ parameters: [String: Any?]? = nil, customHeaders: [String: String] = [:], _ urlArgs: CVarArg...) {
        let path = String(format: endpoint.rawValue, arguments: urlArgs)
        let urlString = URLRequest.urlResolver(for: endpoint, path: path)
        let url = URL(string: urlString)!
        self.init(url: url)
        httpMethod = method.rawValue
        processParameters(method, parameters)
        for (key, value) in customHeaders {
            addValue(value, forHTTPHeaderField: key)
        }

        timeoutInterval = 100
    }

    private static func urlResolver(for endPoint: APIEndpoint, path: String) -> String {
        switch endPoint {
        default:
            return "\(URLRequest.baseUrl)/\(path)"
        }
    }

    private mutating func processParameters(_ method: APIMethod, _ parameters: [String: Any?]? = nil) {
        switch method {
        case .get:
            processGetParameters(parameters)
        default:
            processPostParameters(parameters)
        }
    }

    private mutating func processPostParameters(_ parameters: [String: Any?]? = nil) {
        if let parameters = parameters, let jsonParameters = try? JSONSerialization.data(withJSONObject: parameters,
                                                                                         options: [])
        {
            httpBody = jsonParameters
        }
    }

    private mutating func processGetParameters(_ parameters: [String: Any?]? = nil) {
        guard let parameters = parameters, !parameters.isEmpty else { return }
        let queryParameters = parameters.reduce("?") { result, element -> String in
            guard let value = element.value else { return result }
            guard value as? String != "" else { return result }
            if result.count > 1 {
                return "\(result)&\(element.key)=\(value)"
            }
            return "\(result)\(element.key)=\(value)"
        }
        var queryCharSet = NSCharacterSet.urlQueryAllowed
        queryCharSet.remove(charactersIn: "+")
        if let url = url?.absoluteString,
           let urlQueryParameters = queryParameters.addingPercentEncoding(withAllowedCharacters: queryCharSet)
        {
            let urlWithParameters = "\(url)\(urlQueryParameters)"
            self.url = URL(string: urlWithParameters)!
        }
    }
}
