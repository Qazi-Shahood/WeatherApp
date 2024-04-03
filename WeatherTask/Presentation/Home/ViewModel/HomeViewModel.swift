//
//  HomeViewModel.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation

protocol HomeViewModelDelegate: AnyObject {
    func updateWeatherDetails(result: GetWeatherResponseDTO)
    func showError(errorString: String)
}

class HomeViewModel {
    
    private let repository: WeatherRepository = DefaultWeatherRepository()
    var delegate: HomeViewModelDelegate? = nil
    
    func getWeatherDetails(lat: String, long: String) {
        repository.getWeatherDetails(lat: lat, long: long) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let result):
                    self?.delegate?.updateWeatherDetails(result: result)
                case .failure(let error):
                    self?.delegate?.showError(errorString: error.localizedDescription)
                }
            }
        }
    }
    
}
