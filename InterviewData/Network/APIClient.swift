//
//  APIClient.swift
//  SafaricomInterviewData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Alamofire
import RxAlamofire
import RxSwift
import enum InterviewDomain.SafaricomErrors
#if DEBUG
import Log
import Foundation
#endif

enum DateError: String, Error {
    case invalidDate
}

public class APIClient {
    private var sessionManager: Session
#if DEBUG
    let log: Logger = Logger()
#endif

    public init() {
        sessionManager = Session()
    }

    func request<T: Decodable>(_ urlRequest: URLRequest) -> Single<(T, HTTPURLResponse)> {
        return Single.create(subscribe: { [unowned self] (observer) -> Disposable in
            if ConnectivityManager().isConnected() {
                return self.request(urlRequest, { (response, urlResponse) in
                    observer(.success((response, urlResponse)))
                }, { (error) in
                    observer(.failure(error))
                })
            } else {
                observer(.failure(SafaricomErrors.internetError))
                return Disposables.create()
            }
        })
    }

    private func request<T: Decodable>(_ urlRequest: URLRequest,
                                       _ responseHandler: @escaping (T, HTTPURLResponse) -> Void,
                                       _ errorHandler: @escaping ((_ error: SafaricomErrors) -> Void)) -> Disposable {
        let disposableResponse = sessionManager
            .rx
            .request(urlRequest: urlRequest)
            .responseJSON()
            .asSingle()
            .timeout(RxTimeInterval.seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (response) in
                guard let self = self else { return }
                guard let httpUrlResponse = response.response else {
                    return
                }
                let statusCode = httpUrlResponse.statusCode
                if 200..<300 ~= statusCode {
                    self.decodeResponse(response, responseHandler)
                } else {
                    guard let data = response.data else { return }
                    self.decode(data, statusCode: statusCode, errorHandler)
                }
            }, onFailure: { _ in
                errorHandler(.timeout)
            })
        return disposableResponse
    }

    private func request(_ urlRequest: URLRequest,
                         _ responseHandler: @escaping (HTTPURLResponse) -> Void,
                         _ errorHandler: @escaping ((_ error: SafaricomErrors) -> Void)) -> Disposable {
        let disposableResponse = sessionManager
            .rx
            .request(urlRequest: urlRequest)
            .responseData()
            .asSingle()
            .timeout(RxTimeInterval.seconds(30), scheduler: MainScheduler.instance)
            .subscribe(onSuccess: { [weak self] (httpUrlResponse, data) in
                if 200..<300 ~= httpUrlResponse.statusCode {
                    responseHandler(httpUrlResponse)
                } else {
                    guard let self = self else { return }
                    self.logError(urlRequest, response: httpUrlResponse)
                    self.decode(data, statusCode: httpUrlResponse.statusCode, errorHandler)
                }
            }, onFailure: { _ in
                errorHandler(.timeout)
            })
        return disposableResponse
    }

    private func decode(_ data: Data, statusCode: Int, _ errorHandler: ((_ error: SafaricomErrors) -> Void)) {
        do {
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            let errorResponse = try JSONDecoder().decode(ErrorResponse.self, from: data)
            errorHandler(SafaricomErrors.apiError(code: errorResponse.code ?? statusCode,
                                           message: errorResponse.message ?? "",
                                           reason: errorResponse.reason ?? "",
                                           dict: jsonObject))
        } catch {
            errorHandler(.parseData)
        }
    }
    
    private func decodeResponse<T: Decodable>(_ response: DataResponse<Any, AFError>,
                                              _ responseHandler: @escaping (T, HTTPURLResponse) -> Void) {
        if let jsonData = response.data, let httpUrlResponse = response.response {
            debugPrint("Request response  \(response.request?.urlRequest)")

            if let jsonObject = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
                debugPrint("The Json is", jsonObject)
            }
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                    let formatter = DateFormatter()
                    formatter.calendar = Calendar(identifier: .iso8601)
                    formatter.locale = Locale(identifier: "en_US_POSIX")
                    formatter.timeZone = TimeZone(secondsFromGMT: 0)
                    let container = try decoder.singleValueContainer()
                    let dateStr = try container.decode(String.self)

                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                    if let date = formatter.date(from: dateStr) {
                        return date
                    }
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
                    if let date = formatter.date(from: dateStr) {
                        return date
                    }
                    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssXXXXX"
                    if let date = formatter.date(from: dateStr) {
                        return date
                    }
                    throw DateError.invalidDate
                })
                responseHandler(try decoder.decode(T.self, from: jsonData), httpUrlResponse)
            } catch let error {
                debugPrint("Decoding error: \(error), \(T.self)")
            }
        }
    }

    func logError(_ urlRequest: URLRequest, response: HTTPURLResponse) {
#if DEBUG
        log.error(urlRequest)
        log.error(urlRequest.allHTTPHeaderFields ?? [:])
        log.error(response)
#endif
    }
}
