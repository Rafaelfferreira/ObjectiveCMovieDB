//
//  MovieMainInteractor.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 14/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import Foundation

/// MovieMain Module Interactor
class MovieMainInteractor: MovieMainInteractorProtocol {
    
    typealias CoverCompletionBlock = ( _ data: Data?, _ error: Error?) -> Void
    
//    func isConnectedToNetwork() -> Bool {
//        return WebService.sharedService.isConnectedToNetwork()
//    }
    
    func getPopularMovies(presenter: MovieMainPresenterProtocol) {
        let webService = MovieDBAPI()
        webService.getPopularMovies { popularMovies, error in
            if let error = error {
                presenter.popularMoviesDidFetch(popularMovies: nil, error: error)
            }
            else if let popularMovies = popularMovies {
                var movies: [Movie] = []
                popularMovies.results.forEach {
                    let data = webService.getCoverFrom($0.posterPath)
                    if data != nil {
                        movies.append(Movie(id: nil, coverData: data, title: $0.title, ratings: $0.voteAverage, overview: $0.overview, genresIds: $0.genreIDS))
                    }
                }
                presenter.popularMoviesDidFetch(popularMovies: movies, error: nil)
            }
        }
    }
    
    func getNowPlayingMovies(presenter: MovieMainPresenterProtocol) {
        let webService = MovieDBAPI()
        webService.getNowPlayingMovies(1) { nowPlayingMovies, error in
            if let error = error {
                presenter.nowPlayingMoviesDidFetch(nowPlayingMovies: nil, error: error)
            }
            else if let nowPlayingMovies = nowPlayingMovies {
                var movies: [Movie] = []
                nowPlayingMovies.results.forEach {
                    let data = webService.getCoverFrom($0.posterPath)
                    if data != nil {
                        movies.append(Movie(id: nil, coverData: data, title: $0.title, ratings: $0.voteAverage, overview: $0.overview, genresIds: $0.genreIDS))
                    }
                }
                presenter.nowPlayingMoviesDidFetch(nowPlayingMovies: movies, error: nil)
            }
        }
    }

}
