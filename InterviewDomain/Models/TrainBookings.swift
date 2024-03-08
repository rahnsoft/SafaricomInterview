//
//  TrainBookings.swift
//  InterviewDomain
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import Foundation
public struct TrainBookings {
    public var passengerName: String
    public var startStation: Int
    public var exitStation: Int
    
    public init(passengerName: String, startStation: Int, exitStation: Int) {
        self.passengerName = passengerName
        self.startStation = startStation
        self.exitStation = exitStation
    }
}
