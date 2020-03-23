//
//  ShowMoviesPresenter.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 20/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// ShowMovies Module Presenter
class ShowMoviesPresenter {
    
    weak private var _view: ShowMoviesViewProtocol?
    private var interactor: ShowMoviesInteractorProtocol
    private var wireframe: ShowMoviesRouterProtocol
    var currentPage = 1
    var movies: [Movie] = []
    var text: String?
    
    init(view: ShowMoviesViewProtocol, movies: [Movie]) {
        self.movies = movies
        self._view = view
        self.interactor = ShowMoviesInteractor()
        self.wireframe = ShowMoviesRouter()
    }
    
    init(view: ShowMoviesViewProtocol, text: String) {
        self.text = text
        self._view = view
        self.interactor = ShowMoviesInteractor()
        self.wireframe = ShowMoviesRouter()
    }
}

// MARK: - extending ShowMoviesPresenter to implement it's protocol
extension ShowMoviesPresenter: ShowMoviesPresenterProtocol {
    func getNextPage() {
        currentPage += 1
        interactor.getNowPlayingMovies(page: currentPage, presenter: self)
    }
    
    func showMovieDetails(with movie: Movie, from view: UIViewController) {
        wireframe.pushToMovieDetails(with: movie, from: view)
    }
    
    func viewDidInitAllMovies() {
        _view?.set(movies: movies)
    }
    
    func viewDidInitSearch() {
        interactor.search(text: text!, presenter: self)
    }
    
    func searchDidFetch(movies: [Movie]?, error: Error?) {
        if error == nil && !(movies?.isEmpty ?? true) {
            _view?.set(movies: movies!)
        }
        else {
            _view?.set(movies: [])
        }
    }
    
    func nowPlayingMoviesDidFetch(movies: [Movie]?, error: Error?) {
        if error == nil && !(movies?.isEmpty ?? true) {
            self.movies = self.movies + movies!
            _view?.set(movies: self.movies)
        }
    }
}
