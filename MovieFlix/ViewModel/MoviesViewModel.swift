//
//  MoviesViewModel.swift
//  MovieFlix
//
//  Created by Selladurai on 11/13/21.
//

import Foundation
import UIKit

class MoviesViewModel {
    weak var controller: MoviesViewController!
    required init(controller: MoviesViewController) {
        self.controller = controller
    }
    
    var movieList: MovieList? {
        didSet {
            if #available(iOS 13.0, *) {
                controller?.updateLayout()
            } else {
                controller?.collectionView?.reloadData(with: BatchUpdates.compare(oldValues: [], newValues: self.movieList?.results ?? []))
            }
        }
    }
    
    
    var actualMovieList: MovieList? {
        didSet {
            self.movieList = actualMovieList
        }
    }
    
    var currentPage = 1
    
    func fetchMovies() {
        let parameters: [String: String] = ["page": "\(currentPage)"]
        MovieAPIManager.nowPlayingMovies(parameters: parameters) { [weak self] result in
            if (self?.currentPage ?? 0) <= 1 {
                self?.actualMovieList = result
            } else {
                self?.actualMovieList?.results?.append(contentsOf: result?.results ?? [])
                self?.movieList = self?.actualMovieList
            }
        }
    }
    
    func generateCellForItemAtIndexPath(_ indexPath: IndexPath) -> UICollectionViewCell {
        let movie = self.movieList?.results?[indexPath.item]
        if movie?.isPopular == false {
            let cell = controller?.collectionView.dequeueReusableCell(withReuseIdentifier: "TrailerCollectionViewCell", for: indexPath) as! TrailerCollectionViewCell
            cell.trailer = movie
            cell.didRequestToDeleteTrailer = { [weak self] trailer in
                if let index = self?.movieList?.results?.firstIndex(of: trailer) {
                    self?.movieList?.results?.remove(at: index)
                }
                if #available(iOS 13.0, *) {
                    guard let indexPath = self?.controller?.collectionView.indexPath(for: cell), let diffableDatasource = (self?.controller.dataSource as? UICollectionViewDiffableDataSource<MoviesViewController.Section, Movie>),
                          let objectIClickedOnto = diffableDatasource.itemIdentifier(for: indexPath) else { return }
                    var snapshot = diffableDatasource.snapshot()
                    snapshot.deleteItems([objectIClickedOnto])
                    diffableDatasource.apply(snapshot, animatingDifferences: true, completion: nil)
                } else {
                    self?.controller.collectionView?.performBatchUpdates({ [weak self] in
                        self?.controller?.collectionView.deleteItems(at: [indexPath])
                    })
                }
            }
            return cell
        } else {
            let cell = controller?.collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
            cell.movie = movie
            cell.didRequestToDeleteMovie = { [weak self] delMovie in
                if let index = self?.movieList?.results?.firstIndex(of: delMovie) {
                    self?.movieList?.results?.remove(at: index)
                }
                if #available(iOS 13.0, *) {
                    guard let indexPath = self?.controller?.collectionView.indexPath(for: cell), let diffableDatasource = (self?.controller.dataSource as? UICollectionViewDiffableDataSource<MoviesViewController.Section, Movie>),
                          let objectIClickedOnto = diffableDatasource.itemIdentifier(for: indexPath) else { return }
                    var snapshot = diffableDatasource.snapshot()
                    snapshot.deleteItems([objectIClickedOnto])
                    diffableDatasource.apply(snapshot, animatingDifferences: true, completion: nil)
                } else {
                    self?.controller.collectionView?.performBatchUpdates({ [weak self] in
                        self?.controller?.collectionView.deleteItems(at: [indexPath])
                    })
                }
            }
            return cell
        }
    }
    
    func sizeForItemAtIndexPath(_ indexPath: IndexPath) -> CGSize {
        var size = controller?.collectionView.bounds.size ?? .zero
        let movie = self.movieList?.results?[indexPath.item]
        size.width = UIScreen.main.bounds.width
        size.height = movie?.isPopular == false ? ((size.width / 16.0) * 12.0) : ((size.width / 16.0) * 9.0)
        return size
    }
    
    func showMovieDetail(_ movie: Movie) {
        let movieDetailVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetailVC.movie = movie
        self.controller?.present(movieDetailVC, animated: true, completion: nil)
    }
    
    func filterMoviesByTitle(_ title: String) {
        var movies = (self.actualMovieList?.results ?? [])
        if title.isEmpty {
            self.movieList?.results = movies
        } else {
            movies = movies.filter{$0.originalTitle?.lowercased().contains(title.lowercased()) == true}
            self.movieList?.results = movies
        }
        if #available(iOS 13.0, *) {
            self.controller.updateLayout()
        } else {
            controller?.collectionView?.reloadData(with: BatchUpdates.compare(oldValues: [], newValues: self.movieList?.results ?? []))
        }
    }
}
