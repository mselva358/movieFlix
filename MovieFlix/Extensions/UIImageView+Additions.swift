//
//  UIImageView+Additions.swift
//  MovieFlix
//
//  Created by Selladurai on 15/11/21.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageFromUrlString(_ string: String = "") {
        if let image = ImageDAO.shared.externallyStoredImage(by: string)?.blob?.image {
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        } else {
            if let url = URL(string: string) {
                self.getData(from: url) { [weak self] (data, res, error) in
                    if let imageData = data, let img = imageData.image {
                        _ = ImageDAO.shared.makeExternallyStoredImage(img, url: string)
                        DispatchQueue.main.async { [weak self] in
                            self?.image = img
                        }
                    }
                }
            }
        }
    }
    
    private func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
