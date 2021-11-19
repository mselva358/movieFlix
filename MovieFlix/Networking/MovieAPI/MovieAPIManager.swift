//
//  MovieAPIManager.swift
//  MovieFlix
//
//  Created by Selladurai on 15/11/21.
//

import Foundation
import Alamofire

class MovieAPIManager {
    struct MovieConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .get
        var path = "/movie/now_playing"
    }
    
    class func nowPlayingMovies(parameters: [String: String] = [:], completionHandler : @escaping(_ result: MovieList?) -> Void) {
        var config = MovieConfig()
        var updatedParameters = APIConstants.parameters
        updatedParameters += parameters
        config.parameters = updatedParameters
        APIClient.codableAPIRequest(request: config) { (result: MovieList?) in
            completionHandler(result)
        }
    }
    
    struct VideosConfig: APIConfiguration {
        var parameters: [String : String] = [:]
        var method: HTTPMethod = .get
        var path = "/movie"
    }
    
    class func videosFromMovie(id: String, parameters: [String: String] = [:], completionHandler : @escaping(_ result: VideoList?) -> Void) {
        var config = VideosConfig()
        var updatedParameters = APIConstants.parameters
        updatedParameters += parameters
        config.parameters = updatedParameters
        config.path += (id+"/videos")
        APIClient.codableAPIRequest(request: config) { (result: VideoList?) in
            completionHandler(result)
        }
    }
}
