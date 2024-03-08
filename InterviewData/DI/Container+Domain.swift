//
//  Container+Domain.swift
//  InterviewData
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import InterviewDomain
import Foundation
import Swinject

extension Container {
    public func registerDomainDependencies() {
        self.registerUseCases()
    }
    
    // MARK: Use Cases DI
    
    private func registerUseCases() {
        self.register(TrainStationUseCase.self) { resolver in
            let repository = resolver.resolve(TrainStationRepository.self)!
            let useCase =  TrainStationUseCase(repository)
            return useCase
        }
    }
}
