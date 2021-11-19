//
//  APIConfiguration.swift
//  MovieFlix
//
//  Created by Selladurai on 15/11/21.
//

import Foundation
import Alamofire

protocol APIConfiguration: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var url: URL { get }
    var parameters: [String: String] { get }
    var headers: HTTPHeaders { get }
}

extension APIConfiguration {
    var headers: HTTPHeaders {
        var tempHeaders: HTTPHeaders = HTTPHeaders()
        for (field, value) in APIConstants.headers {
            tempHeaders.add(HTTPHeader(name: field, value: value))
        }
        return tempHeaders
    }
    
    var url: URL {
        let baseURL = URL(string: APIConstants.baseURL)!
        return baseURL.appendingPathComponent(path)
    }
    
    func asURLRequest() throws -> URLRequest {
        let baseURL = URL(string: APIConstants.baseURL)!

        var urlRequest = URLRequest(url: baseURL.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue

        APIConstants.headers.forEach { (field, value) in
            urlRequest.addValue(value, forHTTPHeaderField: field)
        }

        do {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
        } catch {
            throw AFError.parameterEncoderFailed(reason: AFError.ParameterEncoderFailureReason.encoderFailed(error: error))
        }

        return urlRequest
    }
}
