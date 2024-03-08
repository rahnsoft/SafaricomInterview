//
//  TrainBookingsResponse.swift
//  InterviewData
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import InterviewDomain

public struct TrainBookingsResponse: BaseDataModel, Codable {
    let passengerName: String
    let startStation, exitStation: Int
    
    enum CodingKeys: String, CodingKey {
        case passengerName, startStation, exitStation
    }
    
    init(passengerName: String, startStation: Int, exitStation: Int) {
        self.passengerName = passengerName
        self.startStation = startStation
        self.exitStation = exitStation
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.passengerName = try container.decode(String.self, forKey: .passengerName)
        self.startStation = try container.decode(Int.self, forKey: .startStation)
        self.exitStation = try container.decode(Int.self, forKey: .exitStation)
    }
    
    func toDomainModel() -> TrainBookings {
        return TrainBookings(
            passengerName: self.passengerName,
            startStation: self.startStation,
            exitStation: self.exitStation
        )
    }
}
