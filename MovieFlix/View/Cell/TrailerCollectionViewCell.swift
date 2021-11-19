//
//  TrailerCollectionViewCell.swift
//  MovieFlix
//
//  Created by Selladurai on 20/11/21.
//

import Foundation
import UIKit

class TrailerCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBAction func deleteTrailer(_ sender: UIButton) {
        didRequestToDeleteTrailer?(trailer)
    }
    
    var didRequestToDeleteTrailer: ((Movie)->Void)?
    
    var trailer: Movie! {
        didSet {
            self.posterImage?.loadImageFromUrlString(trailer?.imageUrlString ?? "")
            self.titleLbl?.text = trailer?.originalTitle
            self.descriptionLbl?.text = trailer?.overview
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.posterImage?.image = nil
        self.titleLbl?.text = nil
        self.descriptionLbl?.text = nil
    }
}
