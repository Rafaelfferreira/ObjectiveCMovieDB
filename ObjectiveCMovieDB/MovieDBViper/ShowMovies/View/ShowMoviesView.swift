//
//  ShowMoviesView.swift
//  MovieDBViper
//
//  Created Pedro Enrique Sobrosa Lopes on 20/08/19.
//  Copyright © 2019 Pedro. All rights reserved.
//

import UIKit

/// ShowMovies Module View
class ShowMoviesView: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    @IBOutlet weak var noResultsView: UIView!
    
    private var presenter: ShowMoviesPresenterProtocol!
    
    var movies: [Movie]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        noResultsView.isHidden = true
    }
    
    func initMoviesViewAllMovies(presenter: ShowMoviesPresenter) {
        self.presenter = presenter
        presenter.viewDidInitAllMovies()
    }
    
    func initMoviesViewSearch(presenter: ShowMoviesPresenter) {
        self.presenter = presenter
        collectionView.isHidden = true
        presenter.viewDidInitSearch()
    }
    
}

// MARK: - extending ShowMoviesView to implement it's protocol
extension ShowMoviesView: ShowMoviesViewProtocol {
    func set(movies: [Movie]) {
        self.movies = movies
        DispatchQueue.main.async {
            if movies.count > 0 {
                self.noResultsView.isHidden = true
                self.collectionView.isHidden = false
            }
            else {
                self.noResultsView.isHidden = false
                self.collectionView.isHidden = true
            }
            self.collectionView.reloadData()
        }
    }
}

extension ShowMoviesView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if movies?.count ?? 0 > indexPath.row {
            if indexPath.row == movies!.count - 1 {
                presenter.getNextPage()
            }
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "moviesViewCell", for: indexPath) as? MoviesCollectionViewCell {
                cell.movieCover.image = UIImage(data: movies![indexPath.row].coverData!)
                cell.movieCover.layer.cornerRadius = 10
                cell.movieRating.text = movies![indexPath.row].ratings?.description
                cell.movieTitle.text = movies![indexPath.row].title
                return cell
            }
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "nowPlayingHeader", for: indexPath) as? NowPlayingCollectionReusableView{
            sectionHeader.sectionHeaderLabel.text = "Showing \(movies?.count ?? 0) results"
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}

extension ShowMoviesView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.showMovieDetails(with: movies![indexPath.row], from: self)
    }
}
