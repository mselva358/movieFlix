//
//  APIConstants.swift
//  MovieFlix
//
//  Created by Selladurai on 15/11/21.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://api.themoviedb.org/3"
    static let imageBaseURL = "https://image.tmdb.org/t/p"
    static let headers: [(String, String)] = []
    static var parameters: [String:String] {
        return ["api_key":"a07e22bc18f5cb106bfe4cc1f83ad8ed"]
    }
}
