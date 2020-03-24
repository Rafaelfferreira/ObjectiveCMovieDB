//
//  NowPlayingMoviesView.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 19/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// NowPlayingMovies Module View
class NowPlayingMoviesView: UIViewController {
    
    var presenter: NowPlayingMoviesPresenterProtocol!
    //private var object : NowPlayingMoviesEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        presenter.viewDidLoad(view: self)
    }
    
}

// MARK: - extending NowPlayingMoviesView to implement it's protocol
extension NowPlayingMoviesView: NowPlayingMoviesViewProtocol {

}


