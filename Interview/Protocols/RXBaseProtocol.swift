//
//  RXBaseProtocol.swift
//  Interview
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import RxSwift

// MARK: - RXBaseProtocol
/// Usage: disposeBag

protocol RxBaseProtocol {
    var disposeBag: DisposeBag { get }
}
