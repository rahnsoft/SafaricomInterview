//
//  TrainStationsResponse.swift
//  InterviewData
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import InterviewDomain

public struct TrainStationsResponse: BaseDataModel, Codable {
    let id: Int
    let stationName: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case stationName
    }
    
    init(id: Int, stationName: String) {
        self.id = id
        self.stationName = stationName
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.stationName = try container.decode(String.self, forKey: .stationName)
    }
    
    public func toDomainModel() -> TrainStations {
        return TrainStations(
            id: self.id,
            stationName: self.stationName
        )
    }
}
