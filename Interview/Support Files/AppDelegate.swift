//
//  AppDelegate.swift
//  Interview
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import UIKit
import InterviewDependencyInjection
import InterviewDomain
import Swinject
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = window ?? UIWindow(frame: UIScreen.main.bounds)
        guard NSClassFromString("XCTest") == nil else {
            registerTestDependencies()
            window?.rootViewController = UIViewController()
            window?.makeKeyAndVisible()
            return true
        }
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        registerDependencies() // register dependencies
        let navigationController = UINavigationController()
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        ApplicationCoordinator(getWindow()).start() // start application coordinator
        return true
    }
    
    func getWindow() -> UIWindow? {
        return window
    }

    private func registerDependencies() {
        let container = Container()
        container.registerAppDependencies()
        container.registerDataDependencies()
        container.registerDomainDependencies()
        DependencyInjection.shared.setContainer(container)
    }

    private func registerTestDependencies() {
        let container = Container()
        container.registerAppDependencies()
        DependencyInjection.shared.setContainer(container)
    }
}

