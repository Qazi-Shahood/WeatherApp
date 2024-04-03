//
//  MockGetWeatherRepositoryTest.swift
//  WeatherTaskTests
//
//  Created by qms on 23/03/2024.
//

import Foundation
import XCTest
@testable import WeatherTask

final class MockGetWeatherRepositoryTest: XCTestCase {
    
    func testGetWeather() throws {
        
        let expectation = expectation(description: "DefaultGetWeatherRepository getWeatherDetails should return success")
        
        let repository = DefaultWeatherRepository()
        
        repository.getWeatherDetails(lat: "44.34", long: "44.34") { result in
            switch result {
            case .success(let response):
                let lat = response.weather.first?.id ?? 0
                XCTAssertTrue(lat == 804, "Weather Id unmatched")
            case .failure(_):
                XCTAssertTrue(false, "This should not return failure")
            }
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 3)
        
    }
    
}
