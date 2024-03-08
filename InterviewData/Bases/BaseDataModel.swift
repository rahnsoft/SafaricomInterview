//
//  BaseDataModel.swift
//  SafaricomInterviewData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Foundation

protocol BaseDataModel {
    associatedtype Model
    func toDomainModel() -> Model
}
