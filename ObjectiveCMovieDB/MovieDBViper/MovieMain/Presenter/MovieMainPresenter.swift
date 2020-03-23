//
//  MovieMainPresenter.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 14/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// MovieMain Module Presenter
class MovieMainPresenter: MovieMainPresenterProtocol {
    
    weak private var _view: MovieMainViewProtocol?
    private var interactor: MovieMainInteractorProtocol
    private var wireframe: MovieMainRouterProtocol
    private var nowPlayingRequestError = false
    private var popularRequestError = false
    private var firstRequestReady = false
    
    
    init(view: MovieMainViewProtocol) {
        self._view = view
        self.interactor = MovieMainInteractor()
        self.wireframe = MovieMainRouter()
    }
    
    func showMovieDetails(with movie: Movie, from view: UIViewController) {
        wireframe.pushToMovieDetails(with: movie, from: view)
    }
    
    func showAll(nowPlayingMovies: [Movie], from view: UIViewController) {
        wireframe.pushToAllNowPlayingMovies(with: nowPlayingMovies, from: view)
    }

    func viewDidLoad() {
//        if interactor.isConnectedToNetwork() {
//            self.loadMovieLists()
//        }
//        else {
//            _view?.notConnected()
//        }
        self.loadMovieLists()
    }
    
    func loadMovieLists() {
        interactor.getNowPlayingMovies(presenter: self)
        interactor.getPopularMovies(presenter: self)
    }
    
    func popularMoviesDidFetch(popularMovies: [Movie]?, error: Error?) {
        if error != nil || popularMovies?.isEmpty ?? true{
            popularRequestError = true
        }
        else {
            let allNowPlayingMovies = _view?.getNowPlayingMovies()
            var movies = popularMovies!.sorted(by: {$0.ratings! > $1.ratings! })
            if allNowPlayingMovies != nil {
                var nowPlayingMovies: [Movie] = []
                for i in 0 ... (allNowPlayingMovies!.count > 5 ? 4 : allNowPlayingMovies!.count - 1){
                    nowPlayingMovies.append(allNowPlayingMovies![i])
                }
                movies = movies.filter() {
                    var haveEqual = false
                    for i in 0 ... nowPlayingMovies.count - 1{
                        if $0.id == nowPlayingMovies[i].id {
                            haveEqual = true
                        }
                    }
                    return !haveEqual
                }
            }
            _view?.set(popularMovies: movies)
        }
        fetchRequest()
    }
    
    func nowPlayingMoviesDidFetch(nowPlayingMovies: [Movie]?, error: Error?) {
        if error != nil || nowPlayingMovies?.isEmpty ?? true{
            nowPlayingRequestError = true
        }
        else {
            _view?.set(nowPlayingMovies: nowPlayingMovies!)
        }
        fetchRequest()
    }
    
    func fetchRequest() {
        if !firstRequestReady {
            firstRequestReady = true
        }
        else {
            if nowPlayingRequestError && popularRequestError {
                _view?.error()
            }
            else {
                if nowPlayingRequestError {
                   _view?.set(numberOfSections: 2)
                }
                else {
                    _view?.set(numberOfSections: 3)
                }
                _view?.loadData()
            }
        }
    }
    
    func totalError() -> Bool {
        return popularRequestError && nowPlayingRequestError
    }
    
    func searchMovies(_ text: String, view: UIViewController) {
        wireframe.showContainer(with: text, from: view)
    }
    
}
