//
//  GetWeatherRepository.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation

typealias GetWeatherResult = Result<GetWeatherResponseDTO, Error>
typealias GetCityLocationsResult = Result<[GetCityLocationsResponseDTO], Error>

protocol WeatherRepository {
    func getWeatherDetails(lat: String, long: String, completion: @escaping (GetWeatherResult) -> Void)
    func getCityLocations(name: String, completion: @escaping (GetCityLocationsResult) -> Void)
}

class DefaultWeatherRepository: WeatherRepository {
    
    func getWeatherDetails(lat: String, long: String, completion: @escaping (GetWeatherResult) -> Void) {
        let requestObject = GetWeatherRequestDTO(lat: lat, lon: long)
        let request = GetWeatherRequest(requestObject: requestObject)
        DefaultNetworkManager.shared.request(request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getCityLocations(name: String, completion: @escaping (GetCityLocationsResult) -> Void) {
        let requestObject = GetCityLocationsRequestDTO(name: name)
        let request = GetCityLocationsRequest(requestObject: requestObject)
        DefaultNetworkManager.shared.request(request) { result in
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
