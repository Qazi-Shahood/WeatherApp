//
//  SearchViewModedl.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation

protocol SearchViewModelDelegate: AnyObject {
    func showError(errorString: String)
    func reloadData()
}

class SearchViewModel {
    
    private let repository: WeatherRepository = DefaultWeatherRepository()
    
    weak var delegate: SearchViewModelDelegate? = nil
    var isSearchActive = false
    
    private(set) var cityList: [GetCityLocationsResponseDTO] = [] {
        didSet {
            DispatchQueue.main.async {
                self.delegate?.reloadData()
            }
        }
    }
    
    func getCityNames(for text: String) {
        repository.getCityLocations(name: text) { [weak self] response in
            guard let self,
                  self.isSearchActive  else { return }
            DispatchQueue.main.async {
                switch response {
                case .success(let result):
                    self.cityList = result
                case .failure(let error):
                    self.delegate?.showError(errorString: error.localizedDescription)
                }
            }
        }
    }
    
    func clearData() {
        cityList = []
    }
    
}
