//
//  ShowMoviesRouter.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 20/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// ShowMovies Module Router (aka: Wireframe)
class ShowMoviesRouter: ShowMoviesRouterProtocol {
    func pushToMovieDetails(with movie: Movie, from view: UIViewController) {
        let movieDetailsViewController = view.storyboard?.instantiateViewController(withIdentifier: "MovieDatails") as! MovieDetailsView
        MovieDetailsRouter.createMovieDetailsModule(with: movieDetailsViewController, and: movie)
        view.parent?.navigationItem.searchController?.isActive = false
        view.navigationController?.pushViewController(movieDetailsViewController, animated: true)
    }
    
    class func createShowMoviesModule(with moviesRef: ShowMoviesView, and movies: [Movie]) {
        let presenter = ShowMoviesPresenter(view: moviesRef, movies: movies)
        moviesRef.initMoviesViewAllMovies(presenter: presenter)
        //movieDetailsRef.presenter?.view = movieDetailsRef
        //        fruitDetailRef.presenter?.wireframe = FruitDetailWireFrame()
    }
    
    class func createShowMoviesModule(with moviesRef: ShowMoviesView, and text: String) {
        let presenter = ShowMoviesPresenter(view: moviesRef, text: text)
        moviesRef.initMoviesViewSearch(presenter: presenter)
        //movieDetailsRef.presenter?.view = movieDetailsRef
        //        fruitDetailRef.presenter?.wireframe = FruitDetailWireFrame()
    }
}
