//
//  ApplicationCoordinator.swift
//  Interview
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import InterviewDependencyInjection
import InterviewDomain
import RxSwift

class ApplicationCoordinator {
    private let window: UIWindow?
    private let disposeBag = DisposeBag()

    required init(_ window: UIWindow?) {
        self.window = window
    }

    func start() {
        guard let window = window else {
            return
        }
        HomeCoordinator(window).start()
    }
}
