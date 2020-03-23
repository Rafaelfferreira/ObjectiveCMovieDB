//
//  NowPlayingMoviesRouter.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 19/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// NowPlayingMovies Module Router (aka: Wireframe)
class NowPlayingMoviesRouter: NowPlayingMoviesRouterProtocol {
    func showContainer(with movies: [Movie], from view: UIViewController) {
        let showMoviesViewController = view.children.first as! ShowMoviesView
        ShowMoviesRouter.createShowMoviesModule(with: showMoviesViewController, and: movies)
        
    }
    
    func pushToMovieDetails(with movie: Movie, from view: UIViewController) {
        let movieDetailsViewController = view.storyboard?.instantiateViewController(withIdentifier: "MovieDatails") as! MovieDetailsView
        MovieDetailsRouter.createMovieDetailsModule(with: movieDetailsViewController, and: movie)
        view.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    class func createNowPlayingMoviesModule(with moviesRef: NowPlayingMoviesView, and movies: [Movie]) {
        let presenter = NowPlayingMoviesPresenter(view: moviesRef, movies: movies)
        moviesRef.presenter = presenter
        //movieDetailsRef.presenter?.view = movieDetailsRef
        //        fruitDetailRef.presenter?.wireframe = FruitDetailWireFrame()
    }
}
