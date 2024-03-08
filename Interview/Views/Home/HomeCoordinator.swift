//
//  HomeCoordinator.swift
//  Interview
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import Foundation
import UIKit
import InterviewDependencyInjection

class HomeCoordinator {
    private let window: UIWindow?
    private var navigationController: UINavigationController
    private var homeViewController: HomeViewController?
    private var homeViewModel: HomeViewModel
    
    init(_ window: UIWindow?) {
        self.window = window
        self.navigationController = UINavigationController()
        homeViewModel = DependencyInjection.shared.resolve(HomeViewModel.self)
    }
    
    func start() {
        homeViewModel.setCoordinator(self)
        let homeViewController = HomeViewController(homeViewModel)
        self.homeViewController = homeViewController
        navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.navigationBar.isTranslucent = false
        navigationController.isNavigationBarHidden = false
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
