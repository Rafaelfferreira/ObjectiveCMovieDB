//
//  MovieDetailsContracts.swift
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
/// MovieDetails Module View Protocol
protocol MovieDetailsViewProtocol: class {
    // Update UI with value returned.
    func showMovieDetails(movie: Movie)
    func set(genres: String)
}

//MARK: Interactor -
/// MovieDetails Module Interactor Protocol
protocol MovieDetailsInteractorProtocol {
    func getMovieDetail(movie: Movie, presenter: MovieDetailsPresenterProtocol)
}

//MARK: Presenter -
/// MovieDetails Module Presenter Protocol
protocol MovieDetailsPresenterProtocol {
    func viewDidLoad()
    func genresDidFetch(genres: [GenreEntity]?, error: Error?)
}

//MARK: Router (aka: Wireframe) -
/// MovieDetails Module Router Protocol
protocol MovieDetailsRouterProtocol {
    // Show Details of Entity Object coming from ParentView Controller.

}
