//
//  TrainStationRepository.swift
//  InterviewData
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import RxSwift
import InterviewDomain

// MARK: - TrainStationRepository
/// Usage: TrainStationRepository
/// - Note: This is a repository for the TrainStation
public class TrainStationRepository: TrainStationRepositoryProtocol {
    private lazy var trainStationRemoteDataSource = TrainRemoteDataSource()
    
    public init() {}

   public func getTrainStations() -> Single<[TrainStations]> {
        return trainStationRemoteDataSource.getTrainStations()
    }
    
    public func getTrainStationBookings() -> Single<[TrainBookings]> {
        return trainStationRemoteDataSource.getTrainBookings()
    }
}
