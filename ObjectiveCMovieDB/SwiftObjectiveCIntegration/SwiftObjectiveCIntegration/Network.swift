//
//  Network.swift
//  SwiftObjectiveCIntegration
//
//  Created by Rafael Ferreira on 25/03/20.
//  Copyright © 2020 Rafael Ferreira. All rights reserved.
//

import Foundation

class NetworkHandler {
    func getPopularMovies() {
        let webService = MovieDBAPI()
        
        webService.getPopularMovies { popularMovies, error in
            if error == nil {
                let results = popularMovies?.results
                for movie in results! {
                    print(movie.title)
                }
            } else {
                print(error as Any)
            }
        }
    }
}
