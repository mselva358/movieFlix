//
//  APIClient.swift
//  MovieFlix
//
//  Created by Selladurai on 15/11/21.
//

import Foundation
import Alamofire

class APIClient {
    class func codableAPIRequest<T>(request: APIConfiguration, completionHandler: @escaping(_ result: T?) -> Void) where T:Codable {
        AF.request(
            request.url,
            method: request.method,
            parameters: request.parameters,
            encoding: URLEncoding.default,
            headers: request.headers
        ).validate(statusCode: 200..<500)
        .responseDecodable { (response: DataResponse<T, AFError>) in
            switch response.response?.statusCode {
            case 401:
                break
            default:
                switch response.result {
                case .success(let data):
                    completionHandler(data)
                case .failure( _):
                    break
                }
            }
        }
    }
    
}
