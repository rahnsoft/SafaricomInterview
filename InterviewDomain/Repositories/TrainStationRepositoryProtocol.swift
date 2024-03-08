//
//  TrainStationRepository.swift
//  InterviewDomain
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import RxSwift

public protocol TrainStationRepositoryProtocol {
    func getTrainStations() -> Single<[TrainStations]>
    func getTrainStationBookings() -> Single<[TrainBookings]>
}
