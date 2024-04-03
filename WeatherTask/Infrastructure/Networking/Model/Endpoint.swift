//
//  Endpoint.swift
//  PhotoApp
//
//  Created by Muhammad Raza on 07/11/2022.
//

import Foundation

public struct BaseURL {
    let scheme: String
    let host: String
    let port: Int?

    public init(scheme: String, host: String, port: Int? = nil) {
        self.scheme = scheme
        self.host = host
        self.port = port
    }
}

struct Endpoint<Body: DTO> {
    let method: HTTPMethod
    let baseURL: BaseURL
    let path: [String]
    let body: Body?
    let query: [String: String]
    
    public init(baseURL: BaseURL, path: [String] = [], body: Body? = nil, method: HTTPMethod, query: [String: String] = [:] ) {
        self.baseURL = baseURL
        self.path = path
        self.body = body
        self.method = method
        self.query = query
    }
    
    var url: URL {
        var components = URLComponents()
        components.scheme = baseURL.scheme
        components.host = baseURL.host
        components.port = baseURL.port
        components.path = "/" + (path).joined(separator: "/")
        if query.count > 0 {
            components.queryItems = query.map { URLQueryItem(name: $0, value: $1) }
        }
        
        return components.url!
    }
    
    func urlRequest() throws -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue.uppercased()
        
        if let body = body {
            let encoder = JSONEncoder()
            
            request.httpBody = try encoder.encode(body)
            print(String.init(data: request.httpBody!, encoding: .utf8) ?? "")
        }
        
        return request
    }
}

enum HTTPMethod: String {
    case get = "GET"
}
