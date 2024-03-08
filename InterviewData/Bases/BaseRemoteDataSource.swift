//
//  BaseRemoteDataSource.swift
//  SafaricomInterviewData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import InterviewDomain
import RxSwift

class BaseRemoteDataSource {
    private let api: APIClient
    init() {
        api = APIClient()
    }

    func apiRequest<T: Codable>(_ urlRequest: URLRequest, isSecondTryAfterAuth: Bool = false) -> Single<(T, HTTPURLResponse)> {
        return api.request(urlRequest).catch { [unowned self] error in
            Single.create(subscribe: { [unowned self] single -> Disposable in
                if let cbError = parseError(error) {
                    single(.failure(cbError))
                } else {
                    single(.failure(error))
                }
                return Disposables.create()
            })
        }
    }

    private func parseError(_ error: Error) -> SafaricomErrors? {
        return getSBError(error)
    }

    private func getSBError(_ error: Error) -> SafaricomErrors? {
        return nil
    }

    private func singleError(error: Error) -> Single<HTTPURLResponse> {
        return Single.create(subscribe: { [unowned self] single -> Disposable in
            if let cbError = parseError(error) {
                single(.failure(cbError))
            } else {
                single(.failure(error))
            }
            return Disposables.create()
        })
    }
}
