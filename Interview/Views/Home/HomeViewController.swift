//
//  ViewController.swift
//  Interview
//
//  Created by Nicholas Wakaba on 08/03/2024.
//

import UIKit

class HomeViewController: BaseViewController {
    private var viewModel: HomeViewModel
    
    init(_ viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: ControllerIds.homeVCIdentifier.rawValue, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        // Do any additional setup after loading the view.
        viewModel.getTrainStationsData()
    }
}

