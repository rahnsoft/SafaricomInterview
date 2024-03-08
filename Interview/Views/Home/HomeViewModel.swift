//
//  HomeViewModel.swift
//  Interview
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import InterviewDomain
import RxSwift

class HomeViewModel: BaseViewModel {
    private let getTrainStationsUseCase: TrainStationUseCase
    private var coordinator: HomeCoordinator?

    init(_ getTrainStationsUseCase: TrainStationUseCase) {
        self.getTrainStationsUseCase = getTrainStationsUseCase
    }
    
    func setCoordinator(_ coordinator: HomeCoordinator) {
        self.coordinator = coordinator
    }

    
    func getTrainStationsData() {
        Observable.zip(getTrainStationsUseCase.getTrainStations().asObservable(), getTrainStationsUseCase.getTrainStationBookings().asObservable())
            .subscribe(onNext: { [weak self] stations, bookings in
                self?.getStationData(bookings: bookings, stations: stations)
            })
            .disposed(by: disposeBag)
    }
    
    func getStationData(bookings: [TrainBookings], stations: [TrainStations]) {
        var occupancy = Array(repeating: 0, count: stations.count)
        var passengerByStation: [Int: [String]] = [:]

        for booking in bookings {
            occupancy[booking.startStation] += 1
            if booking.startStation != booking.exitStation {
                for i in (booking.startStation + 1) ... booking.exitStation {
                    occupancy[i] += 1
                }
            }
            if passengerByStation[booking.startStation] == nil {
                passengerByStation[booking.startStation] = [booking.passengerName]
            } else {
                passengerByStation[booking.startStation]?.append(booking.passengerName)
            }
        }

        DispatchQueue.main.async {
            self.displayData(occupancy: occupancy, stations: stations, passengerByStation: passengerByStation)
        }
    }

    func displayData(occupancy: [Int], stations: [TrainStations], passengerByStation: [Int: [String]]) {
         for (index, station) in stations.enumerated() {
             var passengerNames = passengerByStation[index] ?? []
             passengerNames.sort()
             debugPrint("TrainStations occupancy \(occupancy) details \(station.stationName) - \(occupancy[index]) - \(passengerNames)")
         }
     }
}
