//
//  MovieCollectionViewCell.swift
//  MovieFlix
//
//  Created by Selladurai on 20/11/21.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var thumbnailView: UIImageView!
    
    @IBAction func deleteMovie(_ sender: UIButton) {
        didRequestToDeleteMovie?(self.movie)
    }
    
    var didRequestToDeleteMovie: ((Movie)->Void)?
    
    var movie: Movie! {
        didSet {
            self.thumbnailView?.loadImageFromUrlString(movie.imageUrlString ?? "")
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailView?.image = nil
    }
}
