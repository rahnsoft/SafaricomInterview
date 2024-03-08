//
//  Utils+AppDelegate.swift
//  Interview
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import Foundation
import UIKit
// MARK: - AppDelegate
/// Usage: appDelegate

var appDelegate: AppDelegate {
    get {
        return UIApplication.shared.delegate as! AppDelegate
    }
}
