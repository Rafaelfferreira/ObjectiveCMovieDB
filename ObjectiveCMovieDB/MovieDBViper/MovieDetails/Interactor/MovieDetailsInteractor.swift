//
//  MovieDetailsInteractor.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 19/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// MovieDetails Module Interactor
class MovieDetailsInteractor: MovieDetailsInteractorProtocol {
    func getMovieDetail(movie: Movie, presenter: MovieDetailsPresenterProtocol) {
//        WebService.sharedService.getMovieDetails(movieId: movie.id!) { details, error in
//            if let error = error {
//                presenter.genresDidFetch(genres: nil, error: error)
//            }
//            else if let details = details {
//                var genres: [GenreEntity] = []
//                details.genres?.forEach {
//                    genres.append(GenreEntity(id: $0.id, name: $0.name))
//                }
//                presenter.genresDidFetch(genres: genres, error: nil)
//            }
//        }
        let webService = MovieDBAPI()
        let movieQTResult = QTResult()
        movieQTResult.genreIDS = movie.genresIds
        webService.getMovieGenres(movieQTResult) { genres, error in
            if let error = error {
                presenter.genresDidFetch(genres: nil, error: error)
            } else if let genres = genres as? [String] {
                var genresEntity: [GenreEntity] = []
                genres.forEach{
                    genresEntity.append(GenreEntity(id: nil, name: $0))
                }
                presenter.genresDidFetch(genres: genresEntity, error: nil)
            }
        }
    }
    

}
