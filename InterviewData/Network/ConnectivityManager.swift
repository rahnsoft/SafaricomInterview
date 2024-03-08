//
//  ConnectivityManager.swift
//  SafaricomInterviewData
//
//  Created by Nicholas Wakaba on 15/12/2023.
//

import Reachability
import Foundation

public class ConnectivityManager {
    public static let shared = ConnectivityManager()

    public init() {}

    /// Using the reachability swift library, listens for connection changes
    /// at request time
    /// - Returns: Whether internet is available or not [true or false]
    public func isConnected() -> Bool {
        var connected: Bool = false
        do {
            if try Reachability().connection != .unavailable {
                connected = true
            }
        } catch {
            connected = false
        }
        return connected
    }
}
