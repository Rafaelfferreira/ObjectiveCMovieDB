//
//  MovieMainRouter.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 14/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// MovieMain Module Router (aka: Wireframe)
class MovieMainRouter: MovieMainRouterProtocol {
    func showContainer(with text: String, from view: UIViewController) {
//        view.definesPresentationContext = false
        let showMoviesViewController = view.children.first as! ShowMoviesView
        ShowMoviesRouter.createShowMoviesModule(with: showMoviesViewController, and: text)
        
    }
    
    func pushToMovieDetails(with movie: Movie, from view: UIViewController) {
        let movieDetailsViewController = view.storyboard?.instantiateViewController(withIdentifier: "MovieDatails") as! MovieDetailsView
        MovieDetailsRouter.createMovieDetailsModule(with: movieDetailsViewController, and: movie)
        view.navigationItem.searchController?.isActive = false
        view.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    func pushToAllNowPlayingMovies(with movies: [Movie], from view: UIViewController) {
        let nowPlayingViewController = view.storyboard?.instantiateViewController(withIdentifier: "Now Playing") as! NowPlayingMoviesView
        NowPlayingMoviesRouter.createNowPlayingMoviesModule(with: nowPlayingViewController, and: movies)
        view.navigationController?.pushViewController(nowPlayingViewController, animated: true)
    }
}
