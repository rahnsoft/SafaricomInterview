//
//  Container+Data.swift
//  InterviewData
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import InterviewDomain
import Foundation
import Swinject
public extension Container {
    func registerDataDependencies() {
        self.registerRepositories()
    }

    // MARK: Repository DI

    func registerRepositories() {
        self.register(TrainStationRepository.self) { _ in
            TrainStationRepository()
        }
    }
}
