//
//  MockNetworkingLayer.swift
//  WeatherTaskTests
//
//  Created by qms on 22/03/2024.
//

import Foundation
@testable import WeatherTask

final class MockNetworkLayer: NetworkManager {
    
    let jsonDecoder = JSONDecoder()
    
    func request<E>(_ request: E, completion: @escaping (Result<E.Response, NetworkError>) -> Void) where E : EndpointProvider {
        var error: Error? = NetworkError.somethingUnexpected
        var data: Data? = nil
        
        if request is GetWeatherRequest {
            if let url = Bundle(for: type(of: self)).url(forResource: "weather_details", withExtension: "json"),
               let jsonData = try? Data(contentsOf: url) {
                data = jsonData
                error = nil
            }
        }
        
        if let error {
            completion(.failure(.server(data, error)))
        } else if let data {
            do {
                let response = try self.jsonDecoder.decode(E.Response.self, from: data)
                completion(.success(response))
            } catch let error {
                completion(.failure(.decoding(data, error)))
            }
        } else {
            completion(.failure(.somethingUnexpected))
        }
    }
    
}
