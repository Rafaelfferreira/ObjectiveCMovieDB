//
//  ShowMoviesInteractor.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 20/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// ShowMovies Module Interactor
class ShowMoviesInteractor: ShowMoviesInteractorProtocol {
    func getNowPlayingMovies(page: Int, presenter: ShowMoviesPresenterProtocol) {
        let webService = MovieDBAPI()
        
        webService.getNowPlayingMovies(page) { nowPlayingMovies, error in
            if let error = error {
                presenter.nowPlayingMoviesDidFetch(movies: nil, error: error)
            }
            else if let nowPlayingMovies = nowPlayingMovies {
                var movies: [Movie] = []
                nowPlayingMovies.results.forEach {
                    let data =
                        webService.getCoverFrom($0.posterPath)
                    if data != nil {
                        movies.append(Movie(id: nil, coverData: data, title: $0.title, ratings: $0.voteAverage, overview: $0.overview, genresIds: $0.genreIDS))
                    }
                }
                presenter.nowPlayingMoviesDidFetch(movies: movies, error: nil)
            }
        }
    }
    
    func search(text: String, presenter: ShowMoviesPresenterProtocol) {
        let webService = MovieDBAPI()
        
        webService.search(text) { data, error in
            if let error = error {
                presenter.searchDidFetch(movies: nil, error: error)
            }
            else if let data = data {
                var movies: [Movie] = []
                data.results.forEach {
                    let data = webService.getCoverFrom($0.posterPath)
                    if data != nil {
                        movies.append(Movie(id: nil, coverData: data, title: $0.title, ratings: $0.voteAverage, overview: $0.overview, genresIds: $0.genreIDS))
                    }
                }
                presenter.searchDidFetch(movies: movies, error: nil)
            }
        }
    }
}
