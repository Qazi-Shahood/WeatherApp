//
//  Network.swift
//  PhotoApp
//
//  Created by Muhammad Raza on 07/11/2022.
//

import Foundation

protocol NetworkManager {
    func request<E: EndpointProvider>(_ request: E, completion: @escaping (Result<E.Response, NetworkError>) -> Void)
}

final class DefaultNetworkManager: NetworkManager {
    private let sessionStore: SessionManagerStore
    private let jsonDecoder = JSONDecoder()
    
    public static let shared: DefaultNetworkManager = .init()
    
    private init(sessionStore: SessionManagerStore = .init()) {
        self.sessionStore = sessionStore
    }
    
    func request<E>(_ request: E, completion: @escaping (Result<E.Response, NetworkError>) -> Void) where E : EndpointProvider {
       
        let endpoint = request.endpoint
        let manager = sessionStore.sessionManager(for: endpoint.baseURL)
       
        guard let urlRequest = try? endpoint.urlRequest() else {
            return completion(.failure(.encodingError))
        }
        
        let task = manager.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                completion(.failure(.server(data, error)))
            } else if let data = data {
                do {
                    let response = try self.jsonDecoder.decode(E.Response.self, from: data)
                    completion(.success(response))
                } catch let err {
                    completion(.failure(.decoding(data, err)))
                }
            } else {
                completion(.failure(.somethingUnexpected))
            }
        }

       task.resume()
   }
}
