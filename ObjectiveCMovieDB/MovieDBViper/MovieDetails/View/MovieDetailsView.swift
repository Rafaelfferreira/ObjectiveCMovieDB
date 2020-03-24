//
//  MovieDetailsView.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 19/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// MovieDetails Module View
class MovieDetailsView: UIViewController {
    
    var presenter: MovieDetailsPresenterProtocol!
    
    //private var object : Genre?
    
    @IBOutlet weak var movieCover: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieGenres: UILabel!
    @IBOutlet weak var movieRatings: UILabel!
    @IBOutlet weak var movieDetails: UITextView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    var closure: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.title = "Movie Details"
        navigationItem.largeTitleDisplayMode = .never
        presenter?.viewDidLoad()
        
        closure = {
            print(self)
        }
        
    }
    
}

// MARK: - extending MovieDetailsView to implement it's protocol
extension MovieDetailsView: MovieDetailsViewProtocol {
    func showMovieDetails(movie: Movie) {
        movieCover.image = UIImage(data: movie.coverData!)
        movieCover.layer.cornerRadius = 10
        movieTitle.text = movie.title
        movieRatings.text = movie.ratings?.description
        movieDetails.text = movie.overview
    }
    
    func set(genres: String) {
        DispatchQueue.main.async {
            self.movieGenres.text = genres
            self.spinner.stopAnimating()
        }
    }
}

