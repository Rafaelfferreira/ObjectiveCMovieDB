//
//  ViewController.swift
//  SwiftObjectiveCIntegration
//
//  Created by Rafael Ferreira on 25/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        var networkHandler = NetworkHandler()
        networkHandler.getPopularMovies()
    }
}

