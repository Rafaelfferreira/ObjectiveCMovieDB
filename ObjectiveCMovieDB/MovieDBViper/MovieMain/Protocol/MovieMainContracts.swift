//
//  MovieMainContracts.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 14/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

//MARK: View -
/*
 Should replace "class" with "BaseViewProtocol" if available;
 & that will allow the View to act as a UIViewController;
 & Implement common view functions.
 */
/// MovieMain Module View Protocol
protocol MovieMainViewProtocol: BaseViewProtocol {
    // Update UI with value returned.
    /// Set the view Object of Type Movie
    func set(popularMovies: [Movie])
    
    func set(nowPlayingMovies: [Movie])
    
    func getNowPlayingMovies() -> [Movie]?
    
    func set(numberOfSections: Int)
    
    func loadData()
    
    func notConnected()
    
    func error()
}

//MARK: Interactor -
/// MovieMain Module Interactor Protocol
protocol MovieMainInteractorProtocol {
    // Fetch Object from Data Layer
    func getPopularMovies(presenter: MovieMainPresenterProtocol)
    
    func getNowPlayingMovies(presenter: MovieMainPresenterProtocol)
    
//    func isConnectedToNetwork() -> Bool
}

//MARK: Presenter -
/// MovieMain Module Presenter Protocol
protocol MovieMainPresenterProtocol {
    func viewDidLoad()
    
    func loadMovieLists()

    func popularMoviesDidFetch(popularMovies: [Movie]?, error: Error?)
    
    func nowPlayingMoviesDidFetch(nowPlayingMovies: [Movie]?, error: Error?)
    
    func showMovieDetails(with movie: Movie, from view: UIViewController)
    
    func showAll(nowPlayingMovies: [Movie], from view: UIViewController)
    
    func searchMovies(_ text: String, view: UIViewController)
}

//MARK: Router (aka: Wireframe) -
/// MovieMain Module Router Protocol
protocol MovieMainRouterProtocol {
    // Show Details of Entity Object coming from ParentView Controller.
    // func showDetailsFor(object: Movie, parentViewController viewController: UIViewController)
    func pushToMovieDetails(with movie: Movie, from view: UIViewController)
    
    func pushToAllNowPlayingMovies(with movies: [Movie], from view: UIViewController)
    
    func showContainer(with text: String, from view: UIViewController)
}
