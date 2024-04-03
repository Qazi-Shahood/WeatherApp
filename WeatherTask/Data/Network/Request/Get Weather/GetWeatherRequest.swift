//
//  GetWeatherRequest.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation

class GetWeatherRequest: NSObject {
    
    private var requestObject: Body
    
    init(requestObject: Body) {
        self.requestObject = requestObject
    }
}

extension GetWeatherRequest: EndpointProvider {
    typealias Response = GetWeatherResponseDTO
    typealias Body = GetWeatherRequestDTO
    typealias Failure = EmptyDTO
    
    var endpoint: Endpoint<Body> {
        return Endpoint(
            baseURL: .baseWeatherUrl,
            path: ["data", "2.5", "weather"],
            method: .get,
            query: ["lat": requestObject.lat, "lon": requestObject.lon, "appid": Constants.apiKey, "units": "metric"]
        )
    }
}
