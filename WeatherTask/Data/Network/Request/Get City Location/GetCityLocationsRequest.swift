//
//  GetCityLocationsRequest.swift
//  WeatherTask
//
//  Created by qms on 22/03/2024.
//

import Foundation

class GetCityLocationsRequest: NSObject {
    
    private var requestObject: Body
    
    init(requestObject: Body) {
        self.requestObject = requestObject
    }
}

extension GetCityLocationsRequest: EndpointProvider {
    typealias Response = [GetCityLocationsResponseDTO]
    typealias Body = GetCityLocationsRequestDTO
    typealias Failure = EmptyDTO
    
    var endpoint: Endpoint<Body> {
        return Endpoint(
            baseURL: .baseWeatherUrl,
            path: ["geo", "1.0", "direct"],
            method: .get,
            query: ["q": requestObject.name, "limit": "5", "appid": Constants.apiKey]
        )
    }
}
