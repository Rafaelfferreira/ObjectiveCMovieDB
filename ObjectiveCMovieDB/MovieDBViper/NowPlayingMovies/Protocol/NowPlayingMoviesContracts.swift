//
//  NowPlayingMoviesContracts.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 19/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

//MARK: View -
/*
 Should replace "class" with "BaseViewProtocol" if available;
 & that will allow the View to act as a UIViewController;
 & Implement common view functions.
 */
/// NowPlayingMovies Module View Protocol
protocol NowPlayingMoviesViewProtocol: class {

}

//MARK: Interactor -
/// NowPlayingMovies Module Interactor Protocol
protocol NowPlayingMoviesInteractorProtocol {
}

//MARK: Presenter -
/// NowPlayingMovies Module Presenter Protocol
protocol NowPlayingMoviesPresenterProtocol {
    func viewDidLoad(view: UIViewController)

}

//MARK: Router (aka: Wireframe) -
/// NowPlayingMovies Module Router Protocol
protocol NowPlayingMoviesRouterProtocol {
    func pushToMovieDetails(with movie: Movie, from view: UIViewController)
    
    func showContainer(with movies: [Movie], from view: UIViewController)
}
