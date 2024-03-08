//
//  Container+App.swift
//  Interview
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import InterviewData
import InterviewDomain
import Swinject

extension Container {
    func registerAppDependencies() {
        self.registerViewModelDependencies()
    }
    
    private func registerViewModelDependencies() {
        self.register(HomeViewModel.self) { resolver in
            let useCase = resolver.resolve(TrainStationUseCase.self)!
            let viewModel = HomeViewModel(useCase)
            return viewModel
        }
    }
}
