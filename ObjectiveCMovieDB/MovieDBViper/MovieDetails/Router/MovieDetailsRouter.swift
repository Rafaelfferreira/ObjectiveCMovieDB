//
//  MovieDetailsRouter.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 19/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// MovieDetails Module Router (aka: Wireframe)
class MovieDetailsRouter: MovieDetailsRouterProtocol {
    class func createMovieDetailsModule(with movieDetailsRef: MovieDetailsView, and movie: Movie) {
        let presenter = MovieDetailsPresenter(view: movieDetailsRef, movie: movie)
        movieDetailsRef.presenter = presenter
        //movieDetailsRef.presenter?.view = movieDetailsRef
//        fruitDetailRef.presenter?.wireframe = FruitDetailWireFrame()
    }
}
