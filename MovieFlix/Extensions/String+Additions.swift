//
//  String+Additions.swift
//  MovieFlix
//
//  Created by Selladurai on 15/11/21.
//

import Foundation

extension String {
    var backDropImageUrlString: String {
        return APIConstants.imageBaseURL+"/w780"+self
    }
    var posterImageUrlString: String {
        return APIConstants.imageBaseURL+"/w185"+self
    }
}
