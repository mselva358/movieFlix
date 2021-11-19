//
//  MovieDetailViewModel.swift
//  MovieFlix
//
//  Created by Selladurai on 19/11/21.
//

import Foundation

class MovieDetailViewModel {
    weak var controller: MovieDetailViewController!
    required init(controller: MovieDetailViewController) {
        self.controller = controller
    }
    
    func loadMovieDetail(_ movie: Movie) {
        controller?.posterImage?.loadImageFromUrlString(movie.imageUrlString ?? "")
        controller?.titleLbl?.text = movie.originalTitle
        controller?.releaseDateLbl?.text = "Release Date: " + (movie.releaseDate ?? "")
        controller?.descriptionLbl?.text = movie.overview
    }
}
