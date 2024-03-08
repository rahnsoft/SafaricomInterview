//
//  TrainRemoteDataSource.swift
//  InterviewData
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import InterviewDomain
import RxSwift

class TrainRemoteDataSource: BaseRemoteDataSource {
    func getTrainStations() -> Single<[TrainStations]> {
        requestTrainStations().map { trainStations, response -> [TrainStations] in
            trainStations.map { $0.toDomainModel() }
        }
    }

    func getTrainBookings() -> Single<[TrainBookings]> {
        requestTrainBookings().map { trainBookings, response -> [TrainBookings] in
            trainBookings.map { $0.toDomainModel() }
        }
    }

    func requestTrainBookings() -> Single<([TrainBookingsResponse], HTTPURLResponse)> {
        let urlRequest = URLRequest(.trainBookings, .get, nil)
        return apiRequest(urlRequest)
    }

    func requestTrainStations() -> Single<([TrainStationsResponse], HTTPURLResponse)> {
        let urlRequest = URLRequest(.trainStations, .get, nil)
        return apiRequest(urlRequest)
    }
}
