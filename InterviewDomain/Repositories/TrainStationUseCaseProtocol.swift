//
//  TrainStationUseCaseProtocol.swift
//  InterviewDomain
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import RxSwift
public protocol TrainStationUseCaseProtocol {
    func getTrainStations() -> Single<[TrainStations]>
    func getTrainBookings() -> Single<[TrainBookings]>
}
