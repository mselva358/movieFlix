//
//  MovieDetailViewController.swift
//  MovieFlix
//
//  Created by Selladurai on 19/11/21.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var releaseDateLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var movie: Movie!
    
    var viewModel: MovieDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = MovieDetailViewModel(controller: self)
        
        self.viewModel.loadMovieDetail(self.movie)
        
    }
    
}
