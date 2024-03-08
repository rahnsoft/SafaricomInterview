//
//  TrainStationUseCase.swift
//  InterviewDomain
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import RxSwift

public class TrainStationUseCase: TrainStationRepositoryProtocol {
    private let trainStationRespository: TrainStationRepositoryProtocol
    
    public init(_ trainStationRespository: TrainStationRepositoryProtocol) {
        self.trainStationRespository = trainStationRespository
    }
    
    public func getTrainStations() -> Single<[TrainStations]> {
        return trainStationRespository.getTrainStations()
    }
    
    public func getTrainStationBookings() -> Single<[TrainBookings]> {
        return trainStationRespository.getTrainStationBookings()
    }
}
