//
//  ViewController.swift
//  UnitTestingAssignment
//
//  Created by Baramidze on 02.12.23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let networkManager = NetworkManager()
        let cartViewModel = CartViewModel(networkManager: networkManager)
        cartViewModel.viewDidLoad()
    }
}

