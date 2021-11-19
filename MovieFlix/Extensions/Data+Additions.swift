//
//  Data+Additions.swift
//  MovieFlix
//
//  Created by Selladurai on 15/11/21.
//

import Foundation
import UIKit

extension Data {
    var image: UIImage? {
        return UIImage(data: self)
    }
}
