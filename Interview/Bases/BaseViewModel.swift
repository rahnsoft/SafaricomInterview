//
//  BaseViewModel.swift
//  Cooperative
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import InterviewDomain
import RxCocoa
import RxSwift

// MARK: - BaseViewModel
/// Usage: BaseViewModel().handleError(error, retryAction)

class BaseViewModel: RxBaseProtocol {
    let disposeBag = DisposeBag()
    let errorRelay = PublishRelay<Error>()
    let loadingRelay = PublishRelay<Bool>()
    let successRelay = PublishRelay<Bool>()
    let showFullScreenLoading = PublishRelay<Bool>()

    // Handle error
    /// - Parameters: error, retryAction
    /// - Returns: none
    /// - Usage: handleError(error, retryAction)
    /// - Note: This method is used to handle error from the API
    
    func handleError(_ error: Error, _ retryAction: @escaping (() -> Void)) {
        switch error {
        default:
            errorRelay.accept(parseApiErrorToRetry(error, retryAction))
        }
    }

    // Handle parseApiErrorToRetry
    /// - Parameters: error, retryAction
    /// - Returns: Error
    /// - Usage: parseApiErrorToRetry(error, retryAction)
    
    private func parseApiErrorToRetry(_ error: Error, _ retryAction: @escaping (() -> Void)) -> Error {
        switch error {
        case SafaricomErrors.apiError(_, let message, _, _):
            return SafaricomErrors.retryError(message: message, retryAction: retryAction)
        default:
            return error
        }
    }

    func showErrorMessageToRetry(_ errorMessage: String, _ retryAction: @escaping (() -> Void)) {
        errorRelay.accept(SafaricomErrors.retryError(message: errorMessage, retryAction: retryAction))
    }

    func showErrorMessage(_ errorMessage: String, _ retryAction: @escaping (() -> Void)) {
        errorRelay.accept(SafaricomErrors.retryError(message: errorMessage, retryAction: retryAction))
    }

    func onViewDidLoad() {}
}
