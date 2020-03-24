//
//  MovieDetailsPresenter.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 19/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// MovieDetails Module Presenter
class MovieDetailsPresenter {
    
    weak private var _view: MovieDetailsViewProtocol?
    private var interactor: MovieDetailsInteractorProtocol
    private var wireframe: MovieDetailsRouterProtocol
    var movie: Movie?
    
    init(view: MovieDetailsViewProtocol, movie: Movie?) {
        self.movie = movie
        _view = view
        self.interactor = MovieDetailsInteractor()
        self.wireframe = MovieDetailsRouter()
    }
    
    func viewDidLoad() {
        _view?.showMovieDetails(movie: movie!)
        interactor.getMovieDetail(movie: movie!, presenter: self)
    }
    
    func genresDidFetch(genres: [GenreEntity]?, error: Error?) {
        if error != nil || genres?.isEmpty ?? true {
            _view?.set(genres: "")
        }
        else {
            let genresString = genres!
                .map { $0.name ?? "" }
                .joined(separator: ", ")
            _view?.set(genres: genresString)
        }
    }
}

// MARK: - extending MovieDetailsPresenter to implement it's protocol
extension MovieDetailsPresenter: MovieDetailsPresenterProtocol {

}
